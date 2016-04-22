"-----------------------------------------------------------------------------
" FileType:
"
augroup MyAutocmd
  autocmd FileType,Syntax,BufNew * call s:on_filetype()

  autocmd BufReadPost *.tpl set filetype=smarty.html
  autocmd FileType haskell setlocal shiftwidth=2
  autocmd FileType javascript,css setlocal shiftwidth=4
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*}
        \ setlocal filetype=markdown

  " Update filetype
  autocmd BufWritePost *
        \ if &filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif

augroup END

function! s:on_filetype() abort "{{{
  setlocal formatoptions-=ro
  setlocal formatoptions+=mMBl

  if &textwidth != 70 && &filetype !=# 'help'
    setlocal textwidth=0
  endif

  if &buftype ==# 'help' || &buftype ==# 'quickfix'
    nnoremap <silent> <buffer> q :q<CR>
  endif
endfunction "}}}

" python.vim
let g:python_highlight_all = 1

let g:is_bash = 1

" markdown colors
" http://mattn.kaoriya.net/software/vim/20140523124903.htm
let g:markdown_fenced_languages = [
      \   'css',
      \   'javascript',
      \   'js=javascript',
      \   'json=javascript',
      \   'xml',
      \   'vim',
      \   'php',
      \ ]
