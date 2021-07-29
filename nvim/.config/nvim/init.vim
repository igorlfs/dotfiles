let g:ale_disable_lsp = 1
call plug#begin('~/.local/share/nvim/site/autoload/plugged')
""" Colorscheme
Plug 'folke/tokyonight.nvim' 
""" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'romgrk/nvim-treesitter-context'
""" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
""" Linting
Plug 'dense-analysis/ale' "ALE's Linter is better
""" Debugger
Plug 'puremourning/vimspector'
""" LaTeX
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
""" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
""" IndentLine
Plug 'lukas-reineke/indent-blankline.nvim'
""" Miscellaneous
Plug 'nvim-lua/plenary.nvim'
Plug 'derekwyatt/vim-fswitch'
Plug 'tpope/vim-commentary'
Plug 'voldikss/vim-floaterm'
call plug#end()

""""""""""""""" Default
filetype plugin indent on
if (has("termguicolors"))
  set termguicolors
endif
syntax enable
set nohlsearch
set ignorecase
set smartcase
set relativenumber number      " numberlines for motion
set scrolloff=5				         " context lines when scrolling
set mouse=a				             " mousescroll, fix number lines
set clipboard+=unnamedplus	   " use system clipboard
set wildmode=longest,list,full " funky wildmenu
set linebreak                  " wrap long lines
set splitbelow splitright      " fix splits
set hidden                     " allows the editing of multiple files 
set updatetime=300
let mapleader = " "
set signcolumn=yes
""" Unclutter (default) status bar
set noshowcmd
set noshowmode
set noruler
""" Make k and j functional in long lines
nmap k gk
nmap j gj
""" Tabs
set tabstop=2                  " width of a TAB is set to 2
set shiftwidth=2               " indents width of 2
set softtabstop=2              " columns for a TAB
set expandtab                  " expand TABs to space
""" Folding
set foldmethod=indent
set foldnestmax=12             " deepest fold is 12 levels
set nofoldenable               " don't fold by default
""" Files
set undofile				           " enables persistent undo
set undodir=$XDG_DATA_HOME/nvim/undo// " persistent undo location
set shadafile=NONE		         " don't save history
set nobackup                   " use swap instead of backups
""" Disable comment on new lines
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

""""""""""""""" Plugins
let g:tokyonight_style = "night"
let g:tokyonight_italic_comments = 0
colorscheme tokyonight

source ~/.config/nvim/plug-config/coc.vim

lua << EOF
require("treesitter")
require("indent-blankline")
require('gitsigns').setup {}
EOF

nnoremap <leader>cc :!pandoc % -t beamer -o pres.pdf<CR>
""" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

""" Floaterm
let g:floaterm_keymap_toggle = '<A-p>'

""" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'
nmap <silent> <F2> :VimspectorReset <CR>
nmap ç <Plug>VimspectorBalloonEval
"F3         <Plug>VimspectorStop
"F4         <Plug>VimspectorRestart !!!
"F5         <Plug>VimspectorContinue
"F6         <Plug>VimspectorPause
"F8         <Plug>VimspectorAddFunctionBreakpoint !!!
"<leader>F8 <Plug>VimspectorRunToCursor
"F9         <Plug>VimspectorToggleBreakpoint
"<leader>F9 <Plug>VimspectorToggleConditionalBreakpoint
"F10        <Plug>VimspectorStepOver
"F11        <Plug>VimspectorStepInto
"F12        <Plug>VimspectorStepOut
" simplify exiting terminal mode
tnoremap <Esc> <C-\><C-n>
