"-----------------------------------------------------------------------------
" Neovim:
"
tnoremap <ESC> <C-\><C-n>

nnoremap <Leader>t :<C-u>terminal<CR>

set mouse=

autocmd MyAutocmd CursorHold * if exists(':rshada') | rshada | wshada | endif

if exists('$NVIM_GUI')
  set ambiwidth=double

  autocmd MyAutocmd BufEnter * call <SID>init_{$NVIM_GUI}()
  function! s:init_pynvim() abort "{{{
    if exists('g:loaded_pynvim')
      return
    endif

    let g:loaded_pynvim = 1
  endfunction "}}}
endif
