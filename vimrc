scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0 expandtab foldmethod=marker:

" プラグイン管理 {{{

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" NeoBundle {{{
if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  " neobundle をインストールしていなければ自動でインストール
  if !isdirectory(expand('~/.vim/bundle/neobundle.vim/'))
    echo 'install neobundle...'
    call system('curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh')
  endif

  " 必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" 必須
call neobundle#begin(expand('~/.vim/bundle/'))

" NeoBundleをNeoBundleで管理する
" 必須
NeoBundleFetch 'Shougo/neobundle.vim'

" }}}

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" vimproc {{{
if has('unix')
  " vimprocは香り屋版にバンドルされているので、Winでは不要
  " Linuxで必要になるなら有効にする
  " インストール後、自動的にビルドされる
  " ※has('unix')してるくせにその他の環境まで書いてあるのはご愛嬌
  NeoBundle 'Shougo/vimproc', {
        \   'build': {
        \     'windows': 'tools\\update-dll-mingw',
        \     'cygwin': 'make -f make_cygwin.mak',
        \     'mac': 'make -f make_mak.mak',
        \     'linux': 'make',
        \     'unix': 'gmake',
        \   },
        \ }
endif
" }}}

" colorscheme {{{
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'morhetz/gruvbox'
" }}}

" Lazyしないプラグイン {{{
" ※fugitiveも遅延ロードしたかったが、autocmdを多用しているので無理らしい
NeoBundle 'tpope/vim-fugitive'
" ※fugitiveとvim-merginalが遅延ロードできないので、ついでにこいつも遅延ロードしない
NeoBundle 'cohama/agit.vim', {
      \   'depends': ['tpope/vim-fugitive'],
      \ }
" ※vim-merginalもautocmdを使っているので遅延ロードできない
NeoBundle 'idanarye/vim-merginal', {
      \   'depends': ['tpope/vim-fugitive'],
      \ }
NeoBundle 'tyru/eskk.vim'
NeoBundle 'lambdalisue/vim-unified-diff'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'itchyny/lightline.vim'
" ※Git関係は遅延ロードしない方向で統一しておく
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Lokaltog/vim-easymotion'
" TODO 後でLazyにしたい
NeoBundle 'vim-jp/vital.vim'
" TODO 後でLazyにしたいが、そのためには自作するほうがいいか？この程度ならLazyしなくてもいいかも？
NeoBundle 'sudo.vim', {
      \   'external_commands': 'sudo',
      \ }
" }}}

" Lazy {{{
NeoBundleLazy 'Shougo/unite.vim', {
      \   'depends': ['Shougo/vimproc'],
      \ }
NeoBundleLazy 'Shougo/vimfiler', {
      \   'depends': ['Shougo/unite.vim'],
      \ }
" ※Uniteから分離したらしい
NeoBundleLazy 'Shougo/neomru.vim', {
      \   'depends': ['Shougo/unite.vim'],
      \ }
NeoBundleLazy 'Shougo/neocomplete.vim', {
      \   'depends': ['Shougo/vimproc'],
      \   'disabled': !has('lua'),
      \   'vim_version': '7.3.885',
      \ }
NeoBundleLazy 'Shougo/neosnippet.vim'
NeoBundleLazy 'Shougo/neosnippet-snippets', {
      \   'depends': ['Shougo/neosnippet.vim'],
      \ }
NeoBundleLazy 'Shougo/vimshell', {
      \   'depends': ['Shougo/vimproc'],
      \ }
NeoBundleLazy 'LeafCage/nebula.vim'
NeoBundleLazy 'derekwyatt/vim-scala'
NeoBundleLazy 'groenewege/vim-less'
NeoBundleLazy 'kchmck/vim-coffee-script'
NeoBundleLazy 'osyo-manga/vim-watchdogs', {
      \   'depends': [
      \     'thinca/vim-quickrun',
      \     'Shougo/vimproc',
      \     'osyo-manga/shabadou.vim',
      \   ],
      \ }
NeoBundleLazy 'KazuakiM/vim-qfsigns', {
      \   'depends': ['vim-watchdogs'],
      \ }
NeoBundleLazy 'KazuakiM/vim-qfstatusline', {
      \   'depends': ['vim-watchdogs'],
      \ }
NeoBundleLazy 'tyru/restart.vim', {
      \   'gui': 1,
      \ }
NeoBundleLazy 'syngan/vim-vimlint', {
      \   'depends': [
      \     'ynkdir/vim-vimlparser',
      \     'osyo-manga/vim-watchdogs',
      \   ],
      \ }
NeoBundleLazy 'ujihisa/unite-colorscheme', {
      \   'depends': ['Shougo/unite.vim']
      \ }
NeoBundleLazy 'tsukkee/unite-tag', {
      \   'depends': [
      \     'Shougo/unite.vim',
      \     'Shougo/neocomplete.vim',
      \   ]
      \ }
NeoBundleLazy 'osyo-manga/vim-anzu'
NeoBundleLazy 'kana/vim-operator-replace', {
      \   'depends': ['kana/vim-operator-user'],
      \ }
NeoBundleLazy 'thinca/vim-ref', {
        \   'external_commands': 'lynx',
        \ }
NeoBundleLazy 'osyo-manga/unite-quickfix', {
      \   'depends': ['Shougo/unite.vim']
      \ }
NeoBundleLazy 'thinca/vim-prettyprint'
NeoBundleLazy 'thinca/vim-editvar', {
      \   'depends': ['Shougo/unite.vim'],
      \ }
NeoBundleLazy 'tek/vim-operator-assign', {
      \   'depends': ['kana/vim-operator-user'],
      \ }
NeoBundleLazy 'othree/html5.vim'
NeoBundleLazy 'othree/javascript-libraries-syntax.vim'
NeoBundleLazy 'marijnh/tern_for_vim', {
      \   'external_commands': [
      \     'npm',
      \     'nodejs',
      \   ],
      \   'build': {
      \     'others': 'npm install',
      \   },
      \ }
NeoBundleLazy 'smarty-syntax'
NeoBundleLazy 't9md/vim-quickhl'
NeoBundleLazy 'AndrewRadev/splitjoin.vim'
NeoBundleLazy 'lilydjwg/colorizer'
NeoBundleLazy 'thinca/vim-textobj-between', {
      \   'depends': 'kana/vim-textobj-user',
      \ }
NeoBundleLazy 'haya14busa/incsearch.vim'
NeoBundleLazy 'rhysd/vim-operator-surround', {
      \   'depends': 'kana/vim-operator-user',
      \ }
" }}}

" NeoBundle管理以外 {{{
runtime macros/matchit.vim
" }}}

" 試験的に導入するプラグイン {{{

" -------- " -- scala-vim-snippets
" -------- NeoBundle 'tommorris/scala-vim-snippets'

" }}}

" プラグイン開発用のvimrcが存在するなら読み込む
if filereadable($HOME.'/.vimrc_dev')
  " TODO バグがあるんだけどどうするか？forkする？
  NeoBundle 'LeafCage/vimhelpgenerator'
  source $HOME/.vimrc_dev
endif

" 自作プラグイン {{{
" 自宅PC（開発環境）以外ではgithubの公開版を使う
" unite-todolist {{{
if !neobundle#is_installed('unite-todolist')
  " TODO unite-todolistを公開したら記述
endif
" }}}

" neosnippet-additional {{{
if !neobundle#is_installed('neosnippet-additional')
  NeoBundleLazy 'yyotti/neosnippet-additional', {
        \   'depends': ['Shougo/neosnippet.vim'],
        \ }
endif
" }}}

" }}}

call neobundle#end()

" 必須!!
filetype plugin indent on

" インストールチェック
NeoBundleCheck

" }}}

" 各プラグインの設定 {{{
let g:mapleader = "\<Space>"

