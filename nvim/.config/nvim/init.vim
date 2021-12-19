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
set sessionoptions+=options,winpos,terminal
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
""" Mappings
let mapleader = " "
nmap k gk
nmap j gj
" simplify exiting terminal mode
tnoremap <Esc> <C-\><C-n>
" tabs
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

""""""""""""""" Plugins
call plug#begin(stdpath('data') . '/plugged')
""" Basic
Plug 'lewis6991/gitsigns.nvim' " Git Symbols
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax Highlighting
Plug 'kyazdani42/nvim-tree.lua' " Explorer
Plug 'numtostr/FTerm.nvim' " Terminal
Plug 'kyazdani42/nvim-web-devicons' " Icons
Plug 'catppuccin/nvim' " Theme
Plug 'L3MON4D3/LuaSnip' " Snippets
Plug 'neovim/nvim-lspconfig' " LSP
""" Automatic
Plug 'windwp/nvim-autopairs' " Pairs
Plug 'rmagatti/auto-session'
Plug 'hrsh7th/nvim-cmp' " Completion
" Sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
""" Misc
Plug 'nvim-lua/plenary.nvim' " Library
Plug 'ray-x/lsp_signature.nvim' " Signature helper
Plug 'lervag/vimtex', {'for': 'tex'} " LaTeX
Plug 'brennier/quicktex' " LaTeX Snippets
Plug 'TimUntersberger/neogit'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
call plug#end()

colorscheme catppuccin

""" Explorer
nnoremap <leader>v <cmd>NvimTreeRefresh<cr><cmd>NvimTreeToggle<cr>
let g:nvim_tree_git_hl = 1
let g:nvim_tree_show_icons = {
            \ 'git': 0,
            \ 'folders': 1,
            \ 'files': 1,
            \ 'folder_arrows': 1,
            \ }

lua << EOF
require('lsp')
require('treesitter')
require('nvim-tree').setup()
require('gitsigns').setup() 
require('lsp_signature').setup()
require('neogit').setup()
require('nvim-autopairs').setup()
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done())
EOF

""" Terminal
nnoremap <A-p> <CMD>lua require("FTerm").toggle()<CR>
tnoremap <A-p> <C-\><C-n><CMD>lua require("FTerm").toggle()<CR>

""" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
