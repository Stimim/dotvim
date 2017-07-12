" pathogen
"call pathogen#runtime_append_all_bundles()
"

if has("win32") || has("win64")
  let s:uname = "windows"
else
  let s:uname = system("uname -a")
endif

if s:uname =~ "synology"
  let g:pathogen_disabled = ['racer', 'YouCompleteMe']
else
  let g:pathogen_disabled = ['racer', 'neocomplete', 'autocomplpop']
endif

if !has("python")
  call add(g:pathogen_disabled, 'github-issues.vim')
endif

call pathogen#infect()
call pathogen#helptags()
" pathogen

set nocompatible
if exists(":packadd") != 0
  source $VIMRUNTIME/vimrc_example.vim
endif

if s:uname !~ "synology"
  source $VIMRUNTIME/mswin.vim
  behave mswin
endif

if !has("win32") && !has("win64") && s:uname !~ "synology"
  cunmap <C-A>
endif

" add key mapping for suspend
nmap <Space><C-Z> :sus<cr>

"set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

let mapleader=","
autocmd FileType c,cpp :call C_CPPMAP()
function! C_CPPMAP()
  map <buffer> <leader><space> :w<cr>:make<cr>
  nmap <leader>cn :cn<cr>
  nmap <leader>cp :cp<cr>
  nmap <leader>cw :cw 10<cr>
endfunction

map <C-W><C-A> :redraw!<CR>

if s:uname !~ "synology"
  " Fix meta key in vim
  if !has("nvim") && !has("win32") && !has("win64")
    set <M-h>=h
    set <M-j>=j
    set <M-k>=k
    set <M-l>=l
  endif

  " Pair up with 'set winaltkeys=no' in _gvimrc
  nmap <M-h> <C-W>h
  nmap <M-j> <C-W>j
  nmap <M-k> <C-W>k
  nmap <M-l> <C-W>l
  if has("win32") || has("win64")
    set encoding=utf8 " make sure mapping is correct in UTF-8
    nmap <M-h> <C-W>h
    nmap <M-j> <C-W>j
    nmap <M-k> <C-W>k
    nmap <M-l> <C-W>l
    set encoding=cp950
  endif

  " Move in insert mode
  imap <M-h> <Left>
  imap <M-j> <Down>
  imap <M-k> <Up>
  imap <M-l> <Right>
  if has("win32") || has("win64")
    set encoding=utf8 " make sure mapping is correct in UTF-8
    imap <M-h> <Left>
    imap <M-j> <Down>
    imap <M-k> <Up>
    imap <M-l> <Right>
    set encoding=cp950
  endif
endif

" Quickly switch tab
nnoremap <C-j> gT
nnoremap <C-k> gt

" Quickly adjust window size
map <C-w><Space>- <C-w>10-
map <C-w><Space>+ <C-w>10+
map <C-w><Space>< <C-w>10<
map <C-w><Space>> <C-w>10>

" add mapping to delete in insert mode
inoremap <C-b> <Right><BS>

" Win32
"nmap <Leader>x :execute ':! "'.expand('%').'"'<CR>
nmap <Leader>x :!start cmd /c "%:p"<CR>
nmap <Leader>X :!start cmd /K cd /D %:p:h<CR>
nmap <Leader>E :exec "!start explorer \"".expand("%:p:h:gs?\\??:gs?/?\\?")."\""<CR>

" Tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>athen :Tabularize /then<CR>
vmap <Leader>athen :Tabularize /then<CR>
" Tabular