" キーマッピングのためのprefix定義
nnoremap [unite] <Nop>
nmap <Leader>u [unite]
nnoremap [vimfiler] <Nop>
nmap <Leader>f [vimfiler]
nnoremap [git] <Nop>
nmap <Leader>g [git]
nnoremap [nebula] <Nop>
nmap <Leader>n [nebula]
nnoremap [vimshell] <Nop>
nmap <Leader>v [vimshell]
nnoremap [quickhl] <Nop>
nmap <Leader>q [quickhl]

" Unite {{{
if neobundle#tap('unite.vim')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'unite_sources': [
        \       'action',
        \       'alias',
        \       'bookmark',
        \       'buffer',
        \       'change',
        \       'command',
        \       'directory',
        \       'file',
        \       'file_list',
        \       'file_point',
        \       'find',
        \       'function',
        \       'grep',
        \       'history_input',
        \       'history_unite',
        \       'history_yank',
        \       'interactive',
        \       'jump',
        \       'jump_point',
        \       'launcher',
        \       'line',
        \       'mapping',
        \       'menu',
        \       'output',
        \       'process',
        \       'rec',
        \       'register',
        \       'resume',
        \       'runtimepath',
        \       'script',
        \       'source',
        \       'tab',
        \       'vimgrep',
        \       'window',
        \       'window_gui',
        \     ],
        \     'commands': [
        \       { 'complete': 'customlist,unite#complete#buffer_name', 'name': 'UniteLast' },
        \       { 'complete': 'customlist,unite#complete#source', 'name': 'UniteWithInput' },
        \       { 'complete': 'customlist,unite#complete#source', 'name': 'UniteWithCurrentDir' },
        \       { 'complete': 'customlist,unite#complete#buffer_name', 'name': 'UniteNext' },
        \       { 'complete': 'customlist,unite#complete#buffer_name', 'name': 'UniteClose' },
        \       { 'complete': 'customlist,unite#complete#source', 'name': 'UniteWithInputDirectory' },
        \       { 'complete': 'customlist,unite#complete#source', 'name': 'UniteWithProjectDir' },
        \       { 'complete': 'file', 'name': 'UniteBookmarkAdd' },
        \       { 'complete': 'customlist,unite#complete#buffer_name', 'name': 'UniteFirst' },
        \       { 'complete': 'customlist,unite#complete#source', 'name': 'UniteWithBufferDir' },
        \       { 'complete': 'customlist,unite#complete#source', 'name': 'UniteWithCursorWord' },
        \       { 'complete': 'customlist,unite#complete#buffer_name', 'name': 'UniteResume' },
        \       { 'complete': 'customlist,unite#complete#buffer_name', 'name': 'UnitePrevious' },
        \       { 'complete': 'customlist,unite#complete#source', 'name': 'Unite' },
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  " insertモードで起動する
  " let g:unite_enable_start_insert=1
  " yank/deleteの履歴を有効にする
  let g:unite_source_history_yank_enable=1
  " ファイル履歴のMAX
  let g:unite_source_file_mru_limit=200

  " この時点でUniteがロードされる気がするので、Lazyの意味はないかもしれない
  call unite#custom_default_action('directory', 'vimfiler')
  " }}}

  " キーマッピング {{{
  " ※ここで定義しているのは、Uniteが標準でもっているsourceのみ
  " バッファ一覧を開く
  nnoremap <silent> [unite]b :Unite buffer<CR>
  " Unite-grep
  nnoremap <silent> [unite]g :Unite grep -buffer-name=grep -no-quit<CR>
  nnoremap <silent> [unite]r :<C-u>UniteResume grep<CR>
  " ブックマーク一覧
  nnoremap <silent> [unite]m :<C-u>Unite bookmark<CR>
  " バッファ内で行を検索
  nnoremap <silent> [unite]l :<C-u>Unite line -start-insert<CR>
  " }}}
endif
" }}}

" neomru {{{
if neobundle#tap('neomru.vim')
  " config {{{
  call neobundle#config({
        \   'augroup': 'neomru',
        \   'autoload': {
        \     'unite_sources': [
        \       'mru',
        \       'neomru',
        \     ],
        \     'commands': [
        \       { 'complete': 'file', 'name': 'NeoMRUImportFile' },
        \       'NeoMRUSave',
        \       { 'complete': 'file', 'name': 'NeoMRUImportDirectory' },
        \       'NeoMRUReload',
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  " 表示フォーマットを指定。空にすると表示スピードが上がるらしい。
  " あまり効果があるようには感じないが、悪さもしないので設定しておく。
  let g:unite_source_file_mru_filename_format = ''
  " }}}

  " キーマッピング {{{
  " 最近使ったファイル
  nnoremap <silent> [unite]u :<C-u>Unite file_mru buffer<CR>
  " }}}
endif
" }}}

" vimfiler {{{
if neobundle#tap('vimfiler')
  " config {{{
  call neobundle#config({
        \   'augroup': 'vimfiler',
        \   'autoload': {
        \     'unite_sources': [
        \       'vimfiler_drive',
        \       'vimfiler_execute',
        \       'vimfiler_history',
        \       'vimfiler_mask',
        \       'vimfiler_popd',
        \       'vimfiler_sort',
        \     ],
        \     'mappings': [
        \       [ 'n', '<Plug>(vimfiler_' ],
        \     ],
        \     'commands': [
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerCurrentDir' },
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFiler' },
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerBufferDir' },
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerSimple' },
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerWrite' },
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerCreate' },
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerExplorer' },
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerEdit' },
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerDouble' },
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerSplit' },
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerSource' },
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerRead' },
        \       'VimFilerClose',
        \       { 'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerTab' },
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  " デフォルトのファイラをvimfilerに置き換える
  let g:vimfiler_as_default_explorer = 1
  " }}}

  " キーマッピング {{{
  " 現在開いているバッファのディレクトリを開く
  nnoremap <silent> [vimfiler]e :<C-u>VimFilerBufferDir -quit<CR>
  " 現在開いているバッファをIDE風に開く
  nnoremap <silent> [vimfiler]i :<C-u>VimFilerExplorer -split -winwidth=40 -find -no-quit<CR>
  " }}}
endif
" }}}

" neocomplete {{{
if neobundle#tap('neocomplete.vim')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'insert': 1,
        \     'unite_sources': [
        \       'file_include',
        \       'neocomplete',
        \     ],
        \     'mappings': [
        \       [ 'i', '<Plug>(neocomplete_start_' ],
        \     ],
        \     'commands': [
        \       'NeoCompleteAutoCompletionLength',
        \       { 'complete': 'buffer', 'name': 'NeoCompleteIncludeMakeCache' },
        \       'NeoCompleteClean',
        \       'NeoCompleteUnlock',
        \       { 'complete': 'customlist,neocomplete#filetype_complete', 'name': 'NeoCompleteSyntaxMakeCache' },
        \       'NeoCompleteTagMakeCache',
        \       'NeoCompleteEnable',
        \       { 'complete': 'customlist,neocomplete#filetype_complete', 'name': 'NeoCompleteDictionaryMakeCache' },
        \       { 'complete': 'buffer', 'name': 'NeoCompleteVimMakeCache' },
        \       'NeoCompleteLock',
        \       'NeoCompleteDisable',
        \       'NeoCompleteToggle',
        \       { 'complete': 'filetype', 'name': 'NeoCompleteSetFileType' },
        \       { 'complete': 'file', 'name': 'NeoCompleteBufferMakeCache' },
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  " AutoComplPopを無効化する（入れてないから不要なはず）
  let g:acp_enableAtStartup = 0
  " neocompleteを有効化
  let g:neocomplete#enable_at_startup = 1
  " スマートケース
  let g:neocomplete#enable_smart_case = 1
  " 最小の入力数
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " 辞書定義
  let g:neocomplete#sources#dictionary#dictionaries = {
        \   'default': '',
        \   'vimshell': $HOME.'/.vimshell_hist',
        \   'scheme': $HOME.'/.gosh_completions'
        \ }

  " キーワード定義
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " オムニ補完
  augroup vimrc_neocomplete
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  augroup END

  " " ヘビーなオムニ補完を有効化
  " if !exists('g:neocomplete#sources#omni#input_patterns')
  "   let g:neocomplete#sources#omni#input_patterns = {}
  " endif
  " let g:neocomplete#sources#omni#input_patterns.php = '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
  " }}}

  " キーマッピング {{{
  " inoremap <expr><C-g> neocomplete#undo_completion()
  " inoremap <expr><C-l> neocomplete#complete_common_string()

  " 推奨されるキーマッピング
  " CRでポップアップをクローズしてインデントを保存
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
  endfunction
  " TABで補完
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>や<BS>でポップアップをクローズして1文字消す
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y> neocomplete#close_popup()
  inoremap <expr><C-e> neocomplete#cancel_popup()
  " }}}
endif
" }}}

" neosnippet.vim {{{
if neobundle#tap('neosnippet.vim')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'on_source': ['neocomplete.vim'],
        \     'unite_sources': [
        \       'neosnippet',
        \       'neosnippet_file',
        \     ],
        \     'mappings': [
        \       [ 'sxi', '<Plug>(neosnippet_' ],
        \     ],
        \     'commands': [
        \       'NeoSnippetClearMarkers',
        \       { 'complete': 'file', 'name': 'NeoSnippetSource' },
        \       { 'complete': 'customlist,neosnippet#commands#_filetype_complete', 'name': 'NeoSnippetMakeCache' },
        \       { 'complete': 'customlist,neosnippet#commands#_edit_complete', 'name': 'NeoSnippetEdit' },
        \     ],
        \   },
        \ })
  " }}}

  " キーマッピング {{{
  " プラグインキーマッピング
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)

  " Tabでも補完する
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif
  " }}}
endif
" }}}

" neosnippet-snippets {{{
if neobundle#tap('neosnippet-snippets')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'on_source': ['neosnippet.vim'],
        \   },
        \ })
  " }}}
