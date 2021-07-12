call plug#begin('~/.local/share/nvim/site/autoload/plugged')
""" Colorscheme
Plug 'folke/tokyonight.nvim' 
""" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'romgrk/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
""" LSP
Plug 'neovim/nvim-lspconfig'
""" AutoComplete
Plug 'hrsh7th/nvim-compe'
""" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
""" LaTeX
Plug 'lervag/vimtex'
""" Linting
Plug 'dense-analysis/ale'
""" Miscellaneous
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
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
""" Unclutter (default) status bar
set noshowcmd
set noshowmode
set noruler
""" Make k and j functional in long lines
nmap k gk
nmap j gj
""" Tabs
set tabstop=4                  " width of a TAB is set to 4
set shiftwidth=4               " indents width of 4
set softtabstop=4              " columns for a TAB
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

luafile ~/.config/nvim/plug-config/treesitter.lua
luafile ~/.config/nvim/plug-config/lsp.lua
luafile ~/.config/nvim/plug-config/nvim-dap.lua
luafile ~/.config/nvim/plug-config/nvim-compe.lua

lua << EOF
require('gitsigns').setup {}
EOF

""" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

""" Floaterm
let g:floaterm_keymap_toggle = '<A-p>'

""" indentLine
let g:indentLine_char = '▏'
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_context_patterns = ['%a']

""" nvim-autopairs
lua << EOF
require('nvim-autopairs').setup()
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true -- it will auto insert `(` after select function or method item
})
EOF

""" nvim-dap
" Virtual Text
let g:dap_virtual_text = v:true
" Change Breakpoint character " Open PR nvim-dap
sign define DapBreakpoint  text=● texthl=WarningMsg
" simplify exiting terminal mode
tnoremap <Esc> <C-\><C-n>
"  Mappings
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F9> <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <F8> <Cmd>lua require'dap'.run_to_cursor()<CR>
nnoremap <silent> <F7> <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <F6> <Cmd>lua require'dap'.pause()<CR>
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F4> <Cmd>lua require'dap'.disconnect()<CR> :lua require'dap'.stop()<CR>
" UI specific
nnoremap <silent> <F3> <Cmd>lua require'dapui'.toggle()<CR>
nnoremap <silent> <F2> <Cmd>lua require'dapui'.eval()<CR>
" Alternative to UI
"nnoremap <silent> <F3> <Cmd>lua require'dap'.repl.open({}, 'split')<CR><C-w>j
