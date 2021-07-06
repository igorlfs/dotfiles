call plug#begin('~/.local/share/nvim/site/autoload/plugged')
""" Colorscheme
Plug 'folke/tokyonight.nvim' 
""" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'romgrk/nvim-treesitter-context'
""" Vscode features
Plug 'neoclide/coc.nvim', {'branch': 'release'}
""" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
""" Miscellaneous
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'hoob3rt/lualine.nvim'
Plug 'lukas-reineke/indent-blankline.nvim', {'for': 'cpp'}
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
set cindent
set relativenumber number      " numberlines for motion
set scrolloff=5				         " context lines when scrolling
set mouse=a				             " mousescroll, fix number lines
set clipboard+=unnamedplus	   " use system clipboard
set wildmode=longest,list,full " funky wildmenu
set linebreak                  " wrap long lines
set splitbelow splitright      " fix splits
set hidden                     " allows the editing of multiple files 
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
set foldnestmax=12             " deepest fold is 12 levels
set foldlevel=1                " prevents treesitter from collapsing the file in a single line
set nofoldenable               " don't fold by default
" Use treesitter to fold
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
""" Files
set undofile				           " enables persistent undo
set undodir=$XDG_DATA_HOME/nvim/undo// " persistent undo location
set shadafile=NONE		         " don't save history
set nobackup                   " use swap instead of backups
""" Compile C++
autocmd FileType cpp nmap <leader>c :w <CR> :!g++ -std=c++17 -g *.cpp -Wall -o main <CR>
""" Disable comment on new lines
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

""""""""""""""" Plugins
""" Floaterm
let g:floaterm_keymap_toggle = '<A-p>'

""" Colorscheme
let g:tokyonight_style = "night"
colorscheme tokyonight

""" Treesitter
lua<<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp"},
  highlight = {
    enable = true,
    custom_captures = {},
    },
  indent = {
    enable = true
  }
}
require'treesitter-context.config'.setup{
    enable = true, 
}
EOF

""" Indent Line
"let g:indentLine_char = '▏'
let g:indentLine_char = '┊'
let g:indent_blankline_use_treesitter = v:true
" TODO: improve context indent highlighted by treesitter
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_context_patterns = ['class', 'function', 'method','^if','^for','^do','^while','^case']

""" Lualine
lua<<EOF
require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'tokyonight',
  },
  sections = {
    lualine_x = {}
  },
  tabline = {},
}
EOF
"""""""""""""""""""""""""LEGACY""""""""""""""""""""""""""""""
""" FZF
"nmap <silent> <C-p> :Files<cr>
""""" Vimspector
"let g:vimspector_enable_mappings = 'HUMAN'
"nmap <silent> <F2> :VimspectorReset <CR>
"F3         <Plug>VimspectorStop
"F4         <Plug>VimspectorRestart !!!
"F5         <Plug>VimspectorContinue
"F6         <Plug>VimspectorPause
"F8         <Plug>VimspectorAddFunctionBreakpoint !!!
"F9         <Plug>VimspectorToggleBreakpoint
"<leader>F9 <Plug>VimspectorToggleConditionalBreakpoint
"<leader>F8 <Plug>VimspectorRunToCursor
"F10        <Plug>VimspectorStepOver
"F11        <Plug>VimspectorStepInto
"F12        <Plug>VimspectorStepOut
