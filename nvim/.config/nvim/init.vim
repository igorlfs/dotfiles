lua << EOF
require("core/options")
require("core/keymaps")
require("core/autocmds")
require("core/tabline")
EOF


""""""""""""""" Plugins
call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin', 'do': ':CatppuccinCompile'}
Plug 'nvim-tree/nvim-tree.lua'          " Explorer
Plug 'akinsho/toggleterm.nvim'          " Terminal
Plug 'lewis6991/gitsigns.nvim'          " Git
" Sessions
Plug 'rmagatti/auto-session'            " Automatic sessions
Plug 'rmagatti/session-lens'            " Telescope Integration
""" LSP
Plug 'neovim/nvim-lspconfig'            
Plug 'jose-elias-alvarez/null-ls.nvim'  
""" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
""" Tests
Plug 'nvim-neotest/neotest'             
Plug 'nvim-neotest/neotest-python'
""" Fuzzy Finder
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzy-native.nvim'
""" Editing
Plug 'windwp/nvim-autopairs'                " Pairs
Plug 'numToStr/Comment.nvim'                " Comments
"""  Autocomplete + Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'rcarriga/cmp-dap'
""" LaTeX
Plug 'lervag/vimtex'
Plug 'brennier/quicktex'                    " Snippets
""" Miscellaneous
Plug 'mfussenegger/nvim-jdtls'              " Java
Plug 'luk400/vim-jukit'                     " Jupyter
Plug 'nvim-neorg/neorg'                     " Norg
Plug 'folke/neodev.nvim'                    " Lua
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
""" Libraries
Plug 'nvim-lua/plenary.nvim'                " Neorg, Neotest, null-ls, ...
Plug 'MunifTanjim/nui.nvim'                 " Noice
""" Eye candy
Plug 'nvim-tree/nvim-web-devicons'          " Icons
Plug 'folke/noice.nvim'                     " UI
Plug 'rcarriga/nvim-notify'                 " Notifications
Plug 'lukas-reineke/indent-blankline.nvim'  " Indent Guides
call plug#end()

lua << EOF
require("neodev").setup()
require("plugins.lsp")
require("plugins.cmp")
require("plugins.git")
require("plugins.test")
require("plugins.debugger")
require("plugins.explorer")
require("plugins.null-ls")
require("plugins.noice")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.miscellaneous")
require("Comment").setup()
require("nvim-autopairs").setup()

vim.cmd.colorscheme("catppuccin")

EOF
