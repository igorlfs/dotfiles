"""""""""""""""" Alternative to COC
"""""""" Alternative to coc-snippets
"Plug 'SirVer/ultisnips'
"""""""" Alternative to coc-pairs
" Plug 'windwp/nvim-autopairs'
"--require('nvim-autopairs').setup()
"""""""" LSP
"Plug 'neovim/nvim-lspconfig'
"Plug 'ray-x/lsp_signature.nvim'
"Plug 'honza/vim-snippets' " Snippets collection
"--require("config.lsp")
"--require("config.nvim-compe")
"""" C++ specific config
""" [lsp] Switch between source and header
"nnoremap <silent> <A-o> :ClangdSwitchSourceHeader<CR> 
""" [lsp] Autoformat
"autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil,100)
"""""""" AutoComplete
"Plug 'hrsh7th/nvim-compe'



"""""""""""""""""""""""" Debugger
"""""""""""""""" nvim-dap
"Plug 'mfussenegger/nvim-dap'
"Plug 'rcarriga/nvim-dap-ui'
"Plug 'theHamsta/nvim-dap-virtual-text'
"--require("nvim-dap")
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

"""""""""""""""" vimspector
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

"""""""""""""""" Builtin debugger 
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



"""""""""""""""" Alternative status bar
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



"""""""""""""""" Treesitter
"""""""" Context
"Plug 'romgrk/nvim-treesitter-context'



"""""""""""""""" Miscellaneous
"""""""" Linting
"let g:ale_disable_lsp = 1
"Plug 'dense-analysis/ale' " Linting

"""""""" Embed -> firenvim

"""""""" Alternative to floaterm
"Plug 'akinsho/nvim-toggleterm.lua' " needs config

"""""""" Alternative treesitter + spell
"Plug 'lewis6991/spellsitter.nvim' " Make spell checker work with treesitter
" require('spellsitter').setup()

"""""""" CMake integration
"""" #1
"Plug 'cdelledonne/vim-cmake' 
"let g:cmake_link_compile_commands = 1
"let g:cmake_default_config = 'build'
"nnoremap <leader>cg :CMakeGenerate<cr>
"nnoremap <leader>cb :CMakeBuild<cr>
"""" #2
"Plug 'ilyachur/cmake4vim' " UNTESTED

"""""""" gtest integration
"Plug 'alepez/vim-gtest' " UNTESTED

"""""""" Default
""" Disable comment on new lines
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
