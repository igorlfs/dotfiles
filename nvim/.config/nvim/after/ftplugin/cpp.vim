""" [lsp] Switch between source and header
nnoremap <silent> <A-o> :ClangdSwitchSourceHeader<CR> 
""" [lsp] Autoformat
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil,100)
""" [nvim-dap] Mappings
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
"nnoremap <silent> <F3> <Cmd>lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
