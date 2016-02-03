scriptencoding utf-8
"-----------------------------------------------------------------------------
" Plugins:
"

if neobundle#tap('deoplete.nvim') "{{{
  let g:deoplete#enable_at_startup = 1
  let g:neobundle#hooks.on_source =
        \ NvimDir() . '/rc/plugins/deoplete.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('neosnippet.vim') "{{{
  let g:neobundle#hooks.on_source =
        \ NvimDir() . '/rc/plugins/neosnippet.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('neosnippet-additional') "{{{
  function! g:neobundle#hooks.on_source(bundle) abort "{{{
    if !exists('g:neosnippet#snippets_directory')
      let g:neosnippet#snippets_directory = ''
    endif

    let l:snippets_dir = expand(a:bundle.path . '/snippets/')
    let l:dirs = split(g:neosnippet#snippets_directory, ',')
    for l:dir in l:dirs
      if l:dir ==# l:snippets_dir
        return
      endif
    endfor

    let g:neosnippet#snippets_directory = join(add(l:dirs, l:snippets_dir), ',')
  endfunction "}}}

  call neobundle#untap()
endif "}}}

if neobundle#tap('unite.vim') "{{{
  nnoremap [unite] <Nop>
  xnoremap [unite] <Nop>
  nmap <Leader>u [unite]
  xmap <Leader>u [unite]

  " buffer + mru
  nnoremap <silent> [unite]b :<C-u>Unite buffer file_mru<CR>
  " only mru
  nnoremap <silent> [unite]u :<C-u>Unite file_mru<CR>
  " bookmarks
  nnoremap <silent> [unite]m :<C-u>Unite bookmark<CR>
  " unite-line
  nnoremap <silent> [unite]l :<C-u>Unite line<CR>
  " grep
  nnoremap <silent> [unite]g
        \ :<C-u>Unite grep -buffer-name=grep
        \   -no-start-insert -auto-preview -no-empty<CR>
  " grep resume
  nnoremap <silent> [unite]r
        \ :<C-u>UniteResume -buffer-name=grep
        \   -no-start-insert -auto-preview -no-empty grep<CR>

  let g:unite_force_overwrite_statusline = 0

  let g:neobundle#hooks.on_source =
        \ NvimDir() . '/rc/plugins/unite.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('vimfiler.vim') "{{{
  nnoremap [vimfiler] <Nop>
  xnoremap [vimfiler] <Nop>
  nmap <Leader>f [vimfiler]
  xmap <Leader>f [vimfiler]

  nnoremap <silent> [vimfiler]e :<C-u>VimFilerBufferDir -invisible<CR>

  let g:neobundle#hooks.on_source =
        \ NvimDir() . '/rc/plugins/vimfiler.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('eskk.vim') "{{{
  imap <C-j> <Plug>(eskk:toggle)
  cmap <C-j> <Plug>(eskk:toggle)

  let g:neobundle#hooks.on_source =
        \ NvimDir() . '/rc/plugins/eskk.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('junkfile.vim') "{{{
  nnoremap <silent> [unite]j :<C-u>Unite junkfile/new junkfile<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-fugitive') "{{{
  " prefix定義
  nnoremap [git] <Nop>
  nmap <Leader>g [git]

  nnoremap <silent> [git]s :<C-u>Gstatus<CR>
  nnoremap <silent> [git]d :<C-u>Gvdiff<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-merginal') "{{{
  nnoremap <silent> [git]m :<C-u>Merginal<CR>

  function! g:neobundle#hooks.on_post_source(bundle) abort "{{{
    doautocmd User Fugitive
  endfunction "}}}

  call neobundle#untap()
endif "}}}

if neobundle#tap('agit.vim') "{{{
  nnoremap <silent> [git]a :<C-u>Agit<CR>
  nnoremap <silent> [git]f :<C-u>AgitFile<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-gitgutter') "{{{
  let g:neobundle#hooks.on_source =
        \ NvimDir() . '/rc/plugins/vim-gitgutter.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('lightline.vim') "{{{
  let g:neobundle#hooks.on_source =
        \ NvimDir() . '/rc/plugins/lightline.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-ref') "{{{
  let g:neobundle#hooks.on_source =
        \ NvimDir() . '/rc/plugins/vim-ref.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-easymotion') "{{{
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_enter_jump_first = 1
  let g:EasyMotion_space_jump_first = 1
  let g:EasyMotion_startofline = 0

  " easymotionのプレフィックスは基本的に'とする
  map ' <Plug>(easymotion-prefix)

  " fとtのマッピングを置換する
  map f <Plug>(easymotion-fl)
  map t <Plug>(easymotion-tl)
  map F <Plug>(easymotion-Fl)
  map T <Plug>(easymotion-Tl)
  " ;/,を置換
  map ; <Plug>(easymotion-next)
  map , <Plug>(easymotion-prev)

  " ' + f/t/F/T で複数文字のやつにする
  map 'f <Plug>(easymotion-fln)
  map 't <Plug>(easymotion-tln)
  map 'F <Plug>(easymotion-Fln)
  map 'T <Plug>(easymotion-Tln)

  " 'sは複数個のやつにマッピングする
  " これがあるとw/e系がほとんど不要になってしまうが。
  map 's <Plug>(easymotion-sn)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-anzu') "{{{
  nmap n <Plug>(anzu-n)zvzz
  nmap N <Plug>(anzu-N)zvzz
  nmap * <Plug>(anzu-star)zvzz
  nmap # <Plug>(anzu-sharp)zvzz

  function! g:neobundle#hooks.on_source(bundle) abort "{{{
    autocmd NvimAutocmd CursorHold,CursorHoldI,WinLeave,TabLeave *
          \ call anzu#clear_search_status()
  endfunction "}}}

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-operator-replace') "{{{
  map R <Plug>(operator-replace)
  xmap p <Plug>(operator-replace)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-operator-surround') "{{{
  map <silent> ra <Plug>(operator-surround-append)
  map <silent> rd <Plug>(operator-surround-delete)
  map <silent> rc <Plug>(operator-surround-replace)

  call neobundle#untap()
