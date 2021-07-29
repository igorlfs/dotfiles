"""""""" Alternative to gitsigns
"Plug 'airblade/vim-gitgutter'
"""""""" Alternative to Vimspector
"Plug 'mfussenegger/nvim-dap'
"Plug 'theHamsta/nvim-dap-virtual-text'
"Plug 'rcarriga/nvim-dap-ui'
"--require("nvim-dap")
""" nvim-dap
" Virtual Text
"let g:dap_virtual_text = v:true
"" Change Breakpoint character " Open PR nvim-dap
"sign define DapBreakpoint  text=● texthl=WarningMsg
""  Mappings
"nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
"nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
"nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
"nnoremap <silent> <F9> <Cmd>lua require'dap'.toggle_breakpoint()<CR>
"nnoremap <silent> <F8> <Cmd>lua require'dap'.run_to_cursor()<CR>
"nnoremap <silent> <F7> <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
"nnoremap <silent> <F6> <Cmd>lua require'dap'.pause()<CR>
"nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
"nnoremap <silent> <F4> <Cmd>lua require'dap'.disconnect()<CR> :lua require'dap'.stop()<CR>
"" UI specific
"nnoremap <silent> <F3> <Cmd>lua require'dapui'.toggle()<CR>
"nnoremap <silent> <F2> <Cmd>lua require'dapui'.eval()<CR>
"" Alternative to UI
""nnoremap <silent> <F3> <Cmd>lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>j
"""""""" Alternative to COC
"Plug 'neovim/nvim-lspconfig'
"Plug 'ray-x/lsp_signature.nvim'
"Plug 'honza/vim-snippets'
"--require("config.lsp")
"--require("config.nvim-compe")
""""" C++ specific config
""" [lsp] Switch between source and header
"nnoremap <silent> <A-o> :ClangdSwitchSourceHeader<CR> 
""" [lsp] Autoformat
"autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil,100)
""""" AutoComplete
"Plug 'hrsh7th/nvim-compe'
""""" Autopairs " Using coc-pairs instead
" Plug 'windwp/nvim-autopairs'
"TODO: improve LaTeX pairs
lua << EOF
--require('nvim-autopairs').setup()
EOF
"""""""" Alternative status bar
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
"""""""" Miscellaneous
"""""" Alternative to floaterm
"Plug 'akinsho/nvim-toggleterm.lua' " needs  config
"""""" indentLine
"Plug 'lukas-reineke/indent-blankline.nvim', {'for': 'cpp'}
"let g:indentLine_char = '▏'
"let g:indent_blankline_use_treesitter = v:true
"let g:indent_blankline_show_current_context = v:true
"let g:indent_blankline_context_patterns = ['%a']
""""" FZF
"nmap <silent> <C-p> :Files<cr>
