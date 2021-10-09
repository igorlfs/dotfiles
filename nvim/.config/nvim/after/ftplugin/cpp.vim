""" Builtin debugger
packadd termdebug
"https://stackoverflow.com/a/61647406
let g:termdebug_wide=1
nnoremap <silent> <F2> :Evaluate<CR>
nnoremap <silent> <F3> :Stop<CR>
nnoremap <silent> <F4> :Continue<CR>
nnoremap <silent> <F5> :Termdebug binary<CR>
nnoremap <silent> <F8> :Clear<CR>
nnoremap <silent> <F9> :Break<CR>
nnoremap <silent> <F10> :Over<CR>
nnoremap <silent> <F11> :Step<CR>
nnoremap <silent> <F12> :Finish<CR>

""" Standalone compilation:
nnoremap <leader>cc :w <CR> :!clang++ -std=c++17 -Wall -g -fstandalone-debug -o main *.cpp <cr>
" -fstandalone-debug        additional info for debugging, see https://stackoverflow.com/a/58759358

""" [coc] Switch between source and header
"nnoremap <silent> <A-o> <cmd>CocCommand clangd.switchSourceHeader <cr>

""" [builtin-lsp] Switch between source and header
nnoremap <silent> <A-o> :ClangdSwitchSourceHeader<CR> 
""" [builtin-lsp] Autoformat
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil,100)
