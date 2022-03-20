""""""""""""""" Default
filetype plugin indent on
if (has("termguicolors")) 
    set termguicolors 
endif
syntax enable
set nohlsearch
set updatetime=200
set signcolumn=yes             
set relativenumber number      " number lines for motion
set scrolloff=4			       " context lines when scrolling
set mouse=a				       " mouse scroll, fix number lines
set clipboard+=unnamedplus	   " use system clipboard
set wildmode=longest,list,full " funky wildmenu
set linebreak                  " wrap long lines
set splitbelow splitright      " fix splits
set tabstop=4                  " width of a TAB
set shiftwidth=4               " indents width
set softtabstop=4              " columns for a TAB
set expandtab                  " expand TABs to space
set undofile				   " enables persistent undo
set shadafile=NONE		       " don't save history
set noshowcmd noshowmode       " unclutter last line
set noruler
set sessionoptions+=winpos,terminal
set diffopt+=algorithm:patience
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
""" Mappings
" Convenience
let mapleader = " "
nnoremap k gk
nnoremap j gj
noremap <C-s> :w<cr>
" Tabs
nnoremap <C-t> :tabe %<cr>
nnoremap <A-tab> :tabnext<cr>
nnoremap <S-tab> :tabprevious<cr>
noremap <A-1> 1gt
noremap <A-2> 2gt
noremap <A-3> 3gt
noremap <A-4> 4gt
noremap <A-5> 5gt
noremap <A-6> 6gt
noremap <A-7> 7gt
noremap <A-8> 8gt
noremap <A-9> 9gt
noremap <A-0> :tablast<cr>
" Terminal
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <A-p> :20sp +te<cr>
tnoremap <silent> <A-p> <C-\><C-n><C-w>q

""""""""""""""" Plugins
call plug#begin(stdpath('data') . '/plugged')
""" Basic
Plug 'lewis6991/gitsigns.nvim' " Git Symbols
Plug 'TimUntersberger/neogit' " Git integration
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax Highlighting
Plug 'kyazdani42/nvim-tree.lua' " Explorer
Plug 'kyazdani42/nvim-web-devicons' " Icons
Plug 'catppuccin/nvim' " Theme
Plug 'neovim/nvim-lspconfig' " LSP
Plug 'L3MON4D3/LuaSnip' " Snippets
""" Automatic
Plug 'windwp/nvim-autopairs' " Pairs
Plug 'rmagatti/auto-session' " Session
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
""" Misc
Plug 'nvim-lua/plenary.nvim' " Library
Plug 'lervag/vimtex' " LaTeX
Plug 'brennier/quicktex'  " LaTeX Snippets
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
call plug#end()

""" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'

lua << EOF
require('nvim-autopairs').setup()
require('lsp')
require('treesitter')
require('git')
require("highlight")
require('neogit').setup()
require("explorer")
EOF

""""""""""""""" Autocommands and Autogruoups
""" Terminal
augroup neovim_terminal
    autocmd!
    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonu nornu
    " allows you to use Ctrl-c on terminal window
    autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
    " Close terminal using Alt-p
    autocmd TermOpen * nnoremap <buffer> <A-p> <C-\><C-n><C-w>q
augroup END

autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 

autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()