" fuzzyfinder
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> <leader>fj     :FufBuffer<CR>
nnoremap <silent> <leader>fk     :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> <leader>fK     :FufFileWithFullCwd<CR>
nnoremap <silent> <leader>f<C-k> :FufFile<CR>
nnoremap <silent> <leader>fl     :FufCoverageFileChange<CR>
nnoremap <silent> <leader>fL     :FufCoverageFileChange<CR>
nnoremap <silent> <leader>f<C-l> :FufCoverageFileRegister<CR>
nnoremap <silent> <leader>fd     :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> <leader>fD     :FufDirWithFullCwd<CR>
nnoremap <silent> <leader>f<C-d> :FufDir<CR>
nnoremap <silent> <leader>fn     :FufMruFile<CR>
nnoremap <silent> <leader>fN     :FufMruFileInCwd<CR>
nnoremap <silent> <leader>fm     :FufMruCmd<CR>
nnoremap <silent> <leader>fu     :FufBookmarkFile<CR>
nnoremap <silent> <leader>f<C-u> :FufBookmarkFileAdd<CR>
vnoremap <silent> <leader>f<C-u> :FufBookmarkFileAddAsSelectedText<CR>
nnoremap <silent> <leader>fi     :FufBookmarkDir<CR>
nnoremap <silent> <leader>f<C-i> :FufBookmarkDirAdd<CR>
nnoremap <silent> <leader>ft     :FufTag<CR>
nnoremap <silent> <leader>fT     :FufTag!<CR>
nnoremap <silent> <leader>f<C-]> :FufTagWithCursorWord!<CR>
nnoremap <silent> <leader>f,     :FufBufferTag<CR>
nnoremap <silent> <leader>f<     :FufBufferTag!<CR>
vnoremap <silent> <leader>f,     :FufBufferTagWithSelectedText!<CR>
vnoremap <silent> <leader>f<     :FufBufferTagWithSelectedText<CR>
nnoremap <silent> <leader>f}     :FufBufferTagWithCursorWord!<CR>
nnoremap <silent> <leader>f.     :FufBufferTagAll<CR>
nnoremap <silent> <leader>f>     :FufBufferTagAll!<CR>
vnoremap <silent> <leader>f.     :FufBufferTagAllWithSelectedText!<CR>
vnoremap <silent> <leader>f>     :FufBufferTagAllWithSelectedText<CR>
nnoremap <silent> <leader>f]     :FufBufferTagAllWithCursorWord!<CR>
nnoremap <silent> <leader>fg     :FufTaggedFile<CR>
nnoremap <silent> <leader>fG     :FufTaggedFile!<CR>
nnoremap <silent> <leader>fo     :FufJumpList<CR>
nnoremap <silent> <leader>fp     :FufChangeList<CR>
nnoremap <silent> <leader>fq     :FufQuickfix<CR>
nnoremap <silent> <leader>fy     :FufLine<CR>
nnoremap <silent> <leader>fh     :FufHelp<CR>
nnoremap <silent> <leader>fe     :FufEditDataFile<CR>
nnoremap <silent> <leader>fr     :FufRenewCache<CR>
" fuzzyfinder

" CtrlP
if has("python")
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
      \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
" CtrlP

" Vim-CtrlP-CmdPalette
let g:ctrlp_cmdpalette_execute = 1
" Vim-CtrlP-CmdPalette

" zencoding
"let g:user_zen_leader_key = '<c-e>'
" zencoding
" emmet
let g:user_emmet_leader_key = '<c-e>'
" emmet


" delimitMate
"inoremap <silent> <C-Y> <Plug>delimitMateS-Tab
" delimitMate

" nerdtree
"let NERDTreeWinPos = "right"
"nnoremap <silent> <F5> :NERDTreeToggle<CR>
" nerdtreetabs
nnoremap <silent> <F4> :NERDTreeFind<CR>
nnoremap <silent> <F5> :NERDTreeTabsToggle<CR>
nnoremap <silent> <F6> :NERDTreeMirrorToggle<CR>
let g:nerdtree_tabs_open_on_gui_startup = 0
" nerdtree

" netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro' " add line number
" netrw

" powerline
"let g:Powerline_symbols = 'fancy'
"set rtp+=$VIM/vimfiles/bundle/powerline/powerline/bindings/vim
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup
set laststatus=2
" powerline

" vim-airline
if !has("win32") && !has("win64")
  let g:airline_powerline_fonts = 1
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#fnamecollapse = 1

let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
" vim-airline

