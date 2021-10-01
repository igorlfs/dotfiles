""""""""""""""" Default
filetype plugin indent on
if (has("termguicolors")) 
    set termguicolors 
endif
syntax enable
set nohlsearch
set updatetime=200
set relativenumber number      " number lines for motion
set scrolloff=5			       " context lines when scrolling
set mouse=a				       " mouse scroll, fix number lines
set clipboard+=unnamedplus	   " use system clipboard
set wildmode=longest,list,full " funky wildmenu
set linebreak                  " wrap long lines
set splitbelow splitright      " fix splits
set signcolumn=yes:2           " column gitsigns + column lsp
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
" simplify exiting terminal mode
tnoremap <Esc> <C-\><C-n>
let mapleader = " "
nmap k gk
nmap j gj
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
Plug 'nvim-lua/plenary.nvim' 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax Highlighting
Plug 'tmsvg/pear-tree' " Autopairs
Plug 'folke/persistence.nvim' " Autosession
Plug 'navarasu/onedark.nvim' " Theme
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP + Snippets + Explorer
Plug 'lervag/vimtex', {'for': 'tex'} " LaTeX
""" Misc
Plug 'TimUntersberger/neogit'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'numtostr/FTerm.nvim'
Plug 'beauwilliams/focus.nvim'
call plug#end()

let g:onedark_style = 'deep'
colorscheme onedark

lua << EOF
require('gitsigns').setup() 
require('persistence').setup()
require('focus').setup() 
require('neogit').setup()
EOF

""" Source
source ~/.config/nvim/plug-config/coc.vim
luafile ~/.config/nvim/lua/treesitter.lua

""" Peartree
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_timeout = 60 
" Disable automapping so we can fix Coc mapping.
let g:pear_tree_map_special_keys = 0
" Default mappings:
imap <BS> <Plug>(PearTreeBackspace)
imap <Esc> <Plug>(PearTreeFinishExpansion)
" Get PearTreeExpand working with coc.nvim
imap <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<Plug>(PearTreeExpand)"

""" FTerm
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
