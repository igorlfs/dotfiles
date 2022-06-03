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
noremap <C-s> :w<CR>
tnoremap <Esc> <C-\><C-n>
" Move lines
vnoremap <silent> <A-j> :m .+1<CR>gv=gv
vnoremap <silent> <A-k> :m .-2<CR>gv=gv
""" Tabs
noremap <silent> <A-t> :tabnew %<CR>
noremap <silent> <A-tab> :tabnext<CR>
noremap <silent> <S-tab> :tabprevious<CR>
noremap <A-1> 1gt
noremap <A-2> 2gt
noremap <A-3> 3gt
noremap <A-4> 4gt
noremap <A-5> 5gt
noremap <A-6> 6gt
noremap <A-7> 7gt
noremap <A-8> 8gt
noremap <A-9> 9gt
noremap <silent> <A-0> :tablast<CR>

""""""""""""""" Plugins
call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
""" Improved
Plug 'igorlfs/catppuccin-nvim', {'branch': 'dap-support'}
Plug 'kyazdani42/nvim-tree.lua'     " Explorer
Plug 'akinsho/toggleterm.nvim'      " Terminal
Plug 'rmagatti/auto-session'        " Session
Plug 'neovim/nvim-lspconfig'        
""" Features
Plug 'lewis6991/gitsigns.nvim'      " Git
Plug 'kyazdani42/nvim-web-devicons' " Icons
Plug 'windwp/nvim-autopairs'        " Pairs
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
Plug 'lervag/vimtex'                " LaTeX
Plug 'brennier/quicktex'            " LaTeX Snippets
Plug 'nanotee/sqls.nvim'            " SQL
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
call plug#end()

""" Vimtex
let g:vimtex_view_method='zathura'

lua << EOF
require("nvim-autopairs").setup()
require("lsp")
require("git")
require("treesitter")
require("debugger")
require("explorer")
require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
    },
})
require("toggleterm").setup({
    open_mapping = [[<a-p>]],
    direction = "float",
    float_opts = {
        border = "curved",
    },
})
EOF

colorscheme catppuccin

""""""""""""""" Autocommands and Autogruoups
autocmd TermOpen * setlocal nonumber norelativenumber scrolloff=0
autocmd TermOpen * startinsert

autocmd FileType sql nnoremap <silent> <Leader>qe :<C-U>silent! '{,'}SqlsExecuteQuery<CR>

autocmd FileType cpp,c nnoremap <buffer> <silent> <A-o> :ClangdSwitchSourceHeader<CR> 

autocmd FileType cpp,c,make nnoremap <buffer> <leader>m :w <CR> :Make<CR>
autocmd FileType cpp,c,make nnoremap <buffer> <leader>bm :w <CR> :!bear -- make<CR>
