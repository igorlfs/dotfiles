lua << EOF
require("core/options")
require("core/keymaps")
require("core/autocmds")
require("core/tabline")
EOF

""""""""""""""" Mappings
noremap <silent> <C-q> :tabclose<CR>
noremap <silent> <A-t> :tabnew %<CR>

""""""""""""""" Plugins
call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'catppuccin/nvim', {'as': 'catppuccin', 'do': ':CatppuccinCompile'}
Plug 'nvim-tree/nvim-tree.lua'          " Explorer
Plug 'akinsho/toggleterm.nvim'          " Terminal
Plug 'rmagatti/auto-session'            " Session
Plug 'lewis6991/gitsigns.nvim'          " Git
""" LSP
Plug 'neovim/nvim-lspconfig'            
Plug 'jose-elias-alvarez/null-ls.nvim'  
""" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
""" Tests
Plug 'nvim-neotest/neotest'             
Plug 'nvim-neotest/neotest-python'
""" Editing
Plug 'windwp/nvim-autopairs'            " Pairs
Plug 'numToStr/Comment.nvim'            " Comments
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
Plug 'lervag/vimtex'                    " LaTeX
Plug 'brennier/quicktex'                " LaTeX Snippets
""" Miscellaneous
Plug 'mfussenegger/nvim-jdtls'          " Java
Plug 'luk400/vim-jukit'                 " Jupyter
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
""" Eye candy
Plug 'nvim-tree/nvim-web-devicons'      " Icons
Plug 'j-hui/fidget.nvim'
call plug#end()

lua << EOF
require("plugins/lsp")
require("plugins/git")
require("plugins/test")
require("plugins/debugger")
require("plugins/explorer")
require("plugins/miscellaneous")

vim.cmd.colorscheme("catppuccin")

EOF
