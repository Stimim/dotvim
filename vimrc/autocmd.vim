" Put these in an autocmd group, so that we can delete them easily.
augroup vimGeneralCallbacks
  autocmd!
  autocmd BufWritePost _vimrc nested call vimrc#reload#reload() | e | normal! zzzv
  autocmd BufWritePost .vimrc nested call vimrc#reload#reload() | e | normal! zzzv
augroup END

augroup fileTypeSpecific
  autocmd!

  " gitcommit
  " FIXME Cannot move to ftplugin, do not load
  autocmd FileType gitcommit setlocal spell complete+=k

  " Custom filetype
  autocmd BufNewFile,BufReadPost *.ru                 set filetype=ruby
  autocmd BufNewFile,BufReadPost *.gdbinit            set filetype=gdb
  autocmd BufNewFile,BufReadPost *maillog             set filetype=messages
  autocmd BufNewFile,BufReadPost *maillog.*.xz        set filetype=messages
  autocmd BufNewFile,BufReadPost *conf                set filetype=conf
  autocmd BufNewFile,BufReadPost *conf.local          set filetype=conf
  autocmd BufNewFile,BufReadPost *conf.local.override set filetype=conf
  autocmd BufNewFile,BufReadPost *.cf                 set filetype=conf
  autocmd BufNewFile,BufReadPost .gitignore           set filetype=conf
  autocmd BufNewFile,BufReadPost .ignore              set filetype=conf
  autocmd BufNewFile,BufReadPost */conf/template/*    set filetype=conf
  autocmd BufNewFile,BufReadPost */rspamd/*.inc       set filetype=conf
  autocmd BufNewFile,BufReadPost */upstart/*conf      set filetype=upstart
  autocmd BufNewFile,BufReadPost *.upstart            set filetype=upstart
  autocmd BufNewFile,BufReadPost Makefile.inc         set filetype=make
  autocmd BufNewFile,BufReadPost depends              set filetype=dosini
  autocmd BufNewFile,BufReadPost depends-virtual-*    set filetype=dosini
  autocmd BufNewFile,BufReadPost .tmux.conf           set filetype=tmux
  autocmd BufNewFile,BufReadPost resource             set filetype=json
  autocmd BufNewFile,BufReadPost *.bashrc             set filetype=sh
  autocmd BufNewFile,BufReadPost *.sieve              set filetype=sieve
  autocmd BufNewFile,BufReadPost mimedefang-filter    set filetype=perl

  " Custom build log syntax
  autocmd BufNewFile,BufReadPost *.build              set filetype=cerr
augroup END
