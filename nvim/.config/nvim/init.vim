""""""""""""""" Default
filetype plugin indent on
if (has("termguicolors")) 
    set termguicolors 
endif
syntax enable
set nohlsearch
set updatetime=200
set relativenumber number      " number lines for motion
set scrolloff=5			       " context lines when scrolling
set mouse=a				       " mouse scroll, fix number lines
set clipboard+=unnamedplus	   " use system clipboard
set wildmode=longest,list,full " funky wildmenu
set linebreak                  " wrap long lines
set splitbelow splitright      " fix splits
set signcolumn=yes:2           " column gitsigns + column lsp
set tabstop=4                  " width of a TAB
set shiftwidth=4               " indents width
set softtabstop=4              " columns for a TAB
set expandtab                  " expand TABs to space
set undofile				   " enables persistent undo
set shadafile=NONE		       " don't save history
set noshowcmd noshowmode       " unclutter last line
set noruler
set foldmethod=indent
set nofoldenable
""" Mappings
" simplify exiting terminal mode
tnoremap <Esc> <C-\><C-n>
let mapleader = " "
nmap k gk
nmap j gj
" tabs *
nnoremap <A-S-tab> :tabprevious<CR>
nnoremap <silent> <A-tab> :tabnext<CR>
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <A-1> 1gt

""""""""""""""" Plugins
call plug#begin('~/.local/share/nvim/site/autoload/plugged')
Plug 'lewis6991/gitsigns.nvim' " Git Symbols
Plug 'nvim-lua/plenary.nvim' 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax Highlighting
Plug 'folke/tokyonight.nvim', { 'branch': 'main' } " Colorscheme
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP + Snippets + Pairs + Explorer
Plug 'lervag/vimtex', {'for': 'tex'} " LaTeX
""" Misc
Plug 'voldikss/vim-floaterm' 
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'beauwilliams/focus.nvim'
Plug 'tpope/vim-fugitive' 
Plug 'folke/persistence.nvim'
call plug#end()

let g:tokyonight_style = "night"
colorscheme tokyonight

lua << EOF
require('gitsigns').setup() 
require("persistence").setup()
require('focus').setup() 
EOF

""" Source
source ~/.config/nvim/plug-config/coc.vim
luafile ~/.config/nvim/lua/treesitter.lua

""" Persistence
nnoremap <leader>qs <cmd>lua require("persistence").load()<cr>

""" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

""" Floaterm *
let g:floaterm_keymap_toggle = '<A-p>'
"let g:floaterm_wintype = 'vsplit'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
