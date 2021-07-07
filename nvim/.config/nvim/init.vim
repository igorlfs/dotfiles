call plug#begin('~/.local/share/nvim/site/autoload/plugged')
""" Colorscheme
Plug 'folke/tokyonight.nvim' 
""" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'romgrk/nvim-treesitter-context'
""" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
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

""" Lua
luafile ~/.config/nvim/plug-config/treesitter.lua
luafile ~/.config/nvim/plug-config/nvim-dap.lua
luafile ~/.config/nvim/plug-config/nvim-compe.lua

""" Git signs
lua << EOF
require('gitsigns').setup()
EOF

""" LSP
lua<<EOF
require'lspconfig'.clangd.setup{}
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "clangd" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF
""" Nvim-DAP
luafile ~/.config/nvim/plug-config/nvim-dap.lua
tnoremap <Esc> <C-\><C-n>
" Virtual Text
let g:dap_virtual_text = v:true
" Change Breakpoint character " Open PR nvim-dap
sign define DapBreakpoint  text=● texthl=WarningMsg
" Mappings
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F9> <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <F8> <Cmd>lua require'dap'.run_to_cursor()<CR>
nnoremap <silent> <F7> <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <F6> <Cmd>lua require'dap'.pause()<CR>
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F4> <Cmd>lua require'dap'.disconnect()<CR> :lua require'dap'.stop()<CR>
"nnoremap <silent> <F3> <Cmd>lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
nnoremap <silent> <F3> <Cmd>lua require'dapui'.toggle()<CR>
nnoremap <silent> <F2> <Cmd>lua require'dapui'.eval()<CR>

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
--require'treesitter-context.config'.setup{
--    enable = true, 
--}
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
""" COC
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"source ~/.config/nvim/plug-config/coc.vim
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
