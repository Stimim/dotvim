if has("nvim") || has("gui_running")
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_history_dir = $HOME.'/.local/share/fzf-history'

let g:misc_fzf_action = {
      \ 'ctrl-q': function('vimrc#fzf#build_quickfix_list'),
      \ 'alt-c':  function('vimrc#fzf#copy_results'),
      \ 'alt-e':  'cd',
      \ }
if has('nvim')
  let g:misc_fzf_action['alt-t'] = function('vimrc#fzf#open_terminal')
endif
let g:default_fzf_action = extend({
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'alt-v':  'rightbelow vsplit',
      \ }, g:misc_fzf_action)
let g:fzf_action = g:default_fzf_action

" Mapping selecting mappings
nmap <Space><Tab> <Plug>(fzf-maps-n)
imap <M-`>        <Plug>(fzf-maps-i)
xmap <Space><Tab> <Plug>(fzf-maps-x)
omap <Space><Tab> <Plug>(fzf-maps-o)

" Insert mode completion
imap <C-X><C-K> <Plug>(fzf-complete-word)
imap <C-X><C-F> <Plug>(fzf-complete-path)
" <C-J> is <NL>
imap <C-X><C-J> <Plug>(fzf-complete-file-ag)
imap <C-X><C-L> <Plug>(fzf-complete-line)
inoremap <expr> <C-X><C-D> fzf#vim#complete#path('fd -t d')

" fzf functions & commands {{{
command! -bar  -bang                  Helptags call fzf#vim#helptags(<bang>0)
command! -bang -nargs=? -complete=dir Files    call vimrc#fzf#files(<q-args>, <bang>0)
command! -bang -nargs=?               GFiles   call vimrc#fzf#gitfiles(<q-args>, <bang>0)
command! -bang -nargs=+ -complete=dir Locate   call vimrc#fzf#locate(<q-args>, <bang>0)
command! -bang -nargs=*               History  call vimrc#fzf#history(<q-args>, <bang>0)
command! -bar  -bang                  Windows  call fzf#vim#windows(vimrc#fzf#preview#windows(), <bang>0)
command! -bar  -nargs=* -bang         BLines   call fzf#vim#buffer_lines(<q-args>, vimrc#fzf#preview#buffer_lines(), <bang>0)

" Rg
command! -bang -nargs=* Rg call vimrc#fzf#rg#grep(<q-args>, <bang>0)

" Rg with option, using ':' to separate option and query
command! -bang -nargs=* RgWithOption call vimrc#fzf#rg#grep_with_option(<q-args>, <bang>0)

" Fd all files
command! -bang -nargs=? -complete=dir AllFiles call vimrc#fzf#dir#all_files(<q-args>, <bang>0)

" Git diff
command! -bang -nargs=* -complete=dir GitDiffFiles call vimrc#fzf#git#diff_tree(<bang>0, <f-args>)
command! -bang -nargs=* -complete=dir RgGitDiffFiles call vimrc#fzf#git#rg_diff_tree(<bang>0, <f-args>)

" Mru
command! Mru        call vimrc#fzf#mru#mru()
command! ProjectMru call vimrc#fzf#mru#project_mru()

" DirectoryMru
command! -bang DirectoryMru      call vimrc#fzf#mru#directory_mru(<bang>0)
command! -bang DirectoryMruFiles call vimrc#fzf#mru#directory_mru_files(<bang>0)
command! -bang DirectoryMruRg    call vimrc#fzf#mru#directory_mru_rg(<bang>0)

" Directory
command! -bang -nargs=? Directories    call vimrc#fzf#dir#directories(<q-args>, <bang>0)
command! -bang -nargs=? DirectoryFiles call vimrc#fzf#dir#directory_files(<q-args>, <bang>0)
command! -bang -nargs=? DirectoryRg    call vimrc#fzf#dir#directory_rg(<q-args>, <bang>0)

" Tselect
command! -nargs=1 Tselect call vimrc#fzf#tag#tselect(<q-args>)

" Jump
command! Jump call vimrc#fzf#jump()

" Registers
command! Registers call vimrc#fzf#registers()

" DirectoryAncestors
command! DirectoryAncestors call vimrc#fzf#dir#directory_ancestors()

" Range
command! -nargs=? -range SelectLines call vimrc#fzf#range#range_lines('SelectLines', 1, <line1>, <line2>, <q-args>)
command! -nargs=?        ScreenLines call vimrc#fzf#range#screen_lines(<q-args>)

" FilesWithQuery
command! -nargs=1 FilesWithQuery call vimrc#fzf#files_with_query(<q-args>)

" CurrentPlacedSigns
command! CurrentPlacedSigns call vimrc#fzf#current_placed_signs()

" Functions
command! Functions call vimrc#fzf#functions()

" Git commit command {{{
" GitGrepCommit
command! -nargs=+ -complete=customlist,fugitive#CompleteObject GitGrepCommit call vimrc#fzf#git#grep_commit(<f-args>)
command! -bang -nargs=* GitGrep call vimrc#fzf#git#grep_commit('', <q-args>)

" GitDiffCommit
command! -nargs=? -complete=customlist,fugitive#CompleteObject GitDiffCommit call vimrc#fzf#git#diff_commit(<f-args>)

" GitFilesCommit
command! -nargs=1 -complete=customlist,fugitive#CompleteObject GitFilesCommit call vimrc#fzf#git#files_commit(<q-args>)
" }}}

if has("nvim")
  augroup fzf_statusline
    autocmd!
    autocmd User FzfStatusLine call vimrc#fzf#statusline()
  augroup END

  " Tags
  command! -bang -nargs=* ProjectTags call vimrc#fzf#tag#project_tags(<q-args>, <bang>0)
  " Too bad fzf cannot toggle case sensitive interactively
  command! -bang -nargs=* BTagsCaseSentitive       call fzf#vim#buffer_tags(<q-args>, { 'options': ['+i'] }, <bang>0)
  command! -bang -nargs=* TagsCaseSentitive        call fzf#vim#tags(<q-args>,        { 'options': ['+i'] }, <bang>0)
  command! -bang -nargs=* ProjectTagsCaseSentitive call vimrc#fzf#tag#project_tags(<q-args>,      { 'options': ['+i'] }, <bang>0)

  command! TagbarTags call vimrc#fzf#tag#tagbar_tags()
endif

if vimrc#plugin#is_enabled_plugin('defx')
  command! -bang -nargs=? -complete=dir Files    call vimrc#fzf#defx#use_defx_fzf_action({ -> vimrc#fzf#files(<q-args>, <bang>0) })
  command! -bang -nargs=?               GFiles   call vimrc#fzf#defx#use_defx_fzf_action({ -> vimrc#fzf#gitfiles(<q-args>, <bang>0) })
  command! -bang -nargs=+ -complete=dir Locate   call vimrc#fzf#defx#use_defx_fzf_action({ -> vimrc#fzf#locate(<q-args>, <bang>0) })

  command! -bang          DirectoryMru      call vimrc#fzf#defx#use_defx_fzf_action({ -> vimrc#fzf#mru#directory_mru(<bang>0) })
  command! -bang -nargs=? Directories       call vimrc#fzf#defx#use_defx_fzf_action({ -> vimrc#fzf#dir#directories(<q-args>, <bang>0) })
endif
" }}}

" fzf key mappings {{{
nnoremap <Space>fa :call vimrc#execute_and_save('Ag ' . input('Ag: '))<CR>
nnoremap <Space>fA :call vimrc#execute_and_save('AllFiles')<CR>
nnoremap <Space>fb :call vimrc#execute_and_save('Buffers')<CR>
nnoremap <Space>fB :call vimrc#execute_and_save('Files %:h')<CR>
nnoremap <Space>fc :call vimrc#execute_and_save('BCommits')<CR>
nnoremap <Space>fC :call vimrc#execute_and_save('Commits')<CR>
nnoremap <Space>fd :call vimrc#execute_and_save('Directories')<CR>
nnoremap <Space>fD :call vimrc#execute_and_save('DirectoryFiles')<CR>
nnoremap <Space>ff :call vimrc#execute_and_save('Files')<CR>
nnoremap <Space>fF :call vimrc#execute_and_save('DirectoryRg')<CR>
nnoremap <Space>f<C-F> :call vimrc#execute_and_save('Files ' . expand('<cfile>'))<CR>
nnoremap <Space>fg :call vimrc#execute_and_save('GFiles -co --exclude-standard')<CR>
nnoremap <Space>fG :call vimrc#execute_and_save('GitGrep ' . input('Git grep: '))<CR>
nnoremap <Space>f<C-G> :call vimrc#execute_and_save('GitGrepCommit ' . input('Commit: ') . ' ' . input('Git grep: '))<CR>
nnoremap <Space>fh :call vimrc#execute_and_save('Helptags')<CR>
nnoremap <Space>fH :call vimrc#execute_and_save('GitFilesCommit ' . input('Commit: '))<CR>
nnoremap <Space>fi :call vimrc#execute_and_save('History')<CR>
nnoremap <Space>fj :call vimrc#execute_and_save('Jump')<CR>
nnoremap <Space>fk :call vimrc#execute_and_save('Rg ' . expand('<cword>'))<CR>
nnoremap <Space>fK :call vimrc#execute_and_save('Rg ' . expand('<cWORD>'))<CR>
nnoremap <Space>f8 :call vimrc#execute_and_save('Rg \b' . expand('<cword>') . '\b')<CR>
nnoremap <Space>f* :call vimrc#execute_and_save('Rg \b' . expand('<cWORD>') . '\b')<CR>
xnoremap <Space>fk :<C-U>call vimrc#execute_and_save('Rg ' . vimrc#get_visual_selection())<CR>
xnoremap <Space>f8 :<C-U>call vimrc#execute_and_save('Rg \b' . vimrc#get_visual_selection() . '\b')<CR>
nnoremap <Space>fl :call vimrc#execute_and_save('BLines')<CR>
nnoremap <Space>fL :call vimrc#execute_and_save('Lines')<CR>
nnoremap <Space>f<C-L> :call vimrc#execute_and_save('BLines ' . expand('<cword>'))<CR>
nnoremap <Space>fm :call vimrc#execute_and_save('Mru')<CR>
nnoremap <Space>fM :call vimrc#execute_and_save('DirectoryMru')<CR>
nnoremap <Space>f<C-M> :call vimrc#execute_and_save('ProjectMru')<CR>
nnoremap <Space>fn :call vimrc#execute_and_save('FilesWithQuery ' . expand('<cword>'))<CR>
nnoremap <Space>fN :call vimrc#execute_and_save('FilesWithQuery ' . expand('<cWORD>'))<CR>
nnoremap <Space>f% :call vimrc#execute_and_save('FilesWithQuery ' . expand('%:t:r'))<CR>
xnoremap <Space>fn :<C-U>call vimrc#execute_and_save('FilesWithQuery ' . vimrc#get_visual_selection())<CR>
nnoremap <Space>fo :call vimrc#execute_and_save('Locate ' . input('Locate: '))<CR>
nnoremap <Space>fr :call vimrc#execute_and_save('Rg ' . input('Rg: '))<CR>
nnoremap <Space>fR :call vimrc#execute_and_save('Rg! ' . input('Rg!: '))<CR>
nnoremap <Space>f4 :call vimrc#execute_and_save('RgWithOption .:' . input('Option: ') . ':' . input('Rg: '))<CR>
nnoremap <Space>f$ :call vimrc#execute_and_save('RgWithOption! .:' . input('Option: ') . ':' . input('Rg!: '))<CR>
nnoremap <Space>f? :call vimrc#execute_and_save('RgWithOption .:' . vimrc#rg_current_type_option() . ':' . input('Rg: '))<CR>
nnoremap <Space>f5 :call vimrc#execute_and_save('RgWithOption ' . expand('%:h') . '::' . input('Rg: '))<CR>
nnoremap <Space>fs :call vimrc#execute_and_save('GFiles?')<CR>
nnoremap <Space>fS :call vimrc#execute_and_save('CurrentPlacedSigns')<CR>
nnoremap <Space>ft :call vimrc#execute_and_save('BTags')<CR>
nnoremap <Space>fT :call vimrc#execute_and_save('Tags')<CR>
nnoremap <Space>fu :call vimrc#execute_and_save('DirectoryAncestors')<CR>
nnoremap <Space>fU :call vimrc#execute_and_save('DirectoryFiles ..')<CR>
nnoremap <Space>fw :call vimrc#execute_and_save('Windows')<CR>
nnoremap <Space>fy :call vimrc#execute_and_save('Filetypes')<CR>
nnoremap <Space>fY :call vimrc#execute_and_save('GitFilesCommit ' . vimrc#fugitive#commit_sha())<CR>
nnoremap <Space>f<C-Y> :call vimrc#execute_and_save('GitGrepCommit ' . vimrc#fugitive#commit_sha() . ' ' . input('Git grep: '))<CR>
nnoremap <Space>f' :call vimrc#execute_and_save('Registers')<CR>
nnoremap <Space>f` :call vimrc#execute_and_save('Marks')<CR>
nnoremap <Space>f: :call vimrc#execute_and_save('History:')<CR>
xnoremap <Space>f: :<C-U>call vimrc#execute_and_save('History:')<CR>
nnoremap <Space>f; :call vimrc#execute_and_save('Commands')<CR>
xnoremap <Space>f; :<C-U>call vimrc#execute_and_save('Commands')<CR>
nnoremap <Space>f/ :call vimrc#execute_and_save('History/')<CR>
nnoremap <Space>f] :call vimrc#execute_and_save("BTags '" . expand('<cword>'))<CR>
xnoremap <Space>f] :<C-U>call vimrc#execute_and_save("BTags '" . vimrc#get_visual_selection())<CR>
nnoremap <Space>f} :call vimrc#execute_and_save("Tags '" . expand('<cword>'))<CR>
xnoremap <Space>f} :<C-U>call vimrc#execute_and_save("Tags '" . vimrc#get_visual_selection())<CR>
nnoremap <Space>f<C-]> :call vimrc#execute_and_save('Tselect ' . expand('<cword>'))<CR>
xnoremap <Space>f<C-]> :<C-U>call vimrc#execute_and_save('Tselect ' . vimrc#get_visual_selection())<CR>

