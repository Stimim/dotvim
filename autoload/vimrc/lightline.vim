let s:lightline_width_threshold = 70

function! vimrc#lightline#filename()
  let fname = expand('%:t')
  let fpath = expand('%')

  if fname =~ '__Tagbar__'
    return g:lightline.fname
  elseif fname == '__Mundo__'
    return 'Mundo'
  elseif fname == '__Mundo_Preview__'
    return 'Mundo Preview'
  elseif &ft == 'qf'
    return get(w:, 'quickfix_title', '')
  elseif &ft == 'unite'
    return unite#get_status_string()
  elseif &ft == 'vimfiler'
    return vimfiler#get_status_string()
  elseif &ft == 'help'
    let t:current_filename = fname
    return fname
  else
    let readonly = '' != vimrc#lightline#readonly() ? vimrc#lightline#readonly() . ' ' : ''
    if fpath =~? '^fugitive'
      let filename = fnamemodify(fugitive#Real(fpath), ':.') . ' [git]'
    else
      let filename = '' != fname ? fpath : '[No Name]'
    end
    let modified = '' != vimrc#lightline#modified() ? ' ' . vimrc#lightline#modified() : ''

    let t:current_filename = fname
    return readonly . filename . modified
  endif
endfunction

function! vimrc#lightline#readonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! vimrc#lightline#modified()
  return &modifiable && &modified ? '+' : ''
endfunction

function! vimrc#lightline#fugitive()
  if !exists('b:lightline_head')
    " Borrowed from s:display_git_branch from airline/extensions/branch.vim {{{
    let name = fugitive#head()
    try
      let commit = matchstr(FugitiveParse()[0], '^\x\+')

      if has_key(s:names, commit)
        let name = get(s:names, commit)."(".name.")"
      elseif !empty(commit)
        let ref = fugitive#repo().git_chomp('describe', '--all', '--exact-match', commit)
        if ref !~ "^fatal: no tag exactly matches"
          let name = substitute(ref, '\v\C^%(heads/|remotes/|tags/)=','','')."(".name.")"
        else
          let name = matchstr(commit, '.\{'.s:sha1size.'}')."(".name.")"
        endif
      endif
    catch
    endtry
    " }}}

    let b:lightline_head = name
  endif

  return &ft == 'qf' ? '' : 
        \ b:lightline_head !=# '' ? ' ' . b:lightline_head : ''
endfunction

function! vimrc#lightline#fileformat()
  return winwidth(0) > s:lightline_width_threshold ? &fileformat : ''
endfunction

function! vimrc#lightline#filetype()
  return winwidth(0) > s:lightline_width_threshold ?
        \ &buftype ==# 'terminal' ? &buftype :
        \ (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! vimrc#lightline#fileencoding()
  return winwidth(0) > s:lightline_width_threshold ? (&fileencoding !=# '' ? &fileencoding : &encoding) : ''
endfunction

function! vimrc#lightline#mode()
  let fname = expand('%:t')
  return fname =~ '__Tagbar__' ? 'Tagbar' :
        \ fname == '__Mundo__' ? 'Mundo' :
        \ fname == '__Mundo_Preview__' ? 'Mundo Preview' :
        \ &ft == 'qf' ? vimrc#lightline#quickfix_mode() :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'fugitive' ? 'Fugitive' :
        \ lightline#mode()
endfunction

" Borrowed from vim-airline {{{
function! vimrc#lightline#quickfix_mode()
  let dict = getwininfo(win_getid())
  if len(dict) > 0 && get(dict[0], 'quickfix', 0) && !get(dict[0], 'loclist', 0)
    return 'Quickfix'
  elseif len(dict) > 0 && get(dict[0], 'quickfix', 0) && get(dict[0], 'loclist', 0)
    return 'Location'
  endif
endfunction
" }}}

function! vimrc#lightline#tab_filename(n) abort
  let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let fname = expand('#' . bufnr . ':t')
  let ftype = getbufvar(bufnr, '&ft')
  let FilenameFilter = { fname -> '' != fname ? fname : '[No Name]' }
  return fname =~ '__Tagbar__' ? 'Tagbar' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ ftype == 'fzf' ? FilenameFilter(gettabvar(a:n, 'current_filename', fname)) :
        \ FilenameFilter(fname)
endfunction

function! vimrc#lightline#tab_modified(n) abort
  let winnr = tabpagewinnr(a:n)
  let bufnr = tabpagebuflist(a:n)[winnr - 1]
  let ftype = getbufvar(bufnr, '&ft')
  let buftype = getbufvar(bufnr, '&buftype')
  return ftype == 'fzf' ? '' :
        \ buftype == 'terminal' ? '' :
        \ gettabwinvar(a:n, winnr, '&modified') ? '+' : gettabwinvar(a:n, winnr, '&modifiable') ? '' : '-'
endfunction