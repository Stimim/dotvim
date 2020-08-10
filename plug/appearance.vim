" Status Line {{{
" vim-airline {{{
if vimrc#plugin#is_enabled_plugin('vim-airline')
  call vimrc#source('plug/plugins/airline.vim')

  call vimrc#source('vimrc/plugins/airline.vim')
endif
" }}}

" lightline.vim {{{
if vimrc#plugin#is_enabled_plugin('lightline.vim')
  Plug 'itchyny/lightline.vim'
  Plug 'maximbaz/lightline-ale'
  Plug 'shinchu/lightline-gruvbox.vim'

  call vimrc#source('vimrc/plugins/lightline.vim')
endif
" }}}
" }}}

" vim-devicons {{{
" Disable for now as Fira Code nerd fonts is not patched
" Plug 'ryanoasis/vim-devicons'
" }}}

" Colors {{{
" TODO morhetz/gruvbox seems not updated for a while, use gruvbox-community/gruvbox
Plug 'morhetz/gruvbox'
" TODO disabled as it change color of floating and fzf prompt
" Plug 'gruvbox-community/gruvbox'

" Disabled as not used
Plug 'junegunn/seoul256.vim', { 'for': [] }
Plug 'chriskempson/base16-vim', { 'for': [] }
Plug 'altercation/vim-colors-solarized', { 'for': [] }
" }}}
