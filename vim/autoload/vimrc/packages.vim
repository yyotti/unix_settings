let s:save_cpo = &cpoptions
set cpoptions&vim

let s:plugins = {}
let s:installed_plugins = []

let s:default_options = {
      \   'condition': 1,
      \   'depends': [],
      \   'path': '',
      \ }

let s:jobs = {}

let s:default_max_thread_cnt = 2

function! vimrc#packages#begin(...) abort "{{{
  let s:plugins = {}

  if v:version < 800 || !has('patch-8.0.308')
    let &runtimepath = join(
          \   map(
          \     split(&runtimepath, ','),
          \     { _, p -> resolve(fnamemodify(p, ':p')) }
          \   ),
          \   ','
          \ )
    let &packpath = join(
          \   map(
          \     split(&packpath, ','),
          \     { _, p -> resolve(fnamemodify(p, ':p')) }
          \   ),
          \   ','
          \ )
  endif

  let s:packpath = get(a:000, 0, get(split(&packpath, ','), 0, ''))
  if empty(s:packpath)
    call vimrc#utils#error('Invalid packpath: ' . s:packpath)
    return 0
  endif
  execute 'set packpath+=' . s:packpath

  if exists('g:did_load_filetypes') || has('nvim')
    filetype off
  endif
  if exists('b:did_indent') || exists('b:did_ftplugin')
    filetype plugin indent off
  endif

  autocmd MyAutocmd VimEnter *
        \ call timer_start(1, function('vimrc#packages#load_plugins'))

  augroup plugin-packages
    autocmd!
  augroup END

  return 1
endfunction "}}}

function! vimrc#packages#end() abort "{{{
  " Do nothing
endfunction "}}}

function! vimrc#packages#add(plugin, ...) abort "{{{
  if a:plugin !~# '[^/]\+/[^/]\+'
    return {}
  endif

  let name = split(a:plugin, '/')[1]

  let options =
        \ extend(copy(s:default_options), s:check_options(a:000), 'force')

  let options.name = name
  let options.fullname = a:plugin

  let options.rtp = vimrc#utils#join_path(
        \   resolve(expand(s:packpath)),
        \   'pack/bundle/opt',
        \   name,
        \   options.path
        \ )

  let options.url =
        \ vimrc#utils#join_path('https://github.com', a:plugin) . '.git'

  if has_key(s:plugins, a:plugin)
    let s:plugins[a:plugin] =
          \ extend(copy(s:plugins[a:plugin]), options, 'force')
  else
    let s:plugins[a:plugin] = options
  endif

  return s:plugins[a:plugin]
endfunction "}}}

function! vimrc#packages#post_add() abort "{{{
  for plugin in keys(s:plugins)
    call s:call_hook(plugin, 'post_add')
  endfor
endfunction "}}}

function! vimrc#packages#get(plugin) abort "{{{
  return get(s:plugins, a:plugin, {})
endfunction "}}}

function! vimrc#packages#load_plugins(...) abort "{{{
  let s:plugins = s:remove_disabled_plugins(s:plugins)

  let installed = vimrc#packages#install(0)

  for plugin in keys(s:plugins)
    call s:call_hook(plugin, 'pre_add')
  endfor

  let dependencies = s:flatten(
        \   map(
        \     filter(values(s:plugins), { _, op -> !empty(op.depends) }),
        \     { _, op -> op.depends }
        \   )
        \ )
  for plugin in dependencies
    execute 'packadd!' s:plugins[plugin].name
  endfor

  let s:loding_plugins = {}
  for plugin in keys(s:plugins)
    call timer_start(1, function('s:packadd', [ plugin, 0 ]))
    let s:loding_plugins[plugin] = 1
  endfor
endfunction "}}}

function! vimrc#packages#filetype_on(...) abort "{{{
  if execute('filetype') =~# 'OFF'
    filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction "}}}

