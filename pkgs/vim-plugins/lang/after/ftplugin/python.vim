let b:python_indent = get(g:, 'python_indent', {})->extend(#{
  \   open_paren: 'shiftwidth()',
  \   continue: 'shiftwidth()',
  \   closed_paren_align_last_line: v:false
  \ })
