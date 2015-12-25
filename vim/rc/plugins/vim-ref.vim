scriptencoding utf-8
"--------------------------------------------------------------------------------
" vim-ref.vim
"

" 設定 {{{
let g:ref_cache_dir = expand('$CACHE/vim_ref_cache')
if IsWindows()
  let g:ref_refe_encoding = 'cp932'
endif

" PHP
let g:ref_phpmanual_path = $HOME . '/.vim/refs/php-chunked-xhtml'
" }}}

" vim:set ts=8 sts=2 sw=2 tw=0 expandtab foldmethod=marker: