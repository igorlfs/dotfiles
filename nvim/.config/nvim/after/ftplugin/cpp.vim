nnoremap <silent> <A-o> <cmd>CocCommand clangd.switchSourceHeader <cr>
""" Explaning the compilation flags:
" -std=c++17                use c++17
" -Wall                     display more warnings
" -g                        enable debug symbols
" -fstandalone-debug        additional info for debugging, see https://stackoverflow.com/a/58759358
" -o main                   name the progam main
nnoremap <leader>cc :w <CR> :!clang++ -std=c++17 -Wall -g -fstandalone-debug *.cpp -o main <cr>