endif "}}}

if neobundle#tap('winresizer') "{{{
  " winresizerに用意されているマッピング機能を使うと遅延ロードが
  " できないので、こちらで手動マッピングしてやる。
  " winresizerをロードしたらデフォルトのマッピングがされるので、
  " ロード後にそれらのマッピングを解除する。

  if has('gui_running')
    let g:winresizer_gui_enable = 1
    nnoremap <C-w>R :<C-u>WinResizerStartResizeGUI<CR>
  endif

  let g:winresizer_vert_resize = 5
  nnoremap <C-w>r :<C-u>WinResizerStartResize<CR>

  function! g:neobundle#hooks.on_post_source(bundle) abort "{{{
    execute 'unmap' g:winresizer_start_key
    if has('gui_running')
      execute 'unmap' g:winresizer_gui_start_key
    endif
  endfunction "}}}

  call neobundle#untap()
endif "}}}

if neobundle#tap('foldCC.vim') "{{{
  let g:foldCCtext_enable_autofdc_adjuster = 1

  call neobundle#untap()
endif "}}}

if neobundle#tap('colorizer') "{{{
  let g:colorizer_nomap = 1

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-lintexec.nvim') "{{{
  function! g:neobundle#hooks.on_source(bundle) abort "{{{
    if exists('*lightline#update')
      let g:lintexec#checker_cmd = {
            \   '_': {
            \     'on_exit': function('lightline#update'),
            \   },
            \ }
    endif
  endfunction "}}}

  autocmd NvimAutocmd BufWritePost * call lintexec#run()

  call neobundle#untap()
endif "}}}

if neobundle#tap('unite-quickfix') "{{{
  nnoremap <silent> [unite]q
        \ :<C-u>Unite -no-quit -no-start-insert quickfix<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-quickrun') "{{{
  nmap <silent> <Leader>r <Plug>(quickrun)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-operator-flashy') "{{{
  let g:operator#flashy#flash_time = 300

  map y <Plug>(operator-flashy)
  nmap Y <Plug>(operator-flashy)$

  function! g:neobundle#hooks.on_source(bundle) abort "{{{
    " highlight Cursor が設定されていないとエラーになるので、その対処
    let v:errmsg = ''
    silent! highlight Cursor
    if !empty(v:errmsg)
      highlight Cursor guibg=fg guifg=bg
    endif
  endfunction "}}}

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-unified-diff') "{{{
  set diffexpr=unified_diff#diffexpr()

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-autoupload') "{{{
  autocmd NvimAutocmd BufWinEnter *.php,*.tpl,*.css,*.js
        \ call autoupload#init(0)
  autocmd NvimAutocmd BufWritePost *.php,*.tpl,*.css,*.js
        \ call autoupload#upload(0)

  call neobundle#untap()
endif "}}}

if neobundle#tap('ghcmod-vim') "{{{
  autocmd NvimAutocmd FileType haskell
        \ nnoremap <buffer> <Leader>tt :GhcModType<CR>
  autocmd NvimAutocmd FileType haskell
        \ nnoremap <buffer> <Leader>tc :GhcModTypeClear<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('unite-googletasks') "{{{
  nnoremap <silent> [unite]t
        \ :<C-u>Unite googletasks/tasklists googletasks/tasklists/new<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('matchit.zip') "{{{
  function! g:neobundle#hooks.on_source(bundle) abort "{{{
    " 起動時にデフォルトの方を無効にしているのでここで有効化する
    unlet g:loaded_matchit
  endfunction "}}}
  
  let g:neobundle#hooks.on_post_source =
        \ NvimDir() . '/rc/plugins/matchit.zip.vim'

  call neobundle#untap()
endif "}}}

" vim:set foldmethod=marker:
