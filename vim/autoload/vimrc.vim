function! vimrc#join_path(base, ...) abort "{{{
  let l:paths = filter(
        \   map(
        \     map(
        \       copy(a:000),
        \       { _, part -> type(part) !=# v:t_string ? string(part) : part }
        \     ),
        \     { _, val ->
        \       join(filter(split(val, '/'), { _, val -> !empty(val) }), '/') }
        \   ),
        \   { _, val -> !empty(val) }
        \ )
  return empty(l:paths) ? a:base : join([ a:base ] + l:paths, '/')
endfunction "}}}

function! vimrc#on_filetype() abort "{{{
  if execute('filetype') =~# 'OFF'
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction "}}}

function! vimrc#toggle_option(option_name) abort "{{{
  execute 'setlocal' a:option_name.'!'
  execute 'setlocal' a:option_name.'?'
endfunction "}}}

function! vimrc#re_check_fenc() abort "{{{
  let l:is_multi_byte = search("[^\x01-\x7e]", 'n', 100, 100)
  if &fileencoding =~# 'iso-2022-jp' && !l:is_multi_byte
    let &fileencoding = &encoding
  endif
endfunction "}}}

function! vimrc#toggle_cmdline_word_boundary() abort "{{{
  let l:cmdline = getcmdline()
  if getcmdtype() !=# '/' && getcmdtype() !=# '?'
    return l:cmdline
  endif

  if l:cmdline !~# '^\\<.*\\>$'
    let l:cmdline = '\<' . l:cmdline . '\>'
  else
    let l:cmdline = l:cmdline[2:len(l:cmdline) - 3]
  endif

  return l:cmdline
endfunction "}}}

function! vimrc#automark() abort "{{{
  let b:marker_idx = (get(b:, 'marker_idx', -1) + 1) % len(g:marker_chars)
  let l:char = g:marker_chars[b:marker_idx]
  execute 'mark' l:char
  echo printf('marked [%s]', l:char)
endfunction "}}}

function! vimrc#mkdir_as_necessary(dir) abort "{{{
  if isdirectory(a:dir) || &buftype !=# ''
    return
  endif

  let l:msg = printf('"%s" does not exists. Creaet ?', a:dir)
  if confirm(l:msg, "&Yes\n&No", 2) ==# 1
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction "}}}

function! vimrc#del_last_whitespaces() abort "{{{
  if !get(b:, 'del_last_whitespaces', 1)
    return
  endif

  if &binary || &diff || !&l:modifiable
    return
  endif

  let l:cursor = getpos('.')

  global/^/ s/\s\+$//e

  call setpos('.', l:cursor)
endfunction "}}}

function! vimrc#trim(str) abort "{{{
  return substitute(a:str, '^[\r\n]*\(.\{-}\)[\r\n]*$', '\1', '')
endfunction "}}}

function! vimrc#cd_gitroot() abort "{{{
  let l:dir = getcwd()

  let l:buf_path = expand('%:p')
  if !isdirectory(l:buf_path)
    let l:buf_path = fnamemodify(l:buf_path, ':h')
  endif
  if !isdirectory(l:buf_path)
    return
  endif
  execute 'lcd' fnameescape(l:buf_path)

  let l:in_git_dir = vimrc#trim(system('git rev-parse --is-inside-work-tree'))
  if l:in_git_dir !=# 'true'
    execute 'lcd' fnameescape(l:dir)
    return
  endif

  let l:git_root = vimrc#trim(system('git rev-parse --show-toplevel'))
  execute 'lcd' escape(l:git_root, ' ')
endfunction "}}}

" function! vimrc#smart_bdelete(force) abort "{{{
"   let l:cur_bufnr = bufnr('%')
"
"   let l:buffers = {}
"   for l:buf in split(execute('ls'), "\n")
"     let l:mt = matchlist(l:buf, '^\s*\(\d\+\)\s*\([+-=auhx%#]\+\)')
"     let l:buffers[l:mt[1]] = l:mt[2]
"   endfor
"
"   if len(l:buffers) > winnr('$') && has_key(l:buffers, l:cur_bufnr)
"     let l:alt_bufnr = bufnr('#')
"     if !has_key(l:buffers, l:alt_bufnr) || l:buffers[l:alt_bufnr] =~# 'a'
"       " Alt buffer is active buffer or not listed
"       let l:next_bufnr =
"             \ keys(filter(copy(l:buffers), { _, val -> val !~# 'a' }))[0]
"     else
"       let l:next_bufnr = l:alt_bufnr
"     endif
"
"     execute 'buffer' l:next_bufnr
"   endif
"
"   execute 'bdelete' . (a:force ? '!' : '') l:cur_bufnr
" endfunction "}}}
function! vimrc#smart_bdelete(force) abort "{{{
  let l:cur_bufnr = bufnr('%')
  let l:alt_bufnr = bufnr('#')

  if buflisted(l:alt_bufnr)
    buffer #
  else
    bnext
  endif

  if bufnr('%') ==# l:cur_bufnr
    " bwipeout is failed when !force and buffer is modified
    if a:force || !&l:modified
      new
    endif
  endif

  if buflisted(l:cur_bufnr)
    execute 'silent bwipeout' . (a:force ? '!' : '') l:cur_bufnr
    " restore buffer when bwipeout is failed
    if bufloaded(l:cur_bufnr)
      execute 'buffer' l:cur_bufnr
    endif
  endif
endfunction "}}}