endif
" }}}

" neosnippet-additional {{{
if neobundle#tap('neosnippet-additional')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'on_source': ['neosnippet.vim'],
        \   },
        \ })
  " }}}

  " on_source {{{
  function! neobundle#tapped.hooks.on_source(bundle) abort
    " 開発版と公開版とでパスを分ける必要があるので、ここで設定する
    if !exists('g:neosnippet#snippets_directory')
      let g:neosnippet#snippets_directory = []
    endif
    let g:neosnippet#snippets_directory += [a:bundle.path . '/snippets/']
  endfunction
  " }}}
endif
" }}}

" fugitive {{{
if neobundle#tap('vim-fugitive')
  " settings {{{
  augroup vimrc_fugitive
    autocmd!
    " Windowsだとコミット画面のfencがcp932になるので、強制的にutf-8にする
    " オプションで変更できたりするのかな？
    autocmd FileType gitcommit :set fileencoding=utf-8
  augroup END
  " }}}

  " キーマッピング {{{
  " git-status
  nnoremap <silent> [git]s :<C-u>Gstatus<CR>
  " git-diff
  nnoremap <silent> [git]d :<C-u>Gvdiff<CR>
  " }}}
endif
" }}}

" agit {{{
if neobundle#tap('agit.vim')
  " キーマッピング {{{
  nnoremap <silent> [git]a :<C-u>Agit<CR>
  " }}}
endif
" }}}

" Merginal {{{
if neobundle#tap('vim-merginal')
  " キーマッピング {{{
  nnoremap <silent> [git]m :<C-u>Merginal<CR>
  " }}}
endif
" }}}

" vimshell {{{
if neobundle#tap('vimshell')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'unite_sources': [
        \       'vimshell_external_history',
        \       'vimshell_history',
        \       'vimshell_zsh_complete',
        \     ],
        \     'mappings': [
        \       [ 'n', '<Plug>(vimshell_' ],
        \     ],
        \     'commands': [
        \       { 'complete': 'customlist,vimshell#complete', 'name': 'VimShell' },
        \       { 'complete': 'customlist,vimshell#complete', 'name': 'VimShellPop' },
        \       { 'complete': 'customlist,vimshell#complete', 'name': 'VimShellCreate' },
        \       { 'complete': 'customlist,vimshell#complete', 'name': 'VimShellCurrentDir' },
        \       { 'complete': 'customlist,vimshell#helpers#vimshell_execute_complete', 'name': 'VimShellExecute' },
        \       { 'complete': 'customlist,vimshell#complete', 'name': 'VimShellBufferDir' },
        \       'VimShellSendString',
        \       { 'complete': 'customlist,vimshell#complete', 'name': 'VimShellTab' },
        \       { 'complete': 'buffer', 'name': 'VimShellSendBuffer' },
        \       'VimShellClose',
        \       { 'complete': 'customlist,vimshell#helpers#vimshell_execute_complete', 'name': 'VimShellInteractive' },
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  let g:vimshell_prompt_expr = 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
  let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '
  " }}}

  " キーマッピング {{{
  nnoremap <silent> [vimshell]p :<C-u>VimShellPop<CR>

  augroup vimrc_vimshell
    autocmd!
    autocmd FileType vimshell call <SID>mapping_vimshell_q()
  augroup END
  function! s:mapping_vimshell_q() abort
    nmap <silent> <buffer> q <Plug>(vimshell_exit)
    nmap <silent> <buffer> <C-g> <Plug>(vimshell_exit)
    imap <silent> <buffer> <C-g><C-g> <Plug>(vimshell_exit)
  endfunction
  " }}}
endif
" }}}

" eskk {{{
if neobundle#tap('eskk.vim')
  " settings {{{
  let g:eskk#directory = '~/.skk'
  if has('gui_running')
    set imdisable
  endif
  if has('vim_starting')
    if neobundle#tap('neocomplete.vim')
      let g:eskk#enable_completion=1
    endif
    let g:eskk#dictionary = {
          \   'path': '~/.skk/skk-jisyo.user',
          \   'sorted': 0,
          \   'encoding': 'utf-8',
          \ }
    let g:eskk#large_dictionary = {
          \   'path': '~/.skk/SKK-JISYO.L',
          \   'sorted': 1,
          \   'encoding': 'euc-jp',
          \ }
  endif
  " }}}
endif
" }}}

" vim-unified-diff {{{
if neobundle#tap('vim-unified-diff')
  " settings {{{
  set diffexpr=unified_diff#diffexpr()

  " configure with the flllowings (default values are shown below)
  "let unified_diff#executable = 'git'
  "let unified_diff#arguments = [
  "  \   'diff', '--no-index', '--no-color', '--no-ext-diff', '--unified=0',
  "  \ ]
  "let unified_diff#iwhite_arguments = [
  "  \   '--ignore--all-space',
  "  \ ]
  " }}}
endif

" }}}

" nebula {{{
if neobundle#tap('nebula.vim')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'commands': [
        \       'NebulaPutLazy',
        \       'NebulaPutFromClipboard',
        \       'NebulaYankOptions',
        \       'NebulaYankConfig',
        \       'NebulaPutConfig',
        \       'NebulaYankTap',
        \     ],
        \   },
        \ })
  " }}}

  " キーマッピング {{{
  augroup vimrc_nebula
    autocmd!
    autocmd FileType vim
          \   nnoremap <silent> <buffer> [nebula]l :<C-u>NebulaPutLazy<CR>
          \ | nnoremap <silent> <buffer> [nebula]c :<C-u>NebulaPutConfig<CR>
          \ | nnoremap <silent> <buffer> [nebula]y :<C-u>NebulaYankOptions<CR>
          \ | nnoremap <silent> <buffer> [nebula]p :<C-u>NebulaPutFromClipboard<CR>
  augroup END
  " }}}
endif
" }}}

