" TODO Move all plugin settings to post-loaded settings

" coc.nvim {{{
if vimrc#plugin#is_enabled_plugin('coc.nvim')
  call vimrc#source('vimrc/plugins/coc_after.vim')
endif
" }}}

" deoplete.nvim {{{
if vimrc#plugin#is_enabled_plugin('deoplete.nvim')
  " Use smartcase.
  call deoplete#custom#option('smart_case', v:true)
endif
" }}}

" Unite {{{
augroup post_loaded_unite_mappings
  autocmd!
  autocmd VimEnter * call vimrc#unite#post_loaded_mappings()
augroup END
" }}}

" Denite {{{
if vimrc#plugin#is_enabled_plugin('denite.nvim')
  call vimrc#source('vimrc/plugins/denite_after.vim')
endif
" }}}

" Defx {{{
if vimrc#plugin#is_enabled_plugin("defx")
  call vimrc#source('vimrc/plugins/defx_after.vim')
endif
" }}}

" gina.vim {{{
if vimrc#plugin#is_enabled_plugin('gina.vim')
  call vimrc#source('vimrc/plugins/gina_after.vim')
endif
" }}}

" Arpeggio {{{
call arpeggio#load()

" Quickly escape insert mode
Arpeggio inoremap jk <Esc>
" }}}