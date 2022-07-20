""""""""""""""" Settings
lua << EOF
local o = vim.opt

-- Behavior
o.termguicolors = true              -- Enable full color support
o.updatetime = 200                  -- Time for CursorHold event (eg, LSP)
o.hlsearch = false                  -- Don't keep searches highlighted
o.breakindent = true                -- Keep wrapped lines visually indented
o.scrolloff = 4                     -- Context lines when scrolling
o.clipboard:append{"unnamedplus"}   -- Use system clipboard
o.wildmode = "longest,list,full"    -- Funky completion for commands
o.mouse = "a"                       -- TBR: default in 0.8
o.spelllang:append{"pt_br"}         -- Additional language to spell check

-- Folds
-- o.foldenable = false                -- Disable folds by default
o.foldmethod = "expr"               -- Enable treesitter folds
o.foldexpr = "nvim_treesitter#foldexpr()"

-- Splits
o.splitbelow = true
o.splitright = true

-- Tabs
o.expandtab = true                  -- expand tabs to spaces
o.tabstop = 4                       -- width of a tab
o.shiftwidth = 4                    -- indent's width
-- o.softtabstop = 4

-- Appearence
o.number = true                     -- Print the line number in front of the current line
o.relativenumber = true             -- Print the line numbers for motion
o.signcolumn = "yes"                -- Always draw the extra column to indicate git or diagnostics
-- status line
o.ruler = false                     -- Hide the line and column number of the cursor position
o.laststatus = 3                    -- Global status line
-- command line
o.showcmd = false                   -- Hide current (unfinished) command
o.showmode = false                  -- Hide message indicating current mode

-- History
o.undofile = true                   -- Enable persistent undo
o.shadafile = "NONE"                -- Don't save history
EOF

""""""""""""""" Mappings
""" Convenience
let mapleader = " "
nnoremap k gk
nnoremap j gj
noremap <C-s> :write<CR>
tnoremap <Esc> <C-\><C-n>
""" Tabs
noremap <silent> <C-q> :tabclose<CR>
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
""" Improvements
Plug 'catppuccin/nvim', {'as': 'catppuccin', 'do': 'CatppuccinCompile'}
Plug 'kyazdani42/nvim-tree.lua'     " Explorer
Plug 'akinsho/toggleterm.nvim'      " Terminal
Plug 'rmagatti/auto-session'        " Session
Plug 'neovim/nvim-lspconfig'        
""" Features
Plug 'lewis6991/gitsigns.nvim'      " Git
Plug 'kyazdani42/nvim-web-devicons' " Icons
Plug 'windwp/nvim-autopairs'        " Pairs
Plug 'numToStr/Comment.nvim'        " Comments
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
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
call plug#end()

""" Vimtex
let g:vimtex_view_method='zathura'

lua << EOF
require("nvim-autopairs").setup()
require("Comment").setup()
require("catppuccin").setup({
    integrations = {
    	dap = {
    		enabled = true,
    		enable_ui = true,
    	},
    }
})
require("lsp")
require("git")
require("debugger")
require("explorer")
require("neorg").setup({
    load = {
        ["core.highlights"] = {
            config = {
                todo_items_match_color = "all",
            },
        },
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
    },
})
require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "comment", "make", "lua", "python", "vim", "norg" },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = { "python" },
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

autocmd FileType cpp,c nnoremap <buffer> <silent> <A-o> :ClangdSwitchSourceHeader<CR> 

autocmd FileType cpp,c,make nnoremap <buffer> <leader>m :w <CR> :Make<CR>
autocmd FileType cpp,c,make nnoremap <buffer> <leader>bm :w <CR> :!bear -- make<CR>