" vim-scala {{{
if neobundle#tap('vim-scala')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'commands': [
        \       'SortScalaImports',
        \     ],
        \     'filetypes': [
        \       'sbt.scala',
        \       'scala',
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  if neobundle#is_installed('vim-scala')
    " ftdetectが読み込まれないので、ここで読んでしまう
    augroup vimrc_vim_scala
      autocmd!
      source ~/.vim/bundle/vim-scala/ftdetect/scala.vim
    augroup END
  endif

  " }}}
endif
" }}}

" vim-less {{{
if neobundle#tap('vim-less')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'filetypes': [
        \       'less',
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  if neobundle#is_installed('vim-less')
    " ftdetectが読み込まれないので、ここで読んでしまう
    augroup vimrc_vim_less
      autocmd!
      source ~/.vim/bundle/vim-less/ftdetect/less.vim
    augroup END
  endif

  " }}}
endif
" }}}

" vim-coffee-script {{{
if neobundle#tap('vim-coffee-script')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'filetypes': [
        \       'coffee',
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  if neobundle#is_installed('vim-coffee-script')
    " ftdetectが読み込まれないので、ここで読んでしまう
    augroup vimrc_vim_coffee_script
      autocmd!
      source ~/.vim/bundle/vim-coffee-script/ftdetect/coffee.vim
    augroup END
  endif

  " }}}
endif
" }}}

" vim-vimlint {{{
if neobundle#tap('vim-vimlint')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'commands': [
        \       { 'complete': 'customlist,vimlint#util#complete', 'name': 'VimLint' },
        \     ],
        \     'on_source': [
        \       'vim-watchdogs',
        \     ],
        \   },
        \ })
  " }}}

  " on_source {{{
  function! neobundle#tapped.hooks.on_source(bundle) abort
    if neobundle#is_sourced(a:bundle.name)
      function! s:get_plugin_dir(plugin_name) abort
        return substitute(fnamemodify(globpath(&rtp, 'autoload/'.a:plugin_name.'.vim'), ':h:h'), '\\', '/', 'g')
      endfunction

      if !exists('g:quickrun_config')
        let g:quickrun_config = {}
      endif
      if !has_key(g:quickrun_config, 'vim/watchdogs_checker')
        let g:quickrun_config['vim/watchdogs_checker'] = {}
      endif
      let g:quickrun_config['vim/watchdogs_checker']['type'] = 'watchdogs_checker/vimlint'
      if !has_key(g:quickrun_config, 'watchdogs_checker/vimlint')
        let g:quickrun_config['watchdogs_checker/vimlint'] = {}
      endif
      let g:quickrun_config['watchdogs_checker/vimlint']['exec'] = '%C -X -N -u NONE -i NONE -V1 -e -s -c "set rtp+='.s:get_plugin_dir('vimlparser').','.s:get_plugin_dir('vimlint').'" -c "call vimlint#vimlint(''%s'', %{ exists(''g:vimlint#config'') ? string(g:vimlint#config) : g:watchdogs#vimlint_empty_config })" -c "qall!"'
      call watchdogs#setup(g:quickrun_config)
    endif
  endfunction
  " }}}

endif
" }}}

" vim-watchdogs {{{
if neobundle#tap('vim-watchdogs')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'commands': [
        \       'WatchdogsRunSweep',
        \       { 'complete': 'customlist,quickrun#complete', 'name': 'WatchdogsRun' },
        \       { 'complete': 'customlist,quickrun#complete', 'name': 'WatchdogsRunSilent' },
        \     ],
        \     'insert': 1,
        \   },
        \ })
  " }}}

  " on_source {{{
  function! neobundle#tapped.hooks.on_source(bundle) abort
    if neobundle#is_sourced(a:bundle.name)
      " 設定を追加してやる
      call watchdogs#setup(g:quickrun_config)
    endif
  endfunction
  " }}}

  " settings {{{
  if !exists('g:quickrun_config')
    let g:quickrun_config = {}
  endif
  if !has_key(g:quickrun_config, 'watchdogs_checker/_')
    let g:quickrun_config['watchdogs_checker/_'] = {}
  endif
  let g:quickrun_config['watchdogs_checker/_']['runner/vimproc/updatetime'] = 20
  let g:quickrun_config['watchdogs_checker/_']['outputter/quickfix/open_cmd'] = ''

  " 書き込み後にシンタックスチェックを行う
  let g:watchdogs_check_BufWritePost_enable = 1

  " 一定時間以上キー入力がなかった場合にシンタックスチェックを行う
  " バッファに書き込み後、1度だけ行われる
  let g:watchdogs_check_CursorHold_enable = 1

  " }}}
endif
" }}}

" vim-qfsigns {{{
if neobundle#tap('vim-qfsigns')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'commands': [
        \       'QfsignsClear',
        \       'QfsignsJunmp',
        \       'QfsignsUpdate',
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  if !exists('g:quickrun_config')
    let g:quickrun_config = {}
  endif
  if !has_key(g:quickrun_config, 'watchdogs_checker/_')
    let g:quickrun_config['watchdogs_checker/_'] = {}
  endif
  let g:quickrun_config['watchdogs_checker/_']['hook/qfsigns_update/enable_exit'] = 1
  let g:quickrun_config['watchdogs_checker/_']['hook/qfsigns_update/priority_exit'] = 3

  let g:qfsigns#AutoJump = 1
  " }}}
endif
" }}}

" vim-qfstatusline {{{
if neobundle#tap('vim-qfstatusline')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'commands': [
        \       'QfstatuslineUpdate',
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  if !exists('g:quickrun_config')
    let g:quickrun_config = {}
  endif
  if !has_key(g:quickrun_config, 'watchdogs_checker/_')
    let g:quickrun_config['watchdogs_checker/_'] = {}
  endif
  let g:quickrun_config['watchdogs_checker/_']['hook/qfstatusline_update/enable_exit'] = 1
  let g:quickrun_config['watchdogs_checker/_']['hook/qfstatusline_update/priority_exit'] = 3

  if neobundle#is_sourced('lightline.vim')
    let g:Qfstatusline#UpdateCmd = function('lightline#update')
  else
    " これだとステータスラインに何も出ないが、無いよりマシ
    let g:Qfstatusline#UpdateCmd = function('qfstatusline#Update')
  endif
  " }}}
endif
" }}}

" restart.vim {{{
if neobundle#tap('restart.vim')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'commands': [
        \       'Restart',
        \       'RestartWithSession',
        \     ],
        \   },
        \   'augroup': 'restart',
        \ })
  " }}}

  " settings {{{
  command! -bar RestartWithSession let g:restart_sessionoptions = 'blank,buffers,curdir,folds,help,localoptions,tabpages' | Restart
  " }}}
endif
" }}}

" Unite-colorscheme {{{
if neobundle#tap('unite-colorscheme')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'unite_sources': ['colorscheme'],
        \   }
        \ })
  " }}}
endif
" }}}

