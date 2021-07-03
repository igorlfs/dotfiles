call plug#begin('~/.local/share/nvim/site/autoload/plugged')

"
" Aesthetics
"
" Theme
Plug 'folke/tokyonight.nvim'  
" Status bar
Plug 'hoob3rt/lualine.nvim'
" Indentation line
Plug 'lukas-reineke/indent-blankline.nvim', {'for': 'cpp', 'branch': 'lua'}
" Shows git diff
Plug 'airblade/vim-gitgutter'

"
" IDE-like
"
" Improved syntax-highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" VSCode features
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

"
" C / C++ development
"
" Switch between header and implementation
Plug 'derekwyatt/vim-fswitch', {'for': ['c', 'cpp']}

"
" Miscellaneous
"
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'voldikss/vim-floaterm'

call plug#end()
"""""""""""""""""""""""""LEGACY"""""""""""""""""""""""""""""""
"Plug 'jiangmiao/auto-pairs' " Using coc-pairs instead
"Plug 'lervag/vimtex'
" Debugger
"Plug 'puremourning/vimspector', { 'do': 'python3 install_gadget.py --enable-cpp'}