" DirectoryMru
nnoremap <Space><C-D><C-D> :call vimrc#execute_and_save('DirectoryMru')<CR>
nnoremap <Space><C-D><C-F> :call vimrc#execute_and_save('DirectoryMruFiles')<CR>
nnoremap <Space><C-D><C-R> :call vimrc#execute_and_save('DirectoryMruRg')<CR>

nmap     <Space>sf vaf:SelectLines<CR>
xnoremap <Space>sf :call vimrc#execute_and_save('SelectLines')<CR>
nnoremap <Space>sl :call vimrc#execute_and_save('ScreenLines')<CR>
nnoremap <Space>sL :call vimrc#execute_and_save('ScreenLines ' . expand('<cword>'))<CR>
xnoremap <Space>sL :<C-U>call vimrc#execute_and_save('ScreenLines ' . vimrc#get_visual_selection())<CR>
nnoremap <Space>ss :History:<CR>mks vim sessions

" fzf & cscope key mappings {{{
nnoremap <silent> <Leader>cs :call vimrc#fzf#cscope#cscope('0', expand('<cword>'))<CR>
nnoremap <silent> <Leader>cg :call vimrc#fzf#cscope#cscope('1', expand('<cword>'))<CR>
nnoremap <silent> <Leader>cd :call vimrc#fzf#cscope#cscope('2', expand('<cword>'))<CR>
nnoremap <silent> <Leader>cc :call vimrc#fzf#cscope#cscope('3', expand('<cword>'))<CR>
nnoremap <silent> <Leader>ct :call vimrc#fzf#cscope#cscope('4', expand('<cword>'))<CR>
nnoremap <silent> <Leader>ce :call vimrc#fzf#cscope#cscope('6', expand('<cword>'))<CR>
nnoremap <silent> <Leader>cf :call vimrc#fzf#cscope#cscope('7', expand('<cword>'))<CR>
nnoremap <silent> <Leader>ci :call vimrc#fzf#cscope#cscope('8', expand('<cword>'))<CR>
nnoremap <silent> <Leader>ca :call vimrc#fzf#cscope#cscope('9', expand('<cword>'))<CR>