" lightline.vim {{{
if neobundle#tap('lightline.vim')
  " settings {{{
  let g:lightline = {
        \   'separator': {
        \     'left': '⮀',
        \     'right': '⮂',
        \   },
        \   'subseparator': {
        \     'left': '⮁',
        \     'right': '⮃',
        \   },
        \   'active': {
        \     'left': [
        \       [ 'mode', 'eskk', ],
        \       [ 'filename', ],
        \       [ 'fugitive', 'gitinfo', ],
        \     ],
        \     'right': [
        \       [ 'syntaxcheck', 'lineinfo', ],
        \       [ 'fileformat', 'fileencoding', 'filetype', ],
        \       [ 'anzu', ],
        \     ],
        \   },
        \   'component': {
        \     'lineinfo': '%l/%L(%p%%)',
        \     'fileformat': '%{FileInfoVisible() ? &fileformat : ""}',
        \     'filetype': '%{FileInfoVisible() ? (!empty(&filetype) ? &filetype : "no ft") : ""}',
        \     'fileencoding': '%{FileInfoVisible() ? (!empty(&fileencoding) ? &fileencoding : &encoding) : ""}',
        \   },
        \   'component_function': {
        \     'mode': 'Mode',
        \     'eskk': 'Eskk',
        \     'fugitive': 'Fugitive',
        \     'gitinfo': 'Gitinfo',
        \     'filename': 'Filename',
        \     'anzu': 'Anzu',
        \   },
        \   'component_expand': {
        \     'syntaxcheck': 'qfstatusline#Update',
        \   },
        \   'component_visible_condition': {
        \     'eskk': 'EskkVisible()',
        \     'fugitive': 'FugitiveVisible()',
        \     'fileformat': 'FileInfoVisible()',
        \     'filetype': 'FileInfoVisible()',
        \     'fileencoding': 'FileInfoVisible()',
        \     'gitinfo': 'GitinfoVisible()',
        \     'anzu': 'AnzuVisible()',
        \   },
        \   'component_type': {
        \     'syntaxcheck': 'error',
        \   },
        \ }
  function! Mode() abort
    return winwidth(0) > 60 ? lightline#mode() : ''
  endfunction

  function! s:readonly() abort
    return &filetype !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
  endfunction

  function! s:modified() abort
    return &filetype =~# 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! Filename() abort
    return (!empty(s:readonly()) ? s:readonly().' ' : '').
          \ (&filetype ==? 'vimfiler' ? vimfiler#get_status_string() :
          \  &filetype ==? 'unite' ? unite#get_status_string() :
          \  &filetype ==? 'vimshell' ? substitute(b:vimshell.current_dir, expand('~'), '~', '') :
          \  !empty(expand('%')) ? expand('%') : '[No Name]').
          \ (!empty(s:modified()) ? ' '.s:modified() : '')
  endfunction

  function! EskkVisible() abort
    return exists('*eskk#statusline') && !empty(eskk#statusline())
  endfunction

  function! Eskk() abort
    return EskkVisible() ? matchlist(eskk#statusline(), "^\\[eskk:\\(.\\+\\)\\]$")[1] : ''
  endfunction

  function! FugitiveVisible() abort
    return exists('*fugitive#head') && !empty(fugitive#head())
  endfunction

  function! Fugitive() abort
    return FugitiveVisible() ? '⭠ '.fugitive#head() : ''
  endfunction

  function! GitinfoVisible() abort
    return exists('*GitGutterGetHunkSummary') && get(g:, 'gitgutter_enabled', 0) && winwidth(0) > 90
  endfunction

  function! Gitinfo() abort
    if !GitinfoVisible()
      return ''
    endif

    let symbols = [
          \ g:gitgutter_sign_added.' ',
          \ g:gitgutter_sign_modified.' ',
          \ g:gitgutter_sign_removed.' ',
          \ ]
    let hunks = GitGutterGetHunkSummary()
    let ret = []
    for i in [0, 1, 2]
      if hunks[i] > 0
        call add(ret, symbols[i].hunks[i])
      endif
    endfor

    return join(ret, ' ')
  endfunction

  function! FileInfoVisible() abort
    return winwidth(0) > 70
  endfunction

  function! AnzuVisible() abort
    return exists('*anzu#search_status') && !empty(anzu#search_status()) && winwidth(0) > 70
  endfunction

  function! Anzu() abort
    return anzu#search_status()
  endfunction

  " リアルタイムにカラースキームを書き換えるための細工（helpからコピー）
  augroup LightLineColorscheme
    autocmd!
    autocmd ColorScheme * call s:lightline_update()
  augroup END
  function! s:lightline_update()
    try
      if g:colors_name =~# 'wombat\|solarized\|landscape\|jellybeans\|Tomorrow'
        let g:lightline.colorscheme =
              \ substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '') .
              \ (g:colors_name ==# 'solarized' ? '_' . &background : '')
      else
        let g:lightline.colorscheme = 'default'
      endif
      call lightline#init()
      call lightline#colorscheme()
      call lightline#update()
    catch
    endtry
  endfunction
  " }}}
endif
" }}}

" vim-gitgutter {{{
if neobundle#tap('vim-gitgutter')
  " settings {{{
  let g:gitgutter_sign_added = 'A'
  let g:gitgutter_sign_modified = 'M'
  let g:gitgutter_sign_removed = 'D'
  let g:gitgutter_sign_modified_removed = 'MD'

  " デフォルトのマッピングをOFFにする
  let g:gitgutter_map_keys = 0
  " }}}

  " キーマッピング {{{
  nnoremap <silent> [git]h :<C-u>GitGutterLineHighlightsToggle<CR>

  " gitgutterのデフォルトマッピングを無効にしているので、必要なものを追加する
  nmap [c <Plug>GitGutterPrevHunk
  nmap ]c <Plug>GitGutterNextHunk
  " }}}
endif
" }}}

" unite-tag {{{
if neobundle#tap('unite-tag')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'unite_sources': ['tag'],
        \   },
        \ })
  " }}}

  " settings {{{
  let g:unite_source_tag_max_fname_length = 100
  let g:unite_source_tag_max_name_length = 15
  " }}}

  " キーマッピング {{{
  augroup vimrc_unite_tag
    autocmd!
    autocmd BufEnter *
          \   if empty(&buftype)
          \|    nnoremap <silent> <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
          \|    nnoremap <silent> <buffer> <C-t> :<C-u>Unite jump<CR>
          \|  endif
  augroup END
  " }}}
endif
" }}}

" vim-anzu {{{
if neobundle#tap('vim-anzu')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'unite_sources': ['anzu'],
        \     'mappings': [
        \       [ 'sxno', '<Plug>(anzu-' ],
        \     ],
        \     'commands': [
        \       'AnzuUpdateSearchStatus',
        \       'AnzuClearSearchCache',
        \       'AnzuUpdateSearchStatusOutput',
        \       'AnzuClearSearchStatus',
        \       'AnzuSignMatchLine',
        \       'AnzuClearSignMatchLine',
        \     ],
        \   },
        \ })
  " }}}

  " キーマッピング {{{
  nmap n <Plug>(anzu-n)zz
  nmap N <Plug>(anzu-N)zz
  nmap * <Plug>(anzu-star)zz
  nmap # <Plug>(anzu-sharp)zz

  augroup vimrc_vim_anzu
    autocmd!
    " 一定時間の入力なし、ウィンドウ移動、タブ移動のときにヒット数の表示を消す
    autocmd CursorHold,CursorHoldI,WinLeave,TabLeave * call anzu#clear_search_status()
  augroup END

  " ESC連打でハイライトを消す
  nnoremap <silent> <Esc><Esc> :nohlsearch<CR>:AnzuClearSearchStatus<CR><Esc>
  " }}}
endif
" }}}

" vim-operator-replace {{{
if neobundle#tap('vim-operator-replace')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'mappings': [
        \       [ 'nx', '<Plug>(operator-replace' ],
        \     ],
        \   },
        \ })
  " }}}

  " キーマッピング {{{
  map R <Plug>(operator-replace)
  " }}}
endif
" }}}

" vim-ref {{{
if neobundle#tap('vim-ref')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'unite_sources': ['ref'],
        \     'mappings': [
        \       [ 'sxn', '<Plug>(ref-keyword)', 'K' ],
        \     ],
        \     'commands': [
        \       { 'complete': 'customlist,ref#complete', 'name': 'Ref' },
        \       'RefHistory',
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  " ホームディレクトリは'~'だとダメっぽい
  let g:ref_cache_dir = $HOME.'/.vim/vim_ref_cache'

  " PHP
  let g:ref_phpmanual_path = $HOME.'/.vim/refs/php-chunked-xhtml'
  " }}}

  " キーマッピング {{{
  augroup vimrc_vim_ref
    autocmd!
    autocmd FileType * if &filetype =~# '\v^ref-.+' | nnoremap <silent> <buffer> q :bdelete<CR> | endif
  augroup END
  " }}}
endif
" }}}

" unite-quickfix {{{
if neobundle#tap('unite-quickfix')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'unite_sources': [
        \       'location_list',
        \       'q',
        \       'quickfix',
        \     ],
        \   },
        \ })
  " }}}

  " キーマッピング {{{
  nnoremap <silent> [unite]q :Unite -no-quit -no-start-insert quickfix<CR>
  " }}}
