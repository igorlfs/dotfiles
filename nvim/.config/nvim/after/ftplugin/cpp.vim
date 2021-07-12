""" Compile
nnoremap <leader>c :w <CR> :!g++ -std=c++17 -g *.cpp -Wall -Wextra -o main <CR>
""" [lsp] Switch between source and header
nnoremap <silent> <A-o> :ClangdSwitchSourceHeader<CR> 
""" [lsp] Autoformat
"autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil,100)
""" [ALE]
let b:ale_fixers = ['clang-format', 'uncrustify']
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
