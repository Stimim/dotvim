let s:fzf_preview_command = 'cat {}'
if executable('bat')
  let s:fzf_preview_command = 'bat --style=numbers --color=always {}'
endif
let s:fzf_dir_preview_command = 'ls -la --color=always {}'
if executable('exa')
  let s:fzf_dir_preview_command = 'exa -lag --color=always {}'
endif

function! vimrc#fzf#preview#get_command()
  return s:fzf_preview_command
endfunction
function! vimrc#fzf#preview#get_dir_command()
  return s:fzf_dir_preview_command
endfunction

function! vimrc#fzf#preview#windows() abort
  let options = fzf#vim#with_preview()
  let preview_script = remove(options.options, -1)[0:-4]
  let get_filename_script = expand(vimrc#get_vimhome() . '/bin/fzf_windows_preview.sh')
  let final_script = preview_script . ' "$(' . get_filename_script . ' {})"'

  call remove(options.options, -1) " remove --preview
  call extend(options.options, ['--preview', final_script])
  return options
endfunction

function! vimrc#fzf#preview#buffer_lines() abort
  let file = expand('%')
  let preview_top = 1
  let preview_command = systemlist(vimrc#get_vimhome() . '/bin/generate_fzf_preview_with_bat.sh ' . file . ' ' . preview_top)[0]

  return { 'options': ['--preview-window', 'right:50%:hidden', '--preview', preview_command] }
endfunction
