" completion setting {{{
" FIXME Completion popup still appear after select completion.
" inoremap <expr> <Esc>      pumvisible() ? "\<C-E>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-Y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-N>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-P>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-P>\<C-N>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-P>\<C-N>" : "\<PageUp>"
inoremap <expr> <Tab>      pumvisible() ? "\<C-N>" : "\<Tab>"

" Workaround of supertab bug
if vimrc#plugin#is_disabled_plugin('supertab')
  inoremap <expr> <S-Tab>    pumvisible() ? "\<C-P>" : "\<S-Tab>"
endif
" }}}

" coc.nvim {{{
if vimrc#plugin#is_enabled_plugin('coc.nvim')
  Plug 'Shougo/neco-vim'
  Plug 'neoclide/coc-neco'
  Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() } }
  Plug 'neoclide/coc-denite'

  call vimrc#source('vimrc/plugins/coc.vim')
endif
" }}}

" deoplete.nvim {{{
if vimrc#plugin#is_enabled_plugin('deoplete.nvim')
  call vimrc#source('plug/plugins/deoplete.vim')

  call vimrc#source('vimrc/plugins/deoplete.vim')
endif
" }}}

" completor.vim {{{
if vimrc#plugin#is_enabled_plugin('completor.vim')
  Plug 'maralla/completor.vim'

  if vimrc#plugin#check#has_linux_build_env()
    let g:completor_clang_binary = "/usr/lib/llvm-8/lib/clang"
  end
endif
" }}}

" YouCompleteMe {{{
if vimrc#plugin#is_enabled_plugin('YouCompleteMe')
  Plug 'Valloric/YouCompleteMe', { 'do': 'python install.py --clang_completer' }

  call vimrc#source('vimrc/plugins/YouCompleteMe.vim')
endif
" }}}

" supertab {{{
if vimrc#plugin#is_enabled_plugin('supertab')
  Plug 'ervandew/supertab'
endif
" }}}

" neosnippet {{{
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

let g:neosnippet#snippets_directory = vimrc#get_vimhome().'/plugged/neosnippet-snippets/neosnippets'
let g:neosnippet#snippets_directory = vimrc#get_vimhome().'/plugged/vim-snippets/snippets'

" Plugin key-mappings.
" <C-J>: expand or jump or select completion
imap <silent><expr> <C-J>
      \ pumvisible() && !neosnippet#expandable_or_jumpable() ?
      \ "\<C-Y>" :
      \ "\<Plug>(neosnippet_expand_or_jump)"
smap <C-J> <Plug>(neosnippet_expand_or_jump)
xmap <C-J> <Plug>(neosnippet_expand_target)

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" }}}

" tmux-complete.vim {{{
if executable('tmux')
  Plug 'wellle/tmux-complete.vim'
endif
" }}}
