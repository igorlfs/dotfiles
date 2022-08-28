lua << EOF
require("core/options")
require("core/keymaps")
require("core/autocmds")
EOF

""""""""""""""" Mappings
noremap <silent> <C-q> :tabclose<CR>
noremap <silent> <A-t> :tabnew %<CR>

""""""""""""""" Plugins
call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
""" Improvements
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
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
Plug 'simrat39/rust-tools.nvim'     " Rust
Plug 'mfussenegger/nvim-jdtls'      " Java
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
""" Eye candy
Plug 'j-hui/fidget.nvim'
call plug#end()

lua << EOF
require("plugins/lsp")
require("plugins/git")
require("plugins/debugger")
require("plugins/explorer")
require("plugins/miscellaneous")
})

vim.cmd.colorscheme("catppuccin")

EOF