if s:uname =~ "synology"
  " AutoComplPop
  let g:acp_behaviorSnipmateLength = -1
  nnoremap <silent> <leader>ad     :AcpDisable<CR>
  nnoremap <silent> <leader>ae     :AcpEnable<CR>
  nnoremap <silent> <leader>al     :AcpLock<CR>
  nnoremap <silent> <leader>au     :AcpUnlock<CR>
  " AutoComplPop

  " neocomplcache begin
  " Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
  let g:acp_enableAtStartup = 0
  " Launches neocomplcache automatically on vim startup.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Use camel case completion.
  let g:neocomplcache_enable_camel_case_completion = 1
  " Use underscore completion.
  let g:neocomplcache_enable_underbar_completion = 1
  " Sets minimum char length of syntax keyword.
  let g:neocomplcache_min_syntax_length = 3
  " buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder
  let g:neocomplcache_lock_buffer_name_pattern = '\v*(ku|unite)\*'

  let g:neocomplcache_force_overwrite_completefunc = 1

  " Define file-type dependent dictionaries.
  let g:neocomplcache_dictionary_filetype_lists = {
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions'
  \ }

  " Define keyword, for minor languages
  if !exists('g:neocomplcache_keyword_patterns')
    "let g:neocomplcache_keyword_patterns = {}
  endif
  "let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  imap <C-k>     <Plug>(neocomplcache_snippets_expand)
  smap <C-k>     <Plug>(neocomplcache_snippets_expand)
  inoremap <expr><C-g>     neocomplcache#undo_completion()
  inoremap <expr><C-l>     neocomplcache#complete_common_string()

  " SuperTab like snippets behavior.
  "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()

  " AutoComplPop like behavior.
  let g:neocomplcache_enable_auto_select = 1

  " Shell like behavior(not recommended).
  set completeopt+=longest
  let g:neocomplcache_enable_auto_select = 1
  let g:neocomplcache_disable_auto_complete = 1
  inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
  inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"


  " Enable heavy omni completion, which require computational power and may stall the vim.
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
  let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
  " neocomplcache end
else
  " YouCompleteMe
  let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
  let g:ycm_confirm_extra_conf = 0
  let g:ycm_key_invoke_completion = '<M-/>'

  nnoremap <Leader>yy :let g:ycm_auto_trigger=0<CR>
  nnoremap <Leader>yY :let g:ycm_auto_trigger=1<CR>

  nnoremap <Leader>yr :YcmRestartServer<CR>
  nnoremap <Leader>yi :YcmDiags<CR>

  nnoremap <Leader>yI :YcmCompleter GoToInclude<CR>
  nnoremap <Leader>yg :YcmCompleter GoTo<CR>
  nnoremap <Leader>yG :YcmCompleter GoToImprecise<CR>
  nnoremap <Leader>yR :YcmCompleter GoToReferences<CR>
  nnoremap <Leader>yt :YcmCompleter GetType<CR>
  nnoremap <Leader>yT :YcmCompleter GetTypeImprecise<CR>
  nnoremap <Leader>yp :YcmCompleter GetParent<CR>
  nnoremap <Leader>yd :YcmCompleter GetDoc<CR>
  nnoremap <Leader>yD :YcmCompleter GetDocImprecise<CR>
  nnoremap <Leader>yf :YcmCompleter FixIt<CR>

  nnoremap <Leader>ysI :split <bar> YcmCompleter GoToInclude<CR>
  nnoremap <Leader>ysg :split <bar> YcmCompleter GoTo<CR>
  nnoremap <Leader>ysG :split <bar> YcmCompleter GoToImprecise<CR>
  nnoremap <Leader>ysR :split <bar> YcmCompleter GoToReferences<CR>
  nnoremap <Leader>yst :split <bar> YcmCompleter GetType<CR>
  nnoremap <Leader>ysT :split <bar> YcmCompleter GetTypeImprecise<CR>
  nnoremap <Leader>ysp :split <bar> YcmCompleter GetParent<CR>
  nnoremap <Leader>ysd :split <bar> YcmCompleter GetDoc<CR>
  nnoremap <Leader>ysD :split <bar> YcmCompleter GetDocImprecise<CR>
  nnoremap <Leader>ysf :split <bar> YcmCompleter FixIt<CR>

  nnoremap <Leader>yvI :vsplit <bar> YcmCompleter GoToInclude<CR>
  nnoremap <Leader>yvg :vsplit <bar> YcmCompleter GoTo<CR>
  nnoremap <Leader>yvG :vsplit <bar> YcmCompleter GoToImprecise<CR>
  nnoremap <Leader>yvR :vsplit <bar> YcmCompleter GoToReferences<CR>
  nnoremap <Leader>yvt :vsplit <bar> YcmCompleter GetType<CR>
  nnoremap <Leader>yvT :vsplit <bar> YcmCompleter GetTypeImprecise<CR>
  nnoremap <Leader>yvp :vsplit <bar> YcmCompleter GetParent<CR>
  nnoremap <Leader>yvd :vsplit <bar> YcmCompleter GetDoc<CR>
  nnoremap <Leader>yvD :vsplit <bar> YcmCompleter GetDocImprecise<CR>
  nnoremap <Leader>yvf :vsplit <bar> YcmCompleter FixIt<CR>

  nnoremap <Leader>yxI :tab split <bar> YcmCompleter GoToInclude<CR>
  nnoremap <Leader>yxg :tab split <bar> YcmCompleter GoTo<CR>
  nnoremap <Leader>yxG :tab split <bar> YcmCompleter GoToImprecise<CR>
  nnoremap <Leader>yxR :tab split <bar> YcmCompleter GoToReferences<CR>
  nnoremap <Leader>yxt :tab split <bar> YcmCompleter GetType<CR>
  nnoremap <Leader>yxT :tab split <bar> YcmCompleter GetTypeImprecise<CR>
  nnoremap <Leader>yxp :tab split <bar> YcmCompleter GetParent<CR>
  nnoremap <Leader>yxd :tab split <bar> YcmCompleter GetDoc<CR>
  nnoremap <Leader>yxD :tab split <bar> YcmCompleter GetDocImprecise<CR>
  nnoremap <Leader>yxf :tab split <bar> YcmCompleter FixIt<CR>
  " YouCompleteMe
endif

" completion setting
"inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
" completion setting

" neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" neosnippet

" vim gitgutter
nmap <silent> ]h :<C-U>execute v:count1 . "GitGutterNextHunk"<CR>
nmap <silent> [h :<C-U>execute v:count1 . "GitGutterPrevHunk"<CR>
nmap <silent> <leader>gt :GitGutterToggle<CR>
" vim gitgutter

" fugitive-gitlab
let g:fugitive_gitlab_domains = ['https://git.synology.com']
" fugitive-gitlab

" tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_map_showproto='<Leader><Space>'
let g:tagbar_expand = 1
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
" tagbar

" cscope
nmap <F11> :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files ;
      \:!cscope -b -i cscope.files -f cscope.out<CR>
      \:cs kill -1<CR>:cs add cscope.out<CR>
" cscope

" EasyMotion
let g:EasyMotion_leader_key = '<Space>'
map <Plug>(easymotion-prefix)f <Plug>(easymotion-bd-f)
map <Plug>(easymotion-prefix)s <Plug>(easymotion-bd-f2)
map <Plug>(easymotion-prefix)L <Plug>(easymotion-bd-jk)
map <Plug>(easymotion-prefix)w <Plug>(easymotion-bd-w)

if s:uname !~ "synology"
	nmap <Plug>(easymotion-prefix)f <Plug>(easymotion-overwin-f)
	nmap <Plug>(easymotion-prefix)s <Plug>(easymotion-overwin-f2)
	nmap <Plug>(easymotion-prefix)L <Plug>(easymotion-overwin-line)
	nmap <Plug>(easymotion-prefix)w <Plug>(easymotion-overwin-w)
endif
" EasyMotion

" incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Search within visual selection
if !has("nvim") && !has("win32") && !has("win64")
  set <M-/>=/
  set <M-?>=?
endif
vmap <M-/> <Esc><Plug>(incsearch-forward)\%V
vmap <M-?> <Esc><Plug>(incsearch-backward)\%V

" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" incsearch

" incsearch-fuzzy
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)
" incsearch-fuzzy

" incsearch-easymotion
map <Leader>/ <Plug>(incsearch-easymotion-/)
map <Leader>? <Plug>(incsearch-easymotion-?)
map <Leader>g/ <Plug>(incsearch-easymotion-stay)
" incsearch-easymotion

" incsearch.vim x fuzzy x vim-easymotion
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Leader><Leader>/ incsearch#go(<SID>config_easyfuzzymotion())
" incsearch.vim x fuzzy x vim-easymotion

" C++ Syntax Support
au BufNewFile,BufRead *.cpp set syntax=cpp11
" C++ Syntax Support

" CamelCaseMotion
map ,mw <Plug>CamelCaseMotion_w
map ,mb <Plug>CamelCaseMotion_b
map ,me <Plug>CamelCaseMotion_e
" CamelCaseMotion

" vim-easy-align
vnoremap <silent> <CR> :EasyAlign<CR>
" vim-easy-align

" vim-ruby-xmpfilter
nmap <leader>rr <Plug>(xmpfilter-run)
xmap <leader>rr <Plug>(xmpfilter-run)
imap <leader>rr <Plug>(xmpfilter-run)

nmap <leader>rm <Plug>(xmpfilter-mark)
xmap <leader>rm <Plug>(xmpfilter-mark)
imap <leader>rm <Plug>(xmpfilter-mark)"
" vim-ruby-xmpfilter

" background toggle
nmap <leader>bg :let &background = ( &background == "dark" ? "light" : "dark" )<CR>
" background toggle

