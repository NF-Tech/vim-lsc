function! lsc#uri#documentUri(...) abort
  if a:0 >= 1
    let file_path = a:1
  else
    let file_path = expand('%:p')
  endif
  return 'file://'.s:EncodePath(file_path)
endfunction

function! lsc#uri#documentPath(uri) abort
  return s:DecodePath(substitute(a:uri, '^file://', '', 'v'))
endfunction

function! s:EncodePath(value) abort
  return substitute(a:value, '\([^a-zA-Z0-9-_.~/]\)',
      \ '\=s:EncodeChar(submatch(1))', 'g')
endfunction

function! s:EncodeChar(char) abort
  let charcode = char2nr(a:char)
  return printf('%%%02x', charcode)
endfunction

function! s:DecodePath(value) abort
  return substitute(a:value, '%\([a-fA-F0-9]\{2}\)',
      \ '\=s:DecodeChar(submatch(1))', 'g')
endfunction

function! s:DecodeChar(hexcode)
  let charcode = str2nr(a:hexcode, 16)
  return nr2char(charcode)
endfunction