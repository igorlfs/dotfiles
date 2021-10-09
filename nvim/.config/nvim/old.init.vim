"""""""""""""""""""""""" Alternative IDE features
"""""""""""""""" builtin
"Plug 'neovim/nvim-lspconfig'
"Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
"Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
"Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
"Plug 'L3MON4D3/LuaSnip' " Snippets plugin
"--require('lsp')
"""""""""""""""" coc
"Plug 'neoclide/coc.nvim', {'branch': 'release'} " IDE Features
"source ~/.config/nvim/plug-config/coc.vim



"""""""""""""""""""""""" Alternative Snippets
"""""""""""""""" Engine
"""""""" #1: see IDE features (coc)
"""""""" #2
"Plug 'SirVer/ultisnips'
"""""""""""""""" Source
"Plug 'honza/vim-snippets'



"""""""""""""""""""""""" Debuggers
"""""""""""""""" #1: nvim-dap
"Plug 'mfussenegger/nvim-dap'
"Plug 'rcarriga/nvim-dap-ui'
"Plug 'theHamsta/nvim-dap-virtual-text'
"--require("debug")
""" Virtual Text
"let g:dap_virtual_text = v:true
""" Change Breakpoint character
"sign define DapBreakpoint  text=● texthl=WarningMsg
"""  Mappings
"nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
"nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
"nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
"nnoremap <silent> <F9> <Cmd>lua require'dap'.toggle_breakpoint()<CR>
"nnoremap <silent> <F8> <Cmd>lua require'dap'.run_to_cursor()<CR>
"nnoremap <silent> <F7> <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
"nnoremap <silent> <F6> <Cmd>lua require'dap'.pause()<CR>
"nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
"nnoremap <silent> <F4> <Cmd>lua require'dap'.disconnect()<CR> :lua require'dap'.close()<CR>
""" UI specific
"nnoremap <silent> <F3> <Cmd>lua require'dapui'.toggle()<CR>
"nnoremap <silent> <F2> <Cmd>lua require'dapui'.eval()<CR>
""" Alternative to UI
"nnoremap <silent> <F3> <Cmd>lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>j

"""""""""""""""" #2: Vimspector
"Plug 'puremourning/vimspector', {'for': 'cpp'} " Debugger *
""" Vimspector
"let g:vimspector_sidebar_width = 40
"let g:vimspector_bottombar_height = 6
"let g:vimspector_enable_mappings = 'HUMAN'
"nnoremap <silent> <leader><F3> :VimspectorReset <CR>
"nnoremap <F2> <Plug>VimspectorBalloonEval
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

"""""""""""""""" #3: Builtin
"packadd termdebug
""https://stackoverflow.com/a/61647406
"let g:termdebug_wide=1
"nnoremap <silent> <F2> :Evaluate<CR>
"nnoremap <silent> <F3> :Stop<CR>
"nnoremap <silent> <F4> :Continue<CR>
"nnoremap <silent> <F5> :Termdebug build/main <CR>
"nnoremap <silent> <F8> :Clear<CR>
"nnoremap <silent> <F9> :Break<CR>
"nnoremap <silent> <F10> :Over<CR>
"nnoremap <silent> <F11> :Step<CR>
"nnoremap <silent> <F12> :Finish<CR>



"""""""""""""""""""""""" Status bar
"Plug 'hoob3rt/lualine.nvim'
lua<<EOF
--require'lualine'.setup {
--  options = {
--    icons_enabled = false,
--    theme = 'tokyonight',
--  },
--  sections = {
--    lualine_x = {}
--  },
--  tabline = {},
--}
EOF


"""""""""""""""""""""""" Treesitter
"""""""""""""""" Context
"Plug 'romgrk/nvim-treesitter-context'
"""""""""""""""" Spellchecker
"Plug 'lewis6991/spellsitter.nvim' 
" require('spellsitter').setup()


"""""""""""""""""""""""" Miscellaneous
"""""""""""""""" Themes 
"Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
"let g:tokyonight_style = "night"
"Plug 'Pocco81/Catppuccino.nvim'

"""""""""""""""" Autopairs 
"""""""" #1: coc-pairs
"""""""" #2 
"Plug 'windwp/nvim-autopairs'
"--require('nvim-autopairs').setup()

"""""""""""""""" Linting
"let g:ale_disable_lsp = 1
"Plug 'dense-analysis/ale' " Linting

"""""""""""""""" Embed -> firenvim

"""""""""""""""" Autosession (persistence)
"""""""" #1
"Plug 'Shatur/neovim-session-manager'
" Syntax highlighting not working (bug in neovim)
"-> By default, sessions do not restore :syntax on
"-> Other than that, it's pretty nice, working fully automated and not even
" needing bindings
""" #2: No plug:
"autocmd! VimLeave * mksession
"autocmd! VimEnter * source ./Session.vim
"-> Also having problems with syntax highlighting 
"-> Kind of clutters project's directory

"""""""""""""""" Github integration (Neogit)
"Plug 'tpope/vim-fugitive' 

"""""""""""""""" CMake integration
"""""""" #1
"Plug 'cdelledonne/vim-cmake' 
"let g:cmake_link_compile_commands = 1
"let g:cmake_default_config = 'build'
"nnoremap <leader>cg :CMakeGenerate<cr>
"nnoremap <leader>cb :CMakeBuild<cr>
"""""""" #2
"Plug 'ilyachur/cmake4vim' " UNTESTED

"""""""""""""""" GoogleTest integration
"Plug 'alepez/vim-gtest' " UNTESTED

"""""""""""""""""""""""" Default
""" Disable comment on new lines
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
