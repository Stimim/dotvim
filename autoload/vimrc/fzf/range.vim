" Sources
" Borrowed from s:buffer_lines from fzf.vim
function! vimrc#fzf#range#range_lines_source(start, end, query)
  let linefmt = vimrc#fzf#yellow(" %4d ", "LineNr")."\t%s"
  let fmtexpr = 'printf(linefmt, v:key + 1, v:val)'
  let lines = getline(1, '$')
  if empty(a:query)
    let formatted_lines = map(lines, fmtexpr)
    return formatted_lines[a:start-1 : a:end-1]
  end
  let formatted_lines = map(lines, 'v:val =~ a:query ? '.fmtexpr.' : ""')
  return filter(formatted_lines[a:start-1 : a:end-1], 'len(v:val)')
endfunction

" Sinks
" Borrowed from s:buffer_line_handler from fzf.vim
function! vimrc#fzf#range#range_lines_sink(center, lines)
  if len(a:lines) < 2
    return
  endif
  let qfl = []
  for line in a:lines[1:]
    let chunks = split(line, "\t", 1)
    let ln = chunks[0]
    let ltxt = join(chunks[1:], "\t")
    call add(qfl, {'filename': expand('%'), 'lnum': str2nr(ln), 'text': ltxt})
  endfor
  call vimrc#fzf#fill_quickfix(qfl, 'cfirst')
  normal! m'
  let cmd = vimrc#fzf#action_for(a:lines[0])
  if !empty(cmd)
    execute 'silent' cmd
  endif

  execute split(a:lines[1], '\t')[0]

  if a:center
    normal! zzzv
  endif
endfunction

" Commands
function! vimrc#fzf#range#range_lines(prompt, center, start, end, query)
  let options = ['--tiebreak=index', '--multi', '--prompt', a:prompt . '> ', '--ansi', '--extended', '--nth=2..', '--layout=reverse-list', '--tabstop=1']
  let file = expand('%')
  let preview_command = systemlist(vimrc#get_vimhome() . '/bin/generate_fzf_preview_with_bat.sh ' . file . ' ' . a:start)[0]
  let final_options = extend(options, ['--preview-window', 'right:50%:hidden', '--preview', preview_command])
  let Sink = function('vimrc#fzf#range#range_lines_sink', [a:center])

  call fzf#run(vimrc#fzf#wrap('', {
        \ 'source':  vimrc#fzf#range#range_lines_source(a:start, a:end, a:query),
        \ 'sink*':   Sink,
        \ 'options': final_options,
        \ }, 0))
endfunction

function! vimrc#fzf#range#screen_lines(...)
  let query = (a:0 && type(a:1) == type('')) ? a:1 : ''

  let save_cursor = getcurpos()
  normal H
  let start = getpos('.')[1]
  normal L
  let end = getpos('.')[1]
  call setpos('.', save_cursor)

  call vimrc#fzf#range#range_lines('ScreenLines', 0, start, end, query)
endfunction