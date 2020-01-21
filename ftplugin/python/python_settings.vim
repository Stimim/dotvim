if exists('b:loaded_python_settings')
  finish
endif
let b:loaded_python_settings = 1

setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal expandtab

nnoremap <silent><buffer> K :call vimrc#coc#show_documentation()<CR>
nnoremap <silent><buffer> gK :execute 'Pydoc ' . expand('<cword>')<CR>