function! vimrc#packages#install(force, ...) abort "{{{
  if a:0 ==# 0
    let plugins = keys(s:plugins)
  else
    let plugins = filter(copy(a:000), { _, val -> has_key(s:plugins, val) })
  endif

  if !a:force
    let plugins =
          \ filter(plugins, { _, val -> !isdirectory(s:plugins[val].rtp) })
  endif

  let cnt = len(plugins)
  if cnt == 0
    return 0
  endif

  let mode = a:force ? 'Reinstall' : 'Install'
  echomsg mode cnt 'plugins'

  let s:jobs = {}
  let idx = 0
  let s:installed_plugins = []
  for p in plugins
    let idx += 1
    if a:force && delete(s:plugins[p].rtp, 'rf') < 0
      let s:jobs[idx * -1] = {
            \   'progress': 'install',
            \   'total': cnt,
            \   'plugin': p,
            \   'status': 'error',
            \   'msg': [ 'Cannot delete [' . s:plugins[p].rtp . '].' ],
            \ }
      continue
    endif

    let cmd = [
          \   'git',
          \   'clone',
          \   '--quiet',
          \   s:plugins[p].url,
          \   s:plugins[p].rtp,
          \ ]
    let options = {
          \   'on_stderr': function('s:on_stderr'),
          \   'on_exit': function('s:on_exit'),
          \ }
    let job_id = vimrc#packages#job#start(cmd, options)
    if job_id > 0
      let s:jobs[job_id] = {
            \   'progress': 'install',
            \   'total': cnt,
            \   'plugin': p,
            \   'status': 'running',
            \   'msg': [],
            \ }
    else
      let s:plugins[p].condition = 0
      let s:jobs[idx * -1] = {
            \   'progress': 'install',
            \   'total': cnt,
            \   'plugin': p,
            \   'status': 'error',
            \   'msg': [ 'Cannot start job' ],
            \ }
    endif

    while len(filter(copy(s:jobs), { _, job -> job.status ==# 'running' }))
          \ >= get(g:, 'max_thread_cnt', s:default_max_thread_cnt)
      sleep 1m
    endwhile
  endfor

  while len(filter(copy(s:jobs), { _, job -> job.status ==# 'running' })) > 0
    sleep 1m
  endwhile

  for job in filter(values(s:jobs), { _, job -> job.status ==# 'error' })
    call vimrc#utils#error(printf('[%s]', job.plugin))
    for line in job.msg
      call vimrc#utils#error(printf('  %s', line))
    endfor
  endfor

  let s:plugins = s:remove_disabled_plugins(s:plugins)

  return s:installed_plugins
endfunction "}}}

function! vimrc#packages#update(...) abort "{{{
  if a:0 ==# 0
    let plugins = keys(s:plugins)
  else
    let plugins = filter(copy(a:000), { _, val -> has_key(s:plugins, val) })
  endif

  let plugins = filter(
        \   plugins,
        \   { _, val ->
        \     isdirectory(vimrc#utils#join_path(s:plugins[val].rtp, '.git')) }
        \ )

  let cnt = len(plugins)
  if cnt == 0
    return 0
  endif

  echomsg 'Update' cnt 'plugins'

  let s:update_total = cnt
  let s:jobs = {}
  let idx = 0
  for p in plugins
    let idx += 1

    let rtp = s:plugins[p].rtp
    " TODO master only...
    let cmd = [
          \   'git',
          \   '--git-dir=' . vimrc#utils#join_path(rtp, '.git'),
          \   '--work-tree=' . rtp,
          \   'pull',
          \   '--ff',
          \   '--ff-only',
          \   '--rebase',
          \   'origin',
          \   'master:master',
          \ ]
    let options = {
          \   'on_stderr': function('s:on_stderr'),
          \   'on_exit': function('s:on_exit'),
          \ }
    let job_id = vimrc#packages#job#start(cmd, options)
    if job_id > 0
      let s:jobs[job_id] = {
            \   'progress': 'update',
            \   'total': cnt,
            \   'plugin': p,
            \   'status': 'running',
            \   'msg': [],
            \ }
    else
      let s:plugins[p].condition = 0
      let s:jobs[idx * -1] = {
            \   'progress': 'update',
            \   'total': cnt,
            \   'plugin': p,
            \   'status': 'error',
            \   'msg': [ 'Cannot start job' ],
            \ }
    endif

    while len(filter(copy(s:jobs), { _, job -> job.status ==# 'running' }))
          \ >= get(g:, 'max_thread_cnt', s:default_max_thread_cnt)
      sleep 1m
    endwhile
  endfor

  while len(filter(copy(s:jobs), { _, job -> job.status ==# 'running' })) > 0
    sleep 1m
  endwhile

  for job in filter(values(s:jobs), { _, job -> job.status ==# 'error' })
    call vimrc#utils#error(printf('[%s]', job.plugin))
    for line in job.msg
      call vimrc#utils#error(printf('  %s', line))
    endfor
  endfor
endfunction "}}}

function! vimrc#packages#clean(...) abort "{{{
  let installed_plugins = map(
        \   glob(vimrc#utils#join_path(s:packpath, 'pack/bundle/opt/*'), 0, 1),
        \   { _, val -> fnamemodify(val, ':t') }
        \ )
  let available_plugins =
        \ map(values(s:plugins), { _, val -> fnamemodify(val.rtp, ':t') })

  let uninstall_plugins = filter(
        \   installed_plugins, { _, val -> index(available_plugins, val) < 0 }
        \ )
  if empty(uninstall_plugins)
    echo 'There are no plugins to delete.'
    return
  endif

  for p in uninstall_plugins
    let ans = vimrc#utils#input(printf('Delete [%s]? [y/N]', p))
    if type(ans) ==# v:t_string && ans =~? '^y\%[es]$'
      call delete(vimrc#utils#join_path(s:packpath, 'pack/bundle/opt', p), 'rf')
    endif
  endfor
endfunction "}}}

function! s:packadd(name, bang, ...) abort "{{{
  let plugin = get(s:plugins, a:name, {})
  if empty(plugin)
    return
  endif

  " TODO Check path exists
  execute 'packadd' . (a:bang ? '!' : '')
        \ vimrc#utils#join_path(plugin.name, plugin.path)

  if !a:bang
    call s:plugin_loaded(a:name, a:000)
  endif
endfunction "}}}

function! s:plugin_loaded(name, ...) abort "{{{
  unlet! s:loding_plugins[a:name]
  if !empty(s:loding_plugins)
    return
  endif

  if has('nvim') && len(s:installed_plugins) > 0
    UpdateRemotePlugins
  endif

  for plugin in keys(s:plugins)
    call s:call_hook(plugin, 'post_add')
  endfor

  call vimrc#packages#filetype_on()
  doautocmd User post-plugins-loaded
endfunction "}}}

function! s:flatten(list) abort "{{{
  if type(a:list) !=# v:t_list
    return [ a:list ]
  endif

  let flat_list = []
  for elem in a:list
    let flat_list += s:flatten(elem)
  endfor

  return flat_list
endfunction "}}}

function! s:check_options(options) abort "{{{
  if empty(a:options) || type(a:options[0]) !=# v:t_dict || empty(a:options[0])
    return {}
  endif

  let op = copy(a:options[0])

  if has_key(op, 'condition') && type(op.condition) ==# v:t_func
    let op.condition = op.condition()
  endif

  for key in [ 'init', 'post_add' ]
    if has_key(op, key)
          \ && index([ v:t_func, v:t_string ], type(op[key])) < 0
      unlet op[key]
    endif
  endfor

  if has_key(op, 'depends')
    if index([ v:t_string, v:t_list ], type(op.depends)) < 0
          \ || empty(op.depends)
      unlet op.depends
    elseif type(op.depends) ==# v:t_string
      let op.depends = [ op.depends ]
    endif
  endif
  if has_key(op, 'depends')
    let op.depends = uniq(sort(copy(op.depends)))
  endif

  if has_key(op, 'path')
        \ && (type(op.path) !=# v:t_string || empty(op.path))
    unlet op.depends
  endif

  if has_key(op, 'build')
        \ && index([ v:t_func, v:t_string ], type(op.build)) < 0
    unlet op.build
  endif

  return op
endfunction "}}}

function! s:remove_disabled_plugins(options) abort "{{{
  " Available plugins
  let options = filter(copy(a:options), { _, op -> op.condition })

  let changed = 0
  for plugin in keys(filter(copy(options), { _, op -> !empty(op.depends) }))
    let depends = options[plugin].depends
    for p in depends
      if !has_key(options, p)
        let options[plugin].condition = 0
        let changed = 1
        break
      endif
    endfor
  endfor

  return changed ? s:remove_disabled_plugins(options) : options
endfunction "}}}

function! s:call_hook(plugin, hook) abort "{{{
  if !has_key(s:plugins[a:plugin], a:hook)
    return
  endif

  let Hook = s:plugins[a:plugin][a:hook]
  if type(Hook) ==# v:t_string
    if !empty(Hook)
      execute 'source' fnameescape(Hook)
    endif
  else
    call call(Hook, [], s:plugins[a:plugin])
  endif
endfunction "}}}

function! s:on_stderr(job_id, lines) abort "{{{
  let s:jobs[a:job_id].status = 'error'
  for l in a:lines
    call add(s:jobs[a:job_id].msg, l)
  endfor
endfunction "}}}

function! s:on_exit(job_id, status) abort "{{{
  let plugin = s:jobs[a:job_id].plugin
  if a:status !=# 0
    if s:jobs[a:job_id].progress ==# 'install'
      " Disable plugin
      let s:plugins[plugin].condition = 0
    endif
    let s:jobs[a:job_id].status = 'error'
  else
    let s:jobs[a:job_id].status = 'exit'
    if s:jobs[a:job_id].progress ==# 'install'
      call add(s:installed_plugins, s:jobs[a:job_id].plugin)
    endif
  endif
  let fin_cnt = len(filter(copy(s:jobs), { _, j -> j.status !=# 'running' }))
  echomsg printf(
        \   '(%d/%d) [%s]',
        \   fin_cnt, s:jobs[a:job_id].total, s:jobs[a:job_id].plugin
        \ )
  if a:status ==# 0
    let doc_path = vimrc#utils#join_path(s:plugins[plugin].rtp, 'doc')
    if isdirectory(doc_path) && filewritable(doc_path) ==# 2
      execute 'helptags' fnameescape(doc_path)
    endif
    if has_key(s:plugins[plugin], 'build')
      let pwd = getcwd()
      try
        execute 'lcd' s:plugins[plugin].rtp
        call s:build(plugin)
      finally
        execute 'lcd' pwd
      endtry
    endif
  endif
endfunction "}}}

function! s:build(plugin) abort "{{{
  if !has_key(s:plugins[a:plugin], 'build')
    return
  endif

  let Build = s:plugins[a:plugin].build
  if type(Build) ==# v:t_string
    if !empty(Build)
      execute '!' . Build
    endif
  else
    call call(Build, [], s:plugins[a:plugin])
  endif
endfunction "}}}

let &cpoptions = s:save_cpo
unlet s:save_cpo