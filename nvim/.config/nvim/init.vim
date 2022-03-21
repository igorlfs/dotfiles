""""""""""""""" Default
filetype plugin indent on
if (has("termguicolors")) 
    set termguicolors 
endif
set updatetime=200
set signcolumn=yes             
set nohlsearch                 " don't highlight search
set relativenumber number      " number lines for motion
set scrolloff=4                " context lines when scrolling
set mouse=a                    " mouse scroll, fix number lines
set clipboard+=unnamedplus     " use system clipboard
set wildmode=longest,list,full " funky wildmenu
set linebreak                  " wrap long lines
set splitbelow splitright      " fix splits
set tabstop=4                  " width of a TAB
set shiftwidth=4               " indents width
set softtabstop=4              " columns for a TAB
set expandtab                  " expand TABs to spaces
set undofile                   " enables persistent undo
set shadafile=NONE             " don't save history
set noshowcmd noshowmode       " unclutter last line
set laststatus=3               " global status line
set noruler                    " unclutter status line
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
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

""""""""""""""" Plugins
call plug#begin(stdpath('data') . '/plugged')
""" Basic
Plug 'lewis6991/gitsigns.nvim' " Git Symbols
Plug 'TimUntersberger/neogit' " Git integration
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax Highlighting
Plug 'kyazdani42/nvim-tree.lua' " Explorer
Plug 'kyazdani42/nvim-web-devicons' " Icons
Plug 'akinsho/toggleterm.nvim' " Terminal
Plug 'catppuccin/nvim' " Theme
Plug 'neovim/nvim-lspconfig' " LSP
Plug 'L3MON4D3/LuaSnip' " Snippets
Plug 'mfussenegger/nvim-dap' " Debugger
Plug 'rcarriga/nvim-dap-ui'
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
Plug 'brennier/quicktex' " LaTeX Snippets
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
call plug#end()

""" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'

lua << EOF
require("nvim-autopairs").setup()
require("neogit").setup()
require("lsp")
require("git")
require("highlight")
require("terminal")
require("debugger")
require("explorer")
EOF

colorscheme catppuccin

""""""""""""""" Autocommands and Autogruoups
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 

autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()

autocmd FileType cpp,c nnoremap <buffer> <silent> <A-o> :ClangdSwitchSourceHeader<CR> 
autocmd FileType cpp,c nnoremap <buffer> <leader>m :w <cr> :make<cr>
autocmd FileType cpp,c nnoremap <buffer> <leader>bm :w <cr> :!bear -- make<cr>