" Gundo
if has('python3')
  let g:gundo_prefer_python3 = 1
endif
nnoremap <F9> :GundoToggle<CR>
" Gundo

" colorv
nnoremap <silent> <leader>cN :ColorVName<CR>
" colorv

" VimShell
nnoremap <silent> <leader>vv :VimShell<CR>
nnoremap <silent> <leader>vc :VimShellCurrentDir<CR>
nnoremap <silent> <leader>vb :VimShellBufferDir<CR>
nnoremap <silent> <leader>vt :VimShellTab<CR>
" VimShell

" Unite
let g:unite_source_history_yank_enable = 1
nnoremap <space>l :Unite -start-insert line<CR>
nnoremap <space>p :Unite file<CR>
nnoremap <space>P :Unite -start-insert file_rec<CR>
"if has("win32") || has("win64")
"nnoremap <space>P :Unite -start-insert file_rec<CR>
"else
"nnoremap <space>P :Unite -start-insert file_rec/async<CR>
"endif
nnoremap <space>/ :Unite grep:.<CR>
nnoremap <space>? :Unite grep:.:-r<CR>
nnoremap <space>y :Unite history/yank<CR>
nnoremap <space><space>s :Unite -quick-match tab<CR>
nnoremap <space>S :Unite source<CR>
nnoremap <space>m :Unite file_mru<CR>
nnoremap <space>M :Unite -buffer-name=files -default-action=lcd directory_mru<CR>
nnoremap <space>uj :Unite jump -start-insert<CR>
nnoremap <space>uo :Unite output -start-insert<CR>
nnoremap <space>ud :Unite directory<CR>
nnoremap <space>uc :Unite change<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.

  imap <buffer> jj      <Plug>(unite_insert_leave)
  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

  imap <buffer><expr> j unite#smart_map('j', '')
  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  imap <buffer><expr> x
        \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
  nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
  nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
  nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
  nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
  nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  nnoremap <silent><buffer><expr> l
        \ unite#smart_map('l', unite#do_action('default'))

  let unite = unite#get_current_unite()
  if unite.profile_name ==# 'search'
    nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
  nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
        \ empty(unite#mappings#get_current_filters()) ?
        \ ['sorter_reverse'] : [])

  " Runs "split" action by <C-s>.
  imap <silent><buffer><expr> <C-s>     unite#do_action('split')
  nmap <silent><buffer><expr> <C-s>     unite#do_action('split')

  " Runs "vsplit" action by <C-v>.
  imap <silent><buffer><expr> <C-v>     unite#do_action('vsplit')
  nmap <silent><buffer><expr> <C-v>     unite#do_action('vsplit')

  " Runs "persist_open" action by <C-p>.
  imap <silent><buffer><expr> <C-p>     unite#do_action('persist_open')
  nmap <silent><buffer><expr> <C-p>     unite#do_action('persist_open')
endfunction"}}}

if executable('rg')
  let g:unite_source_grep_command = 'rg'
  let g:unite_source_grep_default_opts = '--hidden --no-heading --vimgrep -S'
  let g:unite_source_grep_recursive_opt = ''

  nnoremap <space>/ :Unite grep:. -wrap<CR>
  nnoremap <space>? :Unite grep:. -wrap<CR>
endif
" Unite

" gj
nmap <Leader>g <Nop>
nnoremap <Leader>gg :Ack!<CR>
" gj

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:sytastic_check_on_wq = 0

let g:syntastic_ruby_checkers = ['mri', 'rubylint']
let g:syntastic_tex_checkers = ['lacheck']
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_cpp_checkers = ['gcc']
nnoremap <Space><F8> :SyntasticToggleMode<CR>
" Syntastic

" racer
set hidden
let g:racer_cmd = "D:/download/git/racer/target/release/racer"
let $RUST_SRC_PATH = "D:/download/git/rust/src/"
" racer

" vim-indent-guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :highlight IndentGuidesOdd ctermbg=243
autocmd VimEnter,Colorscheme * :highlight IndentGuidesEven ctermbg=240
" vim-indent-guides

" vim-grepper
nnoremap <leader>g :Grepper -tool git<cr>
nnoremap <leader>G :Grepper -tool ag<cr>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Optional. The default behaviour should work for most users.
let g:grepper               = {}
let g:grepper.tools         = ['git', 'ag', 'rg']
let g:grepper.jump          = 1
let g:grepper.next_tool     = '<leader>g'
let g:grepper.simple_prompt = 1
let g:grepper.quickfix      = 0
" vim-grepper

