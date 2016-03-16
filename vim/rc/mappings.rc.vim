"-----------------------------------------------------------------------------
" Mappings:
"
nmap <C-Space> <C-@>
cmap <C-Space> <C-@>

" Normal/Visual mode mappings: "{{{
nnoremap > >>
nnoremap < <<
xnoremap > >gv
xnoremap < <gv

xnoremap <TAB> >
xnoremap <S-TAB> <

" Disable dangerous mappings
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" Disable Ex mode
nnoremap Q <Nop>

nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

nnoremap gj j
nnoremap gk k
xnoremap gj j
xnoremap gk k

nnoremap * *<C-o>zvzz
nnoremap g* g*<C-o>zvzz
nnoremap # #<C-o>zvzz
nnoremap g# g#<C-o>zvzz

if (!has('nvim') || $DISPLAY !=# '') && has('clipboard')
  xnoremap <silent> y "*y:let [@+,@"]=[@*,@*]<CR>
endif

" Clear hlsearch
nnoremap <silent> <C-h> :<C-u>nohlsearch<CR>
"}}}

" Insert mode mappings: "{{{
inoremap <C-t> <C-v><TAB>

" Enable undo <C-w> and <C-u>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>

if has('gui_running')
  inoremap <ESC> <ESC>
endif
"}}}

" Command-line mode mappings: "{{{
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <DEL>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

cnoremap <C-k>
      \ <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos() - 2]<CR>
cnoremap <C-t> <C-r>*
cnoremap <C-g> <C-c>

" Toggle word boundary
cnoremap <C-o> <C-\>e<SID>toggle_word_boundary()<CR>
function! s:toggle_word_boundary() abort "{{{
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
"}}}

" Replace a>,i>,etc... "{{{
" <angle>
onoremap aa a>
xnoremap aa a>
onoremap ia i>
xnoremap ia i>

" [rectangle]
onoremap ar a]
xnoremap ar a]
onoremap ir i]
xnoremap ir i]

" 'quote'
onoremap as a'
xnoremap as a'
onoremap is i'
xnoremap is i'

" "double quote"
onoremap ad a"
xnoremap ad a"
onoremap id i"
xnoremap id i"
"}}}

" Edit config files "{{{
" vimrc
nnoremap <silent> <Leader>;v
      \ :<C-u>edit <C-r>=resolve(expand($MYVIMRC))<CR><CR>
" reload vimrc
nnoremap <silent> <Leader>;r
      \ :<C-u>source $MYVIMRC<CR> \| :echo "source " . $MYVIMRC<CR>

" .tmux.conf
if filereadable(expand('~/.tmux.conf'))
  nnoremap <silent> <Leader>;t
        \ :<C-u>edit <C-r>=resolve(expand('~/.tmux.conf'))<CR><CR>
endif

" .zshrc
if filereadable(expand('~/.zshrc'))
  nnoremap <silent> <Leader>;z
        \ :<C-u>edit <C-r>=resolve(expand('~/.zshrc'))<CR><CR>
endif
"}}}

" Move cursor between windows "{{{
nnoremap <Leader>h <C-w>h
nnoremap <Leader>l <C-w>l
nnoremap <Leader>k <C-w>k
nnoremap <Leader>j <C-w>j

nnoremap <Leader>x <C-w>x

nnoremap <Leader>H <C-w>H
nnoremap <Leader>L <C-w>L
nnoremap <Leader>K <C-w>K
nnoremap <Leader>J <C-w>J
"}}}

" Operate buffer "{{{
nnoremap <silent> <Leader>o :<C-u>only<CR>
nnoremap <silent> <Leader>d :<C-u>bdelete<CR>
nnoremap <silent> <Leader>D :<C-u>bdelete!<CR>
"}}}

" Others "{{{
" Toggle background
nmap <expr> <C-b> <SID>toggle_background()
function! s:toggle_background() abort "{{{
  if &background ==# 'light'
    set background=dark
  else
    set background=light
  endif
endfunction "}}}

nnoremap x "_x
"}}}