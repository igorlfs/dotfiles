""" Compile
nnoremap <leader>cc :w <CR> :!clang++ -fstandalone-debug -std=c++17 -g *.cpp -Wall -o main <CR>
"nnoremap <leader>cc :w <CR> :!g++ -std=c++17 -g *.cpp -Wall -o main <CR>
""" FSwitch
nnoremap <silent> <A-o> :FSHere<cr>