" ranger
let g:ranger_map_keys = 0
nnoremap <Space>rr :Ranger<CR>
nnoremap <Space>rs :split <bar> Ranger<CR>
nnoremap <Space>rv :vsplit <bar> Ranger<CR>
nnoremap <Space>rt :tab split <bar> Ranger<CR>
" ranger

" vim-rooter
let g:rooter_manual_only = 1
" vim-rooter

if has("balloon_eval")
  set noballooneval
endif
"set directory=.,$TEMP
set nu
set autoindent
set nohlsearch
set ignorecase
set incsearch
set smartcase
set tabstop=4
set shiftwidth=4
set softtabstop=4
"set smarttab
set noexpandtab
set shellslash
set list
set listchars=tab:\|\ 
set grepprg=grep\ -nH\ $*
set t_Co=256
set wildmenu
set foldlevelstart=99
set scrolloff=0
set mouse=a
set sessionoptions-=options
set sessionoptions-=folds
set sessionoptions-=blank
set rtp+=~/.fzf
set background=dark
filetype on
filetype plugin on
filetype indent on
colorscheme Tomorrow-Night

if has("nvim")
  set inccommand=split
endif

" Prevent CTRL-F to abort the selection (in visual mode)
" This is caused by $VIM/_vimrc ':behave mswin' which sets 'keymodel' to
" include 'stopsel' which means that non-shifted special keys stop selection.
set keymodel=startsel

if has("win32") || has("win64")
  let $TMP="C:/tmp"
else
  let $TMP="/tmp"
endif

" disable Background Color Erase (BC) by clearing the `t_ut` on Synology DSM
" see https://sunaku.github.io/vim-256color-bce.html
if s:uname =~ "synology"
  set t_ut=
endif

" vim-color-solarized
let g:solarized_termcolors=256
let g:solarized_termtrans =1
let g:solarized_degrade   =1
let g:solarized_bold      =0
let g:solarized_underline =0
let g:solarized_italic    =0
let g:solarized_contrast  ="high"
let g:solarized_visibility="low"
let g:solarized_hitrail   =0
let g:solarized_menu      =0
"colorscheme solarized
" vim-color-solarized

" Make Visual highlight more contrast
"highlight Visual ctermbg=23

" Source the vimrc file after saving it
" autocmd bufwritepost _vimrc source $MYVIMRC
" autocmd bufwritepost _vimrc source $MYGVIMRC

" Enable omni completion. Not required if they are already set elsewhere in .vimrc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" ru
augroup filetypedetect
  au! BufRead,BufNewFile *.ru setfiletype ruby
augroup END

" ruby
augroup ruby
  " avoid performance problem
  "au BufRead,BufNewFile *.rb set fdm=syntax
augroup END

" filetype detection
autocmd BufNewFile,BufReadPost *maillog* :set filetype=messages
autocmd BufNewFile,BufReadPost *conf.local :set filetype=conf
autocmd BufNewFile,BufReadPost *conf.local.override :set filetype=conf
autocmd BufNewFile,BufReadPost Makefile.inc :set filetype=make
autocmd BufNewFile,BufReadPost *.gdbinit :set filetype=gdb
" filetype detection

nnoremap <F7> :call ToggleFoldBetweenManualAndSyntax()<CR>
function! ToggleFoldBetweenManualAndSyntax()
  if &foldmethod == 'manual'
    set foldmethod=syntax
  else
    set foldmethod=manual
  endif
endfunction

nnoremap <Space><F7> :set spell!<CR>

let g:lasttab = 1
if has("win32") || has("win64")
  set encoding=utf8 " make sure mapping is correct in UTF-8
  nmap <M-1> :exe "tabn ".g:lasttab<CR>
  set encoding=cp950
  nmap <M-1> :exe "tabn ".g:lasttab<CR>
else
  if !has("nvim")
    set <M-1>=1
  endif
  nmap <M-1> :exe "tabn ".g:lasttab<CR>
endif
au TabLeave * let g:lasttab = tabpagenr()

" neovim terminal key mapping
if has("nvim")
  tnoremap <Space><F1> <C-\><C-n>

  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l

  tnoremap <M-1> <C-\><C-n>:exe "tabn ".g:lasttab<CR>
endif
" neovim terminal key mapping

function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bdi :call DeleteInactiveBufs()

function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfunction
command! TrimWhitespace call TrimWhitespace()
"autocmd BufWritePre * :call TrimWhitespace()
