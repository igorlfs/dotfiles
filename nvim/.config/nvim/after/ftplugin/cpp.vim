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

""" Standalone compilation
nnoremap <leader>bm :w <cr> :!bear -- make<cr>
nnoremap <leader>m :w <cr> :make<cr>

""" [builtin-lsp] Switch between source and header
nnoremap <silent> <A-o> :ClangdSwitchSourceHeader<CR> 