xnoremap <silent> <Leader>cs :<C-U>call vimrc#fzf#cscope#cscope('0', vimrc#get_visual_selection())<CR>
xnoremap <silent> <Leader>cg :<C-U>call vimrc#fzf#cscope#cscope('1', vimrc#get_visual_selection())<CR>
xnoremap <silent> <Leader>cd :<C-U>call vimrc#fzf#cscope#cscope('2', vimrc#get_visual_selection())<CR>
xnoremap <silent> <Leader>cc :<C-U>call vimrc#fzf#cscope#cscope('3', vimrc#get_visual_selection())<CR>
xnoremap <silent> <Leader>ct :<C-U>call vimrc#fzf#cscope#cscope('4', vimrc#get_visual_selection())<CR>
xnoremap <silent> <Leader>ce :<C-U>call vimrc#fzf#cscope#cscope('6', vimrc#get_visual_selection())<CR>
xnoremap <silent> <Leader>cf :<C-U>call vimrc#fzf#cscope#cscope('7', vimrc#get_visual_selection())<CR>
xnoremap <silent> <Leader>ci :<C-U>call vimrc#fzf#cscope#cscope('8', vimrc#get_visual_selection())<CR>
xnoremap <silent> <Leader>ca :<C-U>call vimrc#fzf#cscope#cscope('9', vimrc#get_visual_selection())<CR>

nnoremap <silent> <Leader><Leader>cs :call vimrc#fzf#cscope#cscope_query('0')<CR>
nnoremap <silent> <Leader><Leader>cg :call vimrc#fzf#cscope#cscope_query('1')<CR>
nnoremap <silent> <Leader><Leader>cd :call vimrc#fzf#cscope#cscope_query('2')<CR>
nnoremap <silent> <Leader><Leader>cc :call vimrc#fzf#cscope#cscope_query('3')<CR>
nnoremap <silent> <Leader><Leader>ct :call vimrc#fzf#cscope#cscope_query('4')<CR>
nnoremap <silent> <Leader><Leader>ce :call vimrc#fzf#cscope#cscope_query('6')<CR>
nnoremap <silent> <Leader><Leader>cf :call vimrc#fzf#cscope#cscope_query('7')<CR>
nnoremap <silent> <Leader><Leader>ci :call vimrc#fzf#cscope#cscope_query('8')<CR>
nnoremap <silent> <Leader><Leader>ca :call vimrc#fzf#cscope#cscope_query('9')<CR>
" }}}

if has("nvim")
  nnoremap <Space>fp :call vimrc#execute_and_save('ProjectTags')<CR>
  nnoremap <Space>sp :call vimrc#execute_and_save('ProjectTagsCaseSentitive')<CR>
  nnoremap <Space>fP :call vimrc#execute_and_save("ProjectTags '" . expand('<cword>'))<CR>
  xnoremap <Space>fP :<C-U>call vimrc#execute_and_save("ProjectTags '" . vimrc#get_visual_selection())<CR>
  nnoremap <Space><F8> :call vimrc#execute_and_save('TagbarTags')<CR>
endif
