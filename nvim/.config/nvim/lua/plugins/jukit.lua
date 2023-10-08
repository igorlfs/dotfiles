return {
    "luk400/vim-jukit",
    ft = { "python", "json", "julia" },
    init = function()
        vim.g.jukit_mappings_ext_enabled = {} -- disable default mappings
        vim.g.jukit_terminal = "nvimterm"
    end,
    keys = {
        {
            "<localleader>es",
            "<CMD>call jukit#convert#notebook_convert('jupyter-notebook')<CR>",
            mode = "n",
            desc = "Jukit [E]xport [S]ource",
            ft = { "python", "json" },
        },
        {
            "<A-i>",
            "<C-w>wi",
            mode = "n",
            desc = "Move from Code to REPL",
            ft = { "python", "julia" },
        },
        -- NOTE we use 'x' instead of 'c' (for [C]ell) because gitsigns uses 'c' and it's also a default mapping for moving within changes in diffs
        {
            "]x",
            "<CMD>call jukit#cells#jump_to_next_cell()<CR>",
            mode = "n",
            desc = "Jukit Jump next cell",
            ft = { "python", "julia" },
        },
        {
            "[x",
            "<CMD>call jukit#cells#jump_to_previous_cell()<CR>",
            mode = "n",
            desc = "Jukit Jump previous cell",
            ft = { "python", "julia" },
        },
    },
}
