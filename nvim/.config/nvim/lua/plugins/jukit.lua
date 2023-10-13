return {
    "luk400/vim-jukit",
    ft = { "python", "julia" },
    init = function()
        vim.g.jukit_mappings_ext_enabled = {} -- disable default mappings
        vim.g.jukit_terminal = "nvimterm"
    end,
    config = function()
        local function keymap(shortcut, command, desc) vim.keymap.set("n", shortcut, command, { desc = desc }) end

        keymap("<A-i>", "<C-w>wi", "Move from Code to REPL")

        -- Goto cells
        -- NOTE we use 'x' instead of 'c' (for [C]ell) because gitsigns uses 'c' and it's also a default mapping for moving within changes in diffs
        keymap("]x", "<CMD>call jukit#cells#jump_to_next_cell()<CR>", "Jukit goto next cell")
        keymap("[x", "<CMD>call jukit#cells#jump_to_previous_cell()<CR>", "Jukit goto previous cell")
        -- Splits
        keymap("<localleader>o", "<CMD>call jukit#splits#output()<CR>", "Jukit Split [O]pen")
        keymap("<localleader>h", "<CMD>call jukit#splits#history()<CR>", "Jukit Split [H]istory")
        keymap("<localleader>e", "<CMD>call jukit#splits#close_output_and_history(1)<CR>", "Jukit Split [E]xit")
        -- Export to PDF
        keymap(
            "<localleader>p",
            "<CMD>call jukit#convert#save_nb_to_file(0,1,'pdf')<CR>",
            "Jukit export [P]DF (use saved data)"
        )
        keymap(
            "<localleader>P",
            "<CMD>call jukit#convert#save_nb_to_file(1,1,'pdf')<CR>",
            "Jukit Export [P]DF (re-run all cells)"
        )
        ---- Cells
        -- Move
        keymap("<localleader>k", "<CMD>call jukit#cells#move_up()<CR>", "Jukit Move Up")
        keymap("<localleader>j", "<CMD>call jukit#cells#move_down()<CR>", "Jukit Move Down")
        -- Delete
        keymap("<localleader>d", "<CMD>call jukit#cells#delete()<CR>", "Jukit [D]elete cell")
        -- Split
        keymap("<localleader>s", "<CMD>call jukit#cells#split()<CR>", "Jukit [S]plit cell")
        -- Merge
        keymap("<localleader>M", "<CMD>call jukit#cells#merge_above()<CR>", "Jukit [M]erge cell above")
        keymap("<localleader>m", "<CMD>call jukit#cells#merge_below()<CR>", "Jukit [M]erge cell below")
        -- Create
        keymap("<localleader>C", "<CMD>call jukit#cells#create_above(0)<CR>", "Jukit create [C]ode cell above")
        keymap("<localleader>c", "<CMD>call jukit#cells#create_below(0)<CR>", "Jukit create [C]ode cell below")
        keymap("<localleader>T", "<CMD>call jukit#cells#create_above(1)<CR>", "Jukit create [T]ext cell above")
        keymap("<localleader>t", "<CMD>call jukit#cells#create_below(1)<CR>", "Jukit create [T]ext cell below")
        -- Run
        keymap("<leader><leader>", "<CMD>call jukit#send#section(1)<CR>", "Jukit run current cell")
        keymap("<C-space>", "<CMD>call jukit#send#until_current_section()<CR>", "Jukit run cells above")
    end,
    keys = {
        -- Export [N]otebook
        {
            "<localleader>n",
            "<CMD>call jukit#convert#notebook_convert('jupyter-notebook')<CR>",
            desc = "Jukit export [N]otebook",
            ft = { "python", "julia", "json" },
        },
    },
}
