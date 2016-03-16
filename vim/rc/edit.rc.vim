"-----------------------------------------------------------------------------
" Edit:
"
set smarttab
set expandtab

set shiftround

set modeline

" Clipboard
if has('clipboard')
  set clipboard&
  if has('nvim')
    set clipboard+=unnamedplus
  else

  endif
endif
if (!has('nvim') || $DISPLAY !=# '') && has('clipboard')
  set clipboard&
  if has('nvim')
    set clipboard+=unnamedplus
  else
    if has('unnamedplus')
      set clipboard=unnamedplus
    else
      set clipboard=unnamed
    endif
  endif
endif

set backspace=indent,eol,start

set showmatch
set matchtime=1
set matchpairs+=<:>

set hidden

set infercase

" Folding
set foldmethod=marker
set foldcolumn=1
set fillchars=vert:\|
set commentstring=%s

" TODO Move to foldCC plugin setting
if exists('*FoldCCtext')
  " Use FoldCCtext().
   set foldtext=FoldCCtext()
endif

set grepprg=grep\ -inH

" Exclude = from isfilename
set isfname-==

set timeout
set timeoutlen=3000
set ttimeoutlen=100

set updatetime=1000

" Remove current directory from swap directory
set directory-=.

" Do not create backup
set nowritebackup
set nobackup
set noswapfile
set backupdir-=.

if v:version >= 703
  set undofile
  let &undodir=&directory
endif

if v:version < 703 || v:version == 7.3 && !has('patch336')
  " Vim's bug
  set notagbsearch
endif

set virtualedit=block

set keywordprg=:help

autocmd MyAutocmd WinEnter * checktime

autocmd MyAutocmd InsertLeave *
      \ if &paste | setlocal nopaste | echo 'nopaste' | endif
autocmd MyAutocmd InsertLeave *
      \ if &diff | diffupdate | endif

" Create directory automatically
" http://vim-users.jp/2011/02/hack202/
autocmd MyAutocmd BufWritePre *
      \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force) abort "{{{
  if isdirectory(a:dir) || &l:buftype !=# ''
    return
  endif

  let l:ans = 'yes'
  if !a:force
    l:ans = input(printf('"%s" does not exists. Create? [y/N]', a:dir))
  endif
  if l:ans =~? '^y\%[es]$'
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction "}}}

" Remove last whitespaces
autocmd MyAutocmd BufWritePre * call <SID>del_last_whitespaces()
function! s:del_last_whitespaces() abort "{{{
  if exists('b:not_del_last_whitespaces')
    return
  endif

  if &binary || &diff
    return
  endif

  let l:cursor = getpos('.')

  global/^/ s/\s\+$//e

  call setpos('.', l:cursor)
  unlet l:cursor
endfunction "}}}

set nrformats=

" lcd git root directory
if executable('git')
  autocmd MyAutocmd BufWinEnter * call s:cd_gitroot()

  function! s:trim(str) abort "{{{
    return substitute(a:str, '^[\r\n]*\(.\{-}\)[\r\n]*$', '\1', '')
  endfunction "}}}

  function! s:cd_gitroot() abort "{{{
    let l:dir = getcwd()

    let l:buf_path = expand('%:p')
    if !isdirectory(l:buf_path)
      let l:buf_path = fnamemodify(l:buf_path, ':h')
    endif
    if !isdirectory(l:buf_path)
      return
    endif
    execute 'lcd' l:buf_path

    let l:in_git_dir = s:trim(system('git rev-parse --is-inside-work-tree'))
    if l:in_git_dir !=# 'true'
      execute 'lcd' l:dir
      return
    endif

    let l:git_root = s:trim(system('git rev-parse --show-toplevel'))
    execute 'lcd' l:git_root
  endfunction "}}}
endif