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
set foldmethod=indent
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
call plug#begin('~/.local/share/nvim/site/autoload/plugged')
Plug 'lewis6991/gitsigns.nvim' " Git Symbols
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax Highlighting
Plug 'windwp/nvim-autopairs' " Autopairs
Plug 'folke/persistence.nvim' " Autosession
Plug 'kyazdani42/nvim-tree.lua' " Explorer
Plug 'numtostr/FTerm.nvim' " Terminal
Plug 'navarasu/onedark.nvim' " Theme
""" IDE features
Plug 'neovim/nvim-lspconfig' " Config for builtin LSP
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin
Plug 'ray-x/lsp_signature.nvim' " Signature helper
""" Misc
Plug 'nvim-lua/plenary.nvim' " Library
Plug 'lervag/vimtex', {'for': 'tex'} " LaTeX
Plug 'TimUntersberger/neogit'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'beauwilliams/focus.nvim'
call plug#end()

let g:onedark_style = 'deep'
colorscheme onedark

lua << EOF
require('lsp')
require('treesitter')
require('nvim-tree').setup()
require('gitsigns').setup() 
require('persistence').setup()
require('focus').setup() 
require('lsp_signature').setup()
require('neogit').setup()
require('nvim-autopairs').setup()
require("nvim-autopairs.completion.cmp").setup({
map_cr = true, --  map <CR> on insert mode
map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
auto_select = true, -- automatically select the first item
insert = false, -- use insert confirm behavior instead of replace
map_char = { -- modifies the function or method delimiter by filetypes
all = '(',
tex = '{'
}
})
EOF

""" Terminal & Explorer
nnoremap <leader>v <cmd>NvimTreeToggle<cr>
nnoremap <A-p> <CMD>lua require("FTerm").toggle()<CR>
tnoremap <A-p> <C-\><C-n><CMD>lua require("FTerm").toggle()<CR>

""" Persistence
set sessionoptions+=options,resize,winpos,terminal
" restore the session for the current directory
nnoremap <leader>qs <cmd>lua require("persistence").load()<cr>
" restore the last session
nnoremap <leader>ql <cmd>lua require("persistence").load({ last = true })<cr>

""" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
