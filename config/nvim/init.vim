scriptencoding utf-8

"-----------------------------------------------------------------------------
" Initialize:
"
let s:nvim_dir = fnamemodify(expand('<sfile>'), ':h')
let s:is_windows =
      \ has('win16') || has('win32') || has('win64') || has('win95')
let s:is_cygwin = has('win32unix')
let s:is_unix = has('unix')

let s:vimdev_dir = resolve(expand('~/vim_dev'))

function! s:source_rc(path) abort "{{{
  execute 'source' fnameescape(NvimDir() . '/rc/' . a:path)
endfunction "}}}

function! IsWindows() abort "{{{
  return s:is_windows
endfunction "}}}

function! IsUnix() abort "{{{
  return s:is_unix
endfunction "}}}

function! IsPowerlineEnabled() abort "{{{
  " return (has('python') || has('python3')) && executable('powerline-daemon')
  " TODO Powerlineがnvimで使えるようになったら有効にする
  return 0
endfunction "}}}

function! IsHomePC() abort "{{{
  return isdirectory(s:vimdev_dir)
endfunction "}}}

function! NvimDir() abort "{{{
  return s:nvim_dir
endfunction "}}}

call s:source_rc('init.rc.vim')

" FIXME deinが正式にリリースされたら書き換える
" NeoBundle
call neobundle#begin(expand('$CACHE/neobundle'))

if neobundle#load_cache(
      \   expand('<sfile>'),
      \   NvimDir() . '/rc/neobundle.toml',
      \   NvimDir() . '/rc/neobundle_lazy.toml'
      \ )
  NeoBundleFetch 'Shougo/neobundle.vim'

  call neobundle#load_toml(NvimDir() . '/rc/neobundle.toml')
  call neobundle#load_toml(
        \   NvimDir() . '/rc/neobundle_lazy.toml',
        \   { 'lazy': 1 }
        \ )

  if IsHomePC()
    " 開発用設定
    " 上で公開版の設定がされていても、こちらで開発用に上書きできる。
    call neobundle#local(
          \   s:vimdev_dir,
          \   { 'type': 'none' },
          \   [ 'vim*', 'unite-*', '*.vim', '*.nvim', 'neosnippet-additional' ]
          \ )
  endif

  NeoBundleSaveCache
endif

" プラグインごとの設定
call s:source_rc('plugins.rc.vim')
if IsHomePC()
  let s:vimrc_dev = s:vimdev_dir . '/vimrc'
  if filereadable(s:vimrc_dev)
    execute 'source' s:vimrc_dev
  endif
  unlet s:vimrc_dev
endif

call neobundle#end()

filetype plugin indent on

syntax enable

if !has('vim_starting')
  NeoBundleCheck
endif

"-----------------------------------------------------------------------------
" Encoding:
"
call s:source_rc('encoding.rc.vim')

"-----------------------------------------------------------------------------
" Search:
"
call s:source_rc('search.rc.vim')

"-----------------------------------------------------------------------------
" Edit:
"
call s:source_rc('edit.rc.vim')

"-----------------------------------------------------------------------------
" View:
"
call s:source_rc('view.rc.vim')

"-----------------------------------------------------------------------------
" FileType:
"
call s:source_rc('filetype.rc.vim')

"-----------------------------------------------------------------------------
" Mappings:
"
call s:source_rc('mappings.rc.vim')

"-----------------------------------------------------------------------------
" GUI:
"
" TODO GUIの設定

"-----------------------------------------------------------------------------
" Powerline:
"
" TODO Powerlineの設定

"-----------------------------------------------------------------------------
" Colorscheme:
"
call s:source_rc('colorscheme.rc.vim')

"-----------------------------------------------------------------------------
" Local Settings:
"
if filereadable(expand('~/.nvimrc_local'))
  execute 'source' expand('~/.nvimrc_local')
endif

set secure

" vim:set foldmethod=marker: