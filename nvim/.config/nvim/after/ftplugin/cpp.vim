""" Switch between source and header
nnoremap <silent> <A-o> :ClangdSwitchSourceHeader<CR> 
""" Autoformat
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil,100)