endif
" }}}

" vim-prettyprint {{{
if neobundle#tap('vim-prettyprint')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'commands': [
        \       { 'complete': 'expression', 'name': 'PP' },
        \       { 'complete': 'expression', 'name': 'PrettyPrint' },
        \     ],
        \     'functions': [
        \       'PrettyPrint',
        \       'PP',
        \     ],
        \     'on_source': ['vim-editvar'],
        \   },
        \ })
  " }}}

  " settings {{{
  let g:prettyprint_show_expression = 1
  let g:prettyprint_string = []
  " }}}

  " キーマッピング {{{
  nnoremap <silent> <C-p> :PP <C-r>=expand("<cWORD>")<CR><CR>
  " }}}
endif
" }}}

" vim-editvar {{{
if neobundle#tap('vim-editvar')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'unite_sources': ['variable'],
        \     'commands': [
        \       { 'complete': 'var', 'name': 'Editvar' },
        \     ],
        \   },
        \ })
  " }}}

  " キーマッピング {{{
  augroup vimrc_vim_editvar
    autocmd!
    autocmd BufWinEnter * if expand('<afile>') =~# '\v^editvar://.+' | nnoremap <silent> <buffer> q :bdelete<CR> | endif
  augroup END
  " }}}
endif
" }}}

" vim-operator-assign {{{
if neobundle#tap('vim-operator-assign')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'mappings': [
        \       [ 'nx', '<Plug>(operator-assign' ],
        \     ],
        \   },
        \ })
  " }}}

  " キーマッピング {{{
  nmap zx <Plug>(operator-assign)
  vmap zx <Plug>(operator-assign)
  " }}}
endif
" }}}

" html5.vim {{{
if neobundle#tap('html5.vim')
  " config {{{
  call neobundle#config({
        \   'autoload' : {
        \     'filetypes': [
        \       'html',
        \       'smarty',
        \     ],
        \   },
        \ })
  " }}}
endif
" }}}

" javascript-libraries-syntax.vim {{{
if neobundle#tap('javascript-libraries-syntax.vim')
  " config {{{
  call neobundle#config({
        \   'autoload' : {
        \     'filetypes': [
        \       'html',
        \       'javascript',
        \     ],
        \   },
        \ })
  " }}}
endif
" }}}

" tern_for_vim {{{
if neobundle#tap('tern_for_vim')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'commands': [
        \       'TernDocBrowse',
        \       'TernType',
        \       'TernRename',
        \       'TernDefPreview',
        \       'TernDoc',
        \       'TernDef',
        \       'TernDefTab',
        \       'TernDefSplit',
        \       'TernRefs',
        \     ],
        \     'filetypes': [
        \       'html',
        \       'javascript',
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  let g:tern_show_argument_hints = 'on_move'
  let g:tern#command = ['nodejs', fnamemodify('~/.vim/bundle/', ':p') . '/' . neobundle#tapped.name . '/node_modules/tern/bin/tern', '--no-port-file']
  " }}}
endif
" }}}

" smarty-syntax {{{
if neobundle#tap('smarty-syntax')
  " config {{{
  call neobundle#config({
        \   'autoload' : {
        \     'filetypes': [
        \       'smarty',
        \     ],
        \   },
        \ })
  " }}}
endif
" }}}

" vim-quickhl {{{
if neobundle#tap('vim-quickhl')
  " config {{{
  call neobundle#config({
        \   'augroup': 'QuickhlManual',
        \   'autoload': {
        \     'mappings': [
        \       [ 'sxn', '<Plug>(quickhl-' ],
        \     ],
        \     'commands': [
        \       'QuickhlManualUnlockWindow',
        \       'QuickhlManualDelete',
        \       'QuickhlTagToggle',
        \       'QuickhlManualDisable',
        \       'QuickhlTagDisable',
        \       'QuickhlManualAdd',
        \       'QuickhlManualColors',
        \       'QuickhlManualReset',
        \       'QuickhlManualLockToggle',
        \       'QuickhlManualLock',
        \       'QuickhlManualEnable',
        \       'QuickhlManualList',
        \       'QuickhlCwordEnable',
        \       'QuickhlManualUnlock',
        \       'QuickhlCwordDisable',
        \       'QuickhlTagEnable',
        \       'QuickhlManualLockWindowToggle',
        \       'QuickhlManualLockWindow',
        \       'QuickhlCwordToggle',
        \     ],
        \   },
        \ })
  " }}}

  " キーマッピング {{{
  nmap [quickhl]m <Plug>(quickhl-manual-this)
  xmap [quickhl]m <Plug>(quickhl-manual-this)
  nmap [quickhl]M <Plug>(quickhl-manual-reset)
  xmap [quickhl]M <Plug>(quickhl-manual-reset)

  nmap [quickhl]j <Plug>(quickhl-cword-toggle)
  nmap [quickhl]] <Plug>(quickhl-tag-toggle)
  " TODO ↓がよく分からない
  " map H <Plug>(operator-quickhl-manual-this-motion)
  " }}}
endif
" }}}

" splitjoin.vim {{{
if neobundle#tap('splitjoin.vim')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'mappings': [
        \       [ 'n', '<Plug>Splitjoin', 'gJ', 'gS' ],
        \     ],
        \     'commands': [
        \       'SplitjoinSplit',
        \       'SplitjoinJoin',
        \     ],
        \   },
        \ })
  " }}}
endif
" }}}

" colorizer {{{
if neobundle#tap('colorizer')
  " config {{{
  call neobundle#config({
        \   'augroup': 'Colorizer',
        \   'autoload': {
        \     'mappings': [
        \       [ 'n', '<Plug>Colorizer' ],
        \     ],
        \     'commands': [
        \       'ColorToggle',
        \       'ColorHighlight',
        \       'ColorClear',
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  augroup vimrc_colorizer
    autocmd!
    autocmd FileType html,css :ColorHighlight
  augroup END
  " }}}
endif
" }}}

" vim-textobj-between {{{
if neobundle#tap('vim-textobj-between')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'mappings': [
        \       [ 'xo', '<Plug>(textobj-between', 'af', 'if' ],
        \     ],
        \   },
        \ })
  " }}}
endif
" }}}

" incsearch.vim {{{
if neobundle#tap('incsearch.vim')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'mappings': [
        \       [ 'sxno', '<Plug>(_incsearch-N)' ],
        \       [ 'sxno', '<Plug>(incsearch-nohl-N)' ],
        \       [ 'sxno', '<Plug>(_incsearch-#)' ],
        \       [ 'sxno', '<Plug>(_incsearch-*)' ],
        \       [ 'sxno', '<Plug>(incsearch-nohl-#)' ],
        \       [ 'sxno', '<Plug>(incsearch-forward)' ],
        \       [ 'sxno', '<Plug>(incsearch-nohl-*)' ],
        \       [ 'sxno', '<Plug>(incsearch-stay)' ],
        \       [ 'sxno', '<Plug>(incsearch-nohl)' ],
        \       [ 'sxno', '<Plug>(incsearch-nohl-g*)' ],
        \       [ 'sxno', '<Plug>(_incsearch-n)' ],
        \       [ 'sxno', '<Plug>(incsearch-nohl-n)' ],
        \       [ 'sxno', '<Plug>(incsearch-nohl0)' ],
        \       [ 'sxno', '<Plug>(_incsearch-g#)' ],
        \       [ 'sxno', '<Plug>(incsearch-backward)' ],
        \       [ 'sxno', '<Plug>(_incsearch-g*)' ],
        \       [ 'sxno', '<Plug>(incsearch-nohl-g#)' ],
        \       [ 'sxno', '<Plug>(incsearch-nohl2)' ],
        \     ],
        \     'commands': [
        \       'IncSearchNoreMap',
        \       'IncSearchMap',
        \     ],
        \   },
        \ })
  " }}}

  " settings {{{
  " magicを標準にする
  let g:incsearch#magic = '\v'
  " }}}

  " キーマッピング {{{
  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  if neobundle#tap('vim-anzu')
    nmap n <Plug>(incsearch-nohl)<Plug>(anzu-n)
    nmap N <Plug>(incsearch-nohl)<Plug>(anzu-N)
  endif
  " }}}
