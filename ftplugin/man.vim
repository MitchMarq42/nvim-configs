" Maintainer:          Anmol Sethi <hi@nhooyr.io>
" Previous Maintainer: SungHyun Nam <goweol@gmail.com>

if exists('b:did_ftplugin') || &filetype !=# 'man'
  finish
endif
let b:did_ftplugin = 1

let s:pager = !exists('b:man_sect')

if s:pager
  call man#init_pager()
endif

setlocal noswapfile buftype=nofile bufhidden=hide
setlocal nomodified readonly nomodifiable
setlocal noexpandtab tabstop=8 softtabstop=8 shiftwidth=8
setlocal wrap breakindent linebreak

" Parentheses and '-' for references like `git-ls-files(1)`; '@' for systemd
" pages; ':' for Perl and C++ pages.  Here, I intentionally omit the locale
" specific characters matched by `@`.
setlocal iskeyword=@-@,:,a-z,A-Z,48-57,_,.,-,(,)

setlocal nonumber norelativenumber
setlocal foldcolumn=0 colorcolumn=0 nolist nofoldenable
setlocal scrolloff=0

setlocal tagfunc=man#goto_tag

if !exists('g:no_plugin_maps') && !exists('g:no_man_maps')
  nnoremap <silent> <buffer> j             Lgj
  nnoremap <silent> <buffer> k             Hgk
  nnoremap <silent> <buffer> gO            :call man#show_toc()<CR>
  nnoremap <silent> <buffer> <2-LeftMouse> :Man<CR>
"  if s:pager
"    nnoremap <silent> <buffer> <nowait> q :lclose<CR>:q<CR>
"  else
"    nnoremap <silent> <buffer> <nowait> q :lclose<CR><C-W>c
"  endif
  nnoremap <silent> <buffer> q              :wincmd q
endif

if get(g:, 'ft_man_folding_enable', 0)
  setlocal foldenable
  setlocal foldmethod=indent
  setlocal foldnestmax=1
endif

let b:undo_ftplugin = ''
" vim: set sw=2:
