""""""""""""""" Settings
set updatetime=200             " faster LSP and alike
set signcolumn=yes             " enable git or diagnostics column
set termguicolors              " enable full color support
set nohlsearch                 " don't highlight search
set breakindent                " keep wrapped lines visually indented
set relativenumber number      " number lines for motion
set scrolloff=4                " context lines when scrolling
set mouse=a                    " mouse scroll, fix number lines
set clipboard+=unnamedplus     " use system clipboard
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
set spelllang=en_us,pt_br      " languages to use with spellcheck
set foldmethod=expr            " use treesitter folds
set foldexpr=nvim_treesitter#foldexpr()

""""""""""""""" Mappings
""" Convenience
let mapleader = " "
nnoremap k gk
nnoremap j gj
noremap <C-s> :w<cr>
tnoremap <Esc> <C-\><C-n>
""" Tabs
nnoremap <silent> <A-tab> :tabnext<cr>
nnoremap <silent> <S-tab> :tabprevious<cr>
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
call plug#begin()
Plug 'kyazdani42/nvim-tree.lua'     " Explorer
Plug 'akinsho/toggleterm.nvim'      " Terminal
Plug 'igorlfs/nvim'                 " Theme
Plug 'rmagatti/auto-session'        " Session
Plug 'chaoren/vim-wordmotion'       " Word motion
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lewis6991/gitsigns.nvim'      " Git
Plug 'kyazdani42/nvim-web-devicons' " Icons
Plug 'windwp/nvim-autopairs'        " Pairs
Plug 'neovim/nvim-lspconfig'        " LSP
Plug 'mfussenegger/nvim-dap'        " Debugger
Plug 'rcarriga/nvim-dap-ui'
"""  Autocomplete + Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
""" Misc
Plug 'lervag/vimtex' " LaTeX
Plug 'brennier/quicktex' " LaTeX Snippets
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
call plug#end()

""" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'

lua << EOF
require("nvim-autopairs").setup()
require("lsp")
require("git")
require("highlight")
require("terminal")
require("debugger")
require("explorer")
EOF

colorscheme catppuccin

""""""""""""""" Autocommands and Autogruoups
autocmd BufWritePre *.js EslintFixAll

autocmd TermOpen * setlocal nonumber norelativenumber scrolloff=0
autocmd TermOpen * startinsert
autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif

autocmd FileType cpp,c nnoremap <buffer> <silent> <A-o> :ClangdSwitchSourceHeader<CR> 

autocmd FileType cpp,c,make nnoremap <buffer> <leader>m :w <cr> :Make<cr>
autocmd FileType cpp,c,make nnoremap <buffer> <leader>bm :w <cr> :!bear -- make<cr>