endif
" }}}

" vim-operator-surround {{{
if neobundle#tap('vim-operator-surround')
  " config {{{
  call neobundle#config({
        \   'autoload': {
        \     'mappings': [
        \       [ 'nx', '<Plug>(operator-surround' ],
        \       [ 'n', '<Plug>(operator-surround-repeat)' ],
        \     ],
        \   },
        \ })
  " }}}

  " キーマッピング {{{
  map <silent> ra <Plug>(operator-surround-append)
  map <silent> rd <Plug>(operator-surround-delete)
  map <silent> rc <Plug>(operator-surround-replace)

  if neobundle#tap('vim-textobj-between')
    nmap <silent> raf <Plug>(operator-surround-append)<Plug>(textobj-between-a)
    nmap <silent> rdf <Plug>(operator-surround-delete)<Plug>(textobj-between-a)
    nmap <silent> rcf <Plug>(operator-surround-replace)<Plug>(textobj-between-a)
  endif
  " }}}
endif
" }}}

" }}}

" 表示設定 {{{
" ↓これはswitchでutf-8にしておけば回避できそうなので、しばらく放置
" if has('unix')
"   " Linuxで文字化けするので、Linuxならtermencodingをutf-8にする（kaoriya vimrcではcp932になる？）
"   set termencoding=utf-8
"   set encoding=utf-8
" endif

" シンタックスハイライト
syntax enable

if !has('gui_running')
  set t_Co=256
  set background=dark
  if neobundle#is_sourced('vim-colors-solarized')
    colorscheme solarized
  else
    colorscheme desert
  endif
endif


" 行番号を表示
set number
" 相対行数を表示（一応、バージョンを確認しておく）
if v:version >= 703
  set relativenumber
endif

" ルーラーを表示
set ruler

" タブや改行を表示
if has('unix')
  set list
  set listchars=tab:»\ ,extends:<,trail:>
endif

" 画面上でのタブ幅
set tabstop=4
" ↓これをやらないとインデントが余分に入る
set shiftwidth=4
" 改行しない
set nowrap
" 自動折り返しなし
set tw=0

" カーソル行をハイライト
set cursorline

" vimdiffの色設定
" TODO 調整の余地あり
highlight DiffAdd cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText cterm=bold ctermfg=10 ctermbg=21

" TODO タブなど（listcharsの文字色）を指定
" highlight SpecialKey term=bold cterm=bold ctermfg=11 ctermbg=0 guifg=Cyan

" すごく長い行も表示する
set display=lastline

" 補完メニューの高さ
set pumheight=10

" 括弧入力時のマッチ設定
set showmatch
set matchtime=2
" }}}

" ファイル操作設定 {{{
" バックアップファイルを作成する
set backup

" バックアップファイルの作成場所
set backupdir=$HOME/.vim/.backup
" スワップファイルの作成場所
set directory=$HOME/.vim/.backup
" undoファイル（.*.un~）の作成場所
set undodir=$HOME/.vim/.backup

" 編集中でも他のファイルを開けるように
set hidden

" 保存時に行末の空白を除去
augroup vimrc_del_end_ws
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//ge
augroup END

" }}}

" ファイルタイプ設定 {{{

" PHP {{{
let g:php_sql_query = 1
let g:php_baselib = 1
let g:php_htmlInStrings = 1
" let g:php_noShortTags = 1
let g:php_folding = 1

" DBをMySQLにする（シンタックスハイライトがきく？）
let g:sql_type_default='mysql'
" }}}

" Smarty {{{
augroup vimrc_ftdetect_smarty
  autocmd!
  autocmd BufReadPost *.tpl set filetype=smarty.html
augroup END
" }}}

" }}}

" コマンドラインの設定 {{{
" 先頭へ
cnoremap <C-a> <Home>
" 末尾へ
cnoremap <C-e> <End>
" 1文字戻る
cnoremap <C-b> <Left>
" 1文字進む
cnoremap <C-f> <Right>
" 1文字削除
cnoremap <C-d> <Del>
" C-pを<Up>にすることで、単純な履歴ではなく先頭一致で履歴をたどってくれる
cnoremap <C-p> <Up>
" C-nも<Down>にする
cnoremap <C-n> <Down>

" 検索時のスラッシュ(/)を簡単に入力する
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
" }}}

" その他の設定 {{{
" クリップボードを共有
set clipboard=unnamed,unnamedplus

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" Ctrl+a,Ctrl+xでインクリメント、デクリメントするときに、先頭に
" 0詰めされた 001 などを8進数ではなく普通の数字とみなす
set nf=""

" autodate.vimのフォーマットを指定
let g:autodate_format = '%Y/%m/%d %H:%M:%S'

" Git管理下のファイルを開いたら、.gitがあるディレクトリにカレントを移動する
augroup vimrc_git_dir
  autocmd!
  autocmd BufWinEnter * :call s:cd_git_root()
augroup END
function! s:cd_git_root() abort
  let buf_path = fnamemodify(expand('%'), ':p')
  if !isdirectory(buf_path)
    let buf_path = fnamemodify(buf_path, ':h')
  endif

  let git_dir = finddir('.git', buf_path . ';**/')
  if !empty(git_dir)
    execute 'lcd ' . fnamemodify(git_dir, ':p:h:h')
  endif
endfunction

" }}}

" プラグイン非依存のキーマッピング {{{
" 危険なキーマッピングを無効に
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

if !neobundle#is_sourced('vim-anzu')
  " anzuがロードされていなければ、<Esc><Esc>のマッピングをこっちにする
  nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><Esc>
endif

" 表示行で移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" 実際の行で移動
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

" 行末までコピー（Dで行末まで削除できるのに合わせる）
nnoremap Y y$

" アスタリスクでの検索時に、最初に次の位置へ移動してしまうのを改善
nnoremap * *<C-o>zz
nnoremap g* g*<C-o>zz
nnoremap # #<C-o>zz
nnoremap g# g#<C-o>zz

" a>やi>を記号に置き換える
" キーボード配列によらず使えるのもいい
onoremap aa a>
onoremap ar a]
onoremap ad a"
onoremap as a'
onoremap ia i>
onoremap ir i]
onoremap id i"
onoremap is i'
vnoremap aa a>
vnoremap ar a]
vnoremap ad a"
vnoremap as a'
vnoremap ia i>
vnoremap ir i]
vnoremap id i"
vnoremap is i'

" x,s,cをヤンク目的で使うことはまずないので、捨てる
nnoremap x "_x
nnoremap s "_s
nnoremap c "_c
vnoremap x "_x
vnoremap s "_s
vnoremap c "_c

" vimrcを開く
nnoremap <silent> ,ev :<C-u>edit <C-r>=resolve(expand($MYVIMRC))<CR><CR>
" vimrcをリロード
nnoremap <silent> ,rv :<C-u>source $MYVIMRC<CR>

if has('gui_running')
  " gvimrcを開く
  nnoremap <silent> ,eg :<C-u>edit <C-r>=resolve(expand($MYGVIMRC))<CR><CR>
  " gvimrcをリロード
  nnoremap <silent> ,rg :<C-u>source $MYGVIMRC<CR>
