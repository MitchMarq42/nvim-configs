lua require('pluginstuff')

"set nohlsearch

" These three lines remove various unwanted forms of white space from files upon exit
" DISABLED BECAUSE IT BREAKS STUFF. USE HIGHLIGHTS INSTEAD.
"autocmd BufWritePre * %s/\s\+$//e       " Trailing spaces
"autocmd BufWritePre * %s/\n\+\%$//e     " trailing tabs
"autocmd BufWritePre *.[ch] %s/\%$/\r/e  " Trailing newlines

" Fix folding
set foldmethod=marker
set foldmarker={,}
hi link Comment Folded
set foldtext=MyFoldText()
function MyFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{\d\=', '', 'g')
  return sub
endfunction

colorscheme mitch
let g:airline_theme='ravenpower'

" EXPERINENTAL FEATURE. WILL NOT WORK IN YOUR VIM.
silent! set cmdheight=0
silent! set guifont=MesloLGS\ NF
