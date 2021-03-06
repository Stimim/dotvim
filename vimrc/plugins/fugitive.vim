" For execute git command
nnoremap <Space>gg :Git<Space>
nnoremap <Space>gG :Git!<Space>

nnoremap <silent> <Leader>gs :Git<CR>
nnoremap <silent> <Leader>gS :call vimrc#fugitive#diff_staged_file('%')<CR>
nnoremap <silent> <Leader>gd :Gdiffsplit<CR>
nnoremap <silent> <Leader>gD :Gdiffsplit!<CR>
nnoremap <silent> <Leader>gc :call vimrc#fugitive#goto_blame_line('split')<CR>
nnoremap <silent> <Leader>gC :call vimrc#fugitive#goto_blame_line('edit')<CR>
nnoremap <silent> <Leader>gb :Git blame<CR>
xnoremap <silent> <Leader>gb :Git blame<CR>
nnoremap <silent> <Leader>gB :GBrowse<CR>
nnoremap <silent> <Leader>ge :Gedit<CR>
nnoremap <silent> <Leader>gE :Gedit<space>
" TODO Use :Gllog instead, currently :0Gllog do not work
nnoremap <silent> <Leader>gl :Gclog<CR>
nnoremap <silent> <Leader>gL :0Gclog<CR>
xnoremap <silent> <Leader>gl :<C-U>execute 'Git log -L '.getpos("'<")[1].','.getpos("'>")[1].':%'<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gR :Gread<space>
nnoremap <silent> <Leader>gw :Gwrite<CR>
nnoremap <silent> <Leader>gW :Gwrite!<CR>
nnoremap <silent> <Leader>gq :Gwq<CR>
nnoremap <silent> <Leader>gQ :Gwq!<CR>
nnoremap <silent> <Leader>gM :Merginal<CR>

nnoremap <silent> <Leader>g` :call vimrc#fugitive#review_last_commit()<CR>

augroup fugitive_settings
  autocmd!
  autocmd FileType gitcommit       call vimrc#fugitive#gitcommit_settings()
  autocmd FileType fugitive        call vimrc#fugitive#mappings()
  autocmd FileType git             call vimrc#fugitive#git_mappings()
  autocmd FileType fugitiveblame   call vimrc#fugitive#blame_mappings()
  autocmd BufReadPost fugitive://* call vimrc#fugitive#fugitive_buffer_settings()
augroup END

let g:fugitive_gitlab_domains = []
if exists('g:fugitive_gitlab_secret_domains')
  let g:fugitive_gitlab_domains += g:fugitive_gitlab_secret_domains
endif

" Borrowed and modified from vim-fugitive s:Dispatch
command! -nargs=* GitDispatch call vimrc#fugitive#git_dispatch(<q-args>)