endif

" デフォルトでKはmanをひくようになっているので、変更
set keywordprg=:help

" helpなどをqで閉じる
augroup vimrc_mapping_q
  autocmd!
  autocmd BufWinEnter * if &buftype ==# 'help' | call <SID>mapping_q() | endif
  autocmd BufWinEnter * if &buftype ==# 'quickfix' | call <SID>mapping_q() | endif
augroup END
function! s:mapping_q() abort
  nnoremap <silent> <buffer> q :bdelete<CR>
endfunction

" backgroundの light/dark を切り替える
" F5とかでやりたかったが、なぜか妙なキーシーケンスが入力されたので、諦めた
nmap <expr> <C-b> <SID>toggle_background()
function! s:toggle_background() abort
  if &background ==# 'light'
    set background=dark
  else
    set background=light
  endif
endfunction

" splitしているときのウィンドウ移動
nnoremap <Space>h <C-w>h
nnoremap <Space>l <C-w>l
nnoremap <Space>k <C-w>k
nnoremap <Space>j <C-w>j
" }}}

" autoftp {{{
if neobundle#tap('vital.vim') && executable('ncftpput')
  augroup vimrc_autoftp
    autocmd!
    autocmd! BufWinEnter *.php,*.tpl,*.css,*.js call s:autoftp_init()
    autocmd! BufWritePost *.php,*.tpl,*.css,*.js call s:autoftp_upload(0)
  augroup END

  command! AutoFtpUpload call s:autoftp_upload(1)
  command! AutoFtpToggle call s:autoftp_toggle_enable()

  let s:Vital = vital#of('vital')
  let s:Json = s:Vital.import('Web.JSON')

  let s:autoftp_config_default = {
        \   'enable': 1,
        \ }

  function! s:autoftp_init() abort
    if get(b:, 'autoftp_init', 0)
      return
    endif

    let conf_file_name = get(g:, 'autoftp_conf_name', '.autoftp.json')
    let conf_file = findfile(conf_file_name, fnamemodify(expand('%'), ':p:h') . ';**/')
    if empty(conf_file)
      let b:autoftp_init = 1
      return
    endif

    let conf_file = fnamemodify(conf_file, ':p')
    if !s:load_config(conf_file)
      let b:autoftp_init = 1
      return
    endif

    let local_base = fnamemodify(conf_file, ':p:h')

    let relpath = s:autoftp_relpath(expand('%:p'), local_base)
    let b:autoftp_remote_dir = fnamemodify(b:autoftp_config.remote_base . relpath, ':h')
    for from in keys(b:autoftp_config.path_map)
      if stridx(b:autoftp_remote_dir, from) == 0
        let b:autoftp_remote_dir = substitute(b:autoftp_remote_dir, from, b:autoftp_config.path_map[from], '')
        break
      endif
    endfor

    let b:autoftp_local_path = local_base . relpath

    let b:autoftp_init = 1
  endfunction

  function! s:autoftp_relpath(path, base) abort
    let p = expand(a:path)
    if isdirectory(p) && p !~# '/$'
      let p .= '/'
    endif
    let b = expand(a:base)
    if isdirectory(b) && b !~# '/$'
      let b .= '/'
    endif

    return stridx(p, b) == 0 ? p[strlen(b) - 1:] : p
  endfunction

  function! s:autoftp_upload(force) abort
    if !exists('b:autoftp_config') || !a:force && !b:autoftp_config.enable
      return
    endif

    let cmd  = 'ncftpput'
    let cmd .= ' -u '.shellescape(b:autoftp_config.user)
    let cmd .= ' -p '.shellescape(b:autoftp_config.pass)
    if !b:autoftp_config.passive
      let cmd .= ' -E'
    endif
    let cmd .= ' -m -V'
    if b:autoftp_config.timeout > 0
      let cmd .= ' -t '.b:autoftp_config.timeout
    endif
    let cmd .= ' '.shellescape(b:autoftp_config.host)
    let cmd .= ' '.shellescape(b:autoftp_remote_dir)
    let cmd .= ' '.shellescape(b:autoftp_local_path)

    let res = system(cmd)
    if !empty(res)
      call s:err_msg(res)
    endif
  endfunction

  function! s:autoftp_toggle_enable() abort
    if !exists('b:autoftp_config')
      call s:err_msg('autoftpが初期化されていません')
      return
    endif

    let b:autoftp_config.enable = !b:autoftp_config.enable
  endfunction

  function! s:load_config(file_path) abort
    if !filereadable(a:file_path)
      return 0
    endif

    try
      let json_string = join(readfile(a:file_path), ' ')
      let json = s:Json.decode(json_string)
    catch
      return 0
    endtry

    if !s:check_config(json)
      return 0
    endif

    let b:autoftp_config = json
    call extend(b:autoftp_config, s:autoftp_config_default, 'keep')

    return 1
  endfunction

  function! s:check_config(config) abort
    if !has_key(a:config, 'host') || type(a:config.host) != 1 || empty(a:config.host)
      call s:err_msg('.autoftp.josn error: hostは文字列で必ず指定してください')
      return 0
    endif

    if !has_key(a:config, 'user') || type(a:config.user) != 1 || empty(a:config.user)
      call s:err_msg('.autoftp.josn error: userは文字列で必ず指定してください')
      return 0
    endif

    if !has_key(a:config, 'pass') || type(a:config.pass) != 1 || empty(a:config.pass)
      call s:err_msg('.autoftp.josn error: passは文字列で必ず指定してください')
      return 0
    endif

    if has_key(a:config, 'timeout') && (type(a:config.timeout) != 0 || a:config.timeout < 1)
      call s:err_msg('autoftp error: timeoutは正数で指定してください')
      return 0
    endif

    if has_key(a:config, 'path_map') && (type(a:config.timeout) != 4)
      if type(a:config.path_map) != 4
        call s:err_msg('autoftp error: path_mapは辞書型で指定してください')
        return 0
      endif

      for key in keys(a:config.path_map)
        if type(a:config.path_map[key]) != 1
          call s:err_msg('autoftp error: path_mapの値は文字列でなければなりません')
          return 0
        endif
      endfor
    endif

    if has_key(a:config, 'passive') && type(a:config.passive) != 0
      call s:err_msg('autoftp error: passiveは真偽値で指定してください')
      return 0
    endif

    if has_key(a:config, 'enable') && type(a:config.enable) != 0
      call s:err_msg('autoftp error: enableは真偽値で指定してください')
      return 0
    endif

    return 1
  endfunction

  function! s:err_msg(msg) abort
    echohl WarningMsg
    echo a:msg
    echohl None
  endfunction
endif
" }}}

" マーク関係 {{{
nnoremap [mark] <Nop>
nmap <Leader>m [mark]

" マーク番号を自動でふるための準備
if !exists('g:mark_chars')
  let g:mark_chars = [
        \   'a', 'b', 'c', 'd', 'e', 'f', 'g',
        \   'h', 'i', 'j', 'k', 'l', 'm', 'n',
        \   'o', 'p', 'q', 'r', 's', 't', 'u',
        \   'v', 'w', 'x', 'y', 'z',
        \ ]
endif

nnoremap <expr> [mark]m <SID>set_mark()
function! s:set_mark() abort
  if !exists('b:mark_idx')
    let b:mark_idx = -1
  endif
  let b:mark_idx = (b:mark_idx + 1) % len(g:mark_chars)

  execute 'mark ' . g:mark_chars[b:mark_idx]
  echo 'set mark ' . g:mark_chars[b:mark_idx]
endfunction

" 前後のマークに移動するマッピング
nnoremap [mark]j ]`
nnoremap [mark]k [`

" TODO マークがついている行をハイライトしたい
" TODO マーク一覧をUniteで見れるといいかも
" }}}