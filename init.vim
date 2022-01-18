" --- BEGIN INIT.VIM --- "
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
" experinental feature. will not work in your vim.
silent! set cmdheight=0
silent! set guifont=MesloLGS\ NF:h11
" --- END INIT.VIM --- "

" --- BEGIN SLETS.VIM --- "
" Disable slow interpreted language support plugins
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_pythonx_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
set pyx=3
" generally good/useful things
set termguicolors
set linebreak
set encoding=utf-8
set mouse=n
set number relativenumber
set signcolumn=number
set noswapfile undofile undodir=~/.cache/nvim/undo
set nobackup nowritebackup
set lazyredraw
set scrolloff=3
set splitbelow splitright
set shortmess+=c
set wildmode=longest,full
set ignorecase smartcase incsearch hlsearch
set viminfo='10,\"100,:20,%,n~/.cache/nvim/viminfo
set hidden
set completeopt=menuone,noinsert,noselect
"set cursorline cursorcolumn SLOW AF
set noshowmode laststatus=2 cmdwinheight=1
" fix tab indentation being weird
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent
" control autocommenting (broken)
set formatoptions-=cro
" airline things (more in colors file)
let g:airline_left_sep=''
let g:airline_right_sep=''
" Plugin settings. Moved because reasons.
let g:coc_global_extensions = ['coc-json', 'coc-css', 'coc-sh', 'coc-vimlsp', 'coc-pyright', 'coc-powershell']
let g:scrollbar_right_offset = 0
let g:scrollbar_max_size = 40
let g:scrollbar_shape = {
  \ 'head': '❚',
  \ 'body': '█',
  \ 'tail': '❚',
  \ }
" --- END OF SLETS.VIM --- "

" --- BEGIN MAPS.VIM --- "
let mapleader = " "
" Bring search results to center of page
nnoremap n nzz
nnoremap N Nzz
" Janky sideways window movements
nnoremap < <C-w><
nnoremap > <C-w>>
" Clear search highlighting and errors on second esc. Also goes to 1st char.
nnoremap <esc> <Cmd>noh<CR><Bar><Cmd>echon<CR>
" Save things with doas when you really want to
cnoremap w!! execute 'silent! write !doas tee % >/dev/null' <bar> edit!
" these two lines make scrolling through single-line "paragraphs" so much easier
nmap j gj
nmap k gk
" make visual replace the default
nmap R gR
" Make parentheses fun again (USE A PLUGIN FOR THIS!!!)
inoremap < <><ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap ` ``<ESC>i
""inoremap ' ''<ESC>i
""inoremap " ""<ESC>i
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Double space for file switching (magic)
nnoremap <leader><leader> <c-^>
" visual stuff?
vmap < <gv
vmap > >gv
" --- END MAPS.VIM --- "

" --- BEGIN AUGROUPS.VIM --- "
" go to previous location
augroup resume
    autocmd!
    autocmd BufReadPost * silent! normal! g`"zv
augroup END
" convert markdown to html
augroup markdown
    autocmd!
    autocmd BufNewFile *.md silent 0read $XDG_CONFIG_HOME/nvim/autoload/resources/markdown/header.md
    autocmd BufWritePost *.md silent !markdown-calibre % > %:r.html
augroup END
" re-source any .vim files when you save them
augroup vimrc
    autocmd!
    autocmd BufWritePost *.vim source %
augroup END
" scrollbar things (more in pluginstuff file)
augroup ScrollbarInit
    autocmd!
    autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter,FocusGained	       * silent! lua require('scrollbar').show()
    autocmd WinLeave,BufLeave,BufWinLeave,FocusLost		* silent! lua require('scrollbar').clear()
augroup END
" Packer, for plugins.
augroup packer_user_config
  autocmd!
  autocmd BufWritePost pluginstuff.lua source <afile> | PackerCompile
augroup end
" *.gsets files. I made this up because dconf is oof.
augroup dconf
    autocmd!
    autocmd BufReadPre *.gsets silent !dconf dump /org/gnome/%:t:r/ > %
    autocmd BufReadPost *.gsets set ft=dosini
    autocmd BufWritePost *.gsets silent !cat % | dconf load /org/gnome/%:t:r/
augroup END
" --- END AUGROUPS.VIM --- "

" --- BEGIN TERMSETS.VIM --- "
" All settings related to nvim's built-in terminal go here.
tmap : <C-\><C-n>:
tmap <esc> <C-\><C-n>
tnoremap <C-w> <C-\><C-n><C-w>
" tnoremap <nowait> exit<CR> <C-\><C-n>ZZ
augroup termsettings
    autocmd!
    autocmd TermEnter * setlocal nonumber norelativenumber
    autocmd TermEnter * setlocal modifiable
    autocmd TermOpen * norm i
    " autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
augroup END
set scrollback=1000
let g:terminal_color_0 = '#000000'
let g:terminal_color_1 = '#ff0000'
let g:terminal_color_2 = '#00aa00'
let g:terminal_color_3 = '#ffee11'
let g:terminal_color_4 = '#0000ff'
let g:terminal_color_5 = '#ff00ff'
let g:terminal_color_6 = '#00ffff'
let g:terminal_color_7 = '#ffffff'
let g:terminal_color_8 = '#303030'
let g:terminal_color_9 = '#ffa000'
let g:terminal_color_10 = '#00c000'
let g:terminal_color_11 = '#cccc66'
let g:terminal_color_12 = '#0077ff'
let g:terminal_color_13 = '#9f00aa'
let g:terminal_color_14 = '#00c0c0'
let g:terminal_color_15 = '#afafaf'
" --- END TERMSETS.VIM --- "

" --- new stuff. Experimentation? --- "
function! SaveCloseBuffer()
    silent! write
    bdelete!
endfunction
command! SaveCloseBuffer call SaveCloseBuffer()
nnoremap ZZ <cmd>SaveCloseBuffer<CR>
