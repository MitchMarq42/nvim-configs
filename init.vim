" vim-plug bootstrap
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" vim-plug declarations
call plug#begin()
    Plug 'equalsraf/neovim-gui-shim'       " Boilerplate for nvim-qt
    Plug 'tpope/vim-commentary'            " comment with gcc unless in vscode. See below.
    Plug 'tpope/vim-surround'              " add surroundings with ys
    Plug 'tpope/vim-repeat'                " boring re-repeat repeater .
    Plug 'junegunn/goyo.vim'               " Remove distractions with :Goyo
    Plug 'Xuyuanp/scrollbar.nvim'          " Actually good scrollbar
    Plug 'vim-airline/vim-airline'         " sorta epic statusline
    Plug 'vim-airline/vim-airline-themes'  " themes for above
    Plug 'pprovost/vim-ps1'                " PowerShell highlighting etc
    " Plug 'vimwiki/vimwiki'                 " html wiki thing
    " Plug 'vimpostor/vim-tpipeline'         " vim statusline in tmux
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    " Plug 'dense-analysis/ale'
    " Plug 'Olical/conjure'
    " Plug 'Olical/aniseed'
call plug#end()

let g:Hexokinase_highlighters = ['backgroundfull']
" test color '#ff0000'

" let g:aniseed#env = v:true

" lua <<EOF
"     local cmp = require('cmp')
"     cmp.setup { sources = { { name = 'nvim_lsp' }, } }
" EOF

" set foldmethod=marker
" set foldmarker={,}
" hi link Comment Folded

if exists("g:vscode")
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
endif

colorscheme mitch
let g:airline_theme='ravenpower'
silent! set cmdheight=0
silent! set guifont=MesloLGS\ NF:h11

let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_pythonx_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

set clipboard+=unnamedplus
set termguicolors
set linebreak
set encoding=utf-8
set mouse=n
set number relativenumber
" set signcolumn=number
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
set noshowmode laststatus=2 cmdwinheight=1
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent
set formatoptions-=cro
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:coc_global_extensions = ['coc-json', 'coc-css', 'coc-sh', 'coc-vimlsp', 'coc-pyright', 'coc-powershell']
let g:scrollbar_right_offset = 0
let g:scrollbar_max_size = 40
let g:scrollbar_shape = {
  \ 'head': '█',
  \ 'body': '█',
  \ 'tail': '█',
  \ }
let g:wimwiki_list = [{
    \ 'path': '$HOME/vimwiki',
    \ }]

let mapleader = " "
nnoremap n nzz
nnoremap N Nzz
nnoremap < <C-w><
nnoremap > <C-w>>
nnoremap <esc> <Cmd>noh<CR><Bar><Cmd>echon<CR>
cnoremap w!! execute 'silent! write !doas tee % >/dev/null' <bar> edit!
nmap j gj
nmap k gk
nmap R gR
inoremap < <><ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap ` ``<ESC>i
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <leader><leader> <c-^>
vmap < <gv
vmap > >gv

augroup resume
    autocmd!
    autocmd BufReadPost * silent! normal! g`"zv
augroup END
augroup markdown
    autocmd!
    autocmd BufNewFile *.md silent 0read $XDG_CONFIG_HOME/nvim/autoload/resources/markdown/header.md
    autocmd BufWritePost *.md silent !markdown-calibre % > %:r.html
augroup END
augroup vimrc
    autocmd!
    autocmd BufWritePost *.vim source %
augroup END
augroup ScrollbarInit
    autocmd!
    autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter,FocusGained	       * silent! lua require('scrollbar').show()
    autocmd WinLeave,BufLeave,BufWinLeave,FocusLost		* silent! lua require('scrollbar').clear()
augroup END
augroup packer_user_config
  autocmd!
  autocmd BufWritePost pluginstuff.lua source <afile> | PackerCompile
augroup end
augroup dconf
    autocmd!
    autocmd BufReadPre *.gsets silent !dconf dump /org/gnome/%:t:r/ > %
    autocmd BufReadPost *.gsets set ft=dosini
    autocmd BufWritePost *.gsets silent !cat % | dconf load /org/gnome/%:t:r/
augroup END

tnoremap : <C-\><C-n>:
tnoremap \: :
tnoremap <esc> <C-\><C-n>
tnoremap <C-w> <C-\><C-n><C-w>
augroup termsettings
    autocmd!
    autocmd TermEnter * setlocal nonumber norelativenumber
    autocmd TermEnter * setlocal modifiable
    autocmd TermOpen * norm i
    autocmd WinEnter term* norm i
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

function! SaveCloseBuffer()
    silent! write
    bdelete!
endfunction
command! SaveCloseBuffer call SaveCloseBuffer()
" nnoremap ZZ <cmd>SaveCloseBuffer<CR>
