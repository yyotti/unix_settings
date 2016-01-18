scriptencoding utf-8
"-----------------------------------------------------------------------------
" Deoplete:
"
set completeopt+=noinsert

let g:deoplete#enable_smart_case = 1

" <C-h>はポップアップを消すだけ
inoremap <expr> <C-h> deoplete#mappings#close_popup() . "\<C-h>"
" <BS>は補完入力された部分も消す
inoremap <expr> <BS>  deoplete#mappings#smart_close_popup() . "\<C-h>"

" <CR>でポップアップを閉じてインデントを保存する
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort "{{{
  return deoplete#mappings#close_popup() . "\<CR>"
endfunction "}}}

call deoplete#custom#set(
      \   '_',
      \   'converters',
      \   [
      \     'converter_auto_paren',
      \     'converter_auto_delimiter',
      \     'remove_overlap',
      \   ]
      \ )

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'
" TODO PHPなどの設定を追加

let g:deoplete#omni#functions = {}
let g:deoplete#omni#input_patterns = {}
" TODO PHPなどの設定を追加

" vim:set foldmethod=marker:
