"""""""" Nvim-LSP
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
""" indentLine
"Plug 'lukas-reineke/indent-blankline.nvim', {'for': 'cpp'}
"let g:indentLine_char = '▏'
"let g:indent_blankline_use_treesitter = v:true
"let g:indent_blankline_show_current_context = v:true
"let g:indent_blankline_context_patterns = ['%a']
""" Lualine
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
""" Indent Line
"Plug 'lukas-reineke/indent-blankline.nvim', {'for': 'cpp'}
" TODO: improve context indent highlighted by treesitter
"let g:indentLine_char = '▏'
"let g:indentLine_char = '┊'
"let g:indent_blankline_use_treesitter = v:true
"let g:indent_blankline_show_current_context = v:true
"let g:indent_blankline_context_patterns = ['class', 'function', 'method','^if','^else','^for','^do','^while','^case']
""" COC
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"source ~/.config/nvim/plug-config/coc.vim
""" FZF
"nmap <silent> <C-p> :Files<cr>
""""" Vimspector
"let g:vimspector_enable_mappings = 'HUMAN'
"nmap <silent> <F2> :VimspectorReset <CR>
"F3         <Plug>VimspectorStop
"F4         <Plug>VimspectorRestart !!!
"F5         <Plug>VimspectorContinue
"F6         <Plug>VimspectorPause
"F8         <Plug>VimspectorAddFunctionBreakpoint !!!
"F9         <Plug>VimspectorToggleBreakpoint
"<leader>F9 <Plug>VimspectorToggleConditionalBreakpoint
"<leader>F8 <Plug>VimspectorRunToCursor
"F10        <Plug>VimspectorStepOver
"F11        <Plug>VimspectorStepInto
"F12        <Plug>VimspectorStepOut
