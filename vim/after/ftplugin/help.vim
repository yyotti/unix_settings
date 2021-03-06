if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|'
else
  let b:undo_ftplugin = ''
endif
let s:undo = []

setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=-
call add(s:undo, 'setlocal iskeyword<')

nnoremap <silent> <buffer> <nowait> q :<C-u>q<CR>
call add(s:undo, 'nunmap <buffer> q')

if !empty(s:undo)
  let b:undo_ftplugin .= join(s:undo, '|')
endif
