"-----------------------------------------------------------------------------
" Filetypes:
"

" Vim
let g:vimsyntax_noerror = 1

" Bash
let g:is_bash = 1

" python.vim
let g:python_highlight_all = 1

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

" Folding
let g:xml_syntax_folding = 1

" Disable PHP formatoptions
let g:PHP_autoformatcomment = 0

" Update filetype
autocmd MyAutocmd BufWritePost * nested
      \ if &l:filetype ==# '' || exists('b:ftdetect') |
      \   unlet! b:ftdetect |
      \   filetype detect |
      \ endif

" Highlight whitespaces (EOL)
highlight default link WhitespaceEOL Error
match WhitespaceEOL /\s\+$/

augroup filetypedetect
  " gitignore
  autocmd BufRead,BufNewFile */git/ignore,*/.gitignore,*.git/info/exclude
        \ setfiletype conf
augroup END
