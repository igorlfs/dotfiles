local autocmd = vim.api.nvim_create_autocmd

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    desc = "Reload files if they changed externaly",
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd.checktime()
        end
    end,
})

autocmd("FileType", {
    desc = "Enable Softwrap",
    pattern = { "tex", "octo", "typst", "markdown" },
    callback = function() vim.wo[0][0].wrap = true end,
})

-- From https://github.com/neovim/neovim/pull/30164#issuecomment-2315421660
autocmd("FileType", {
    desc = "Enable Treesitter",
    callback = function(args)
        if not pcall(vim.treesitter.start, args.buf) then
            return
        end

        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"

        -- Properly restore folds when restoring sessions
        vim.api.nvim_buf_call(args.buf, function() vim.cmd.normal("zx") end)
    end,
})

autocmd("TextYankPost", {
    desc = "Highlight on yank",
    callback = function() vim.hl.on_yank() end,
})

-- From https://github.com/neovim/neovim/issues/27489
autocmd("DirChanged", {
    desc = "Reload .nvim.lua when changing directory",
    callback = function(args)
        local contents = vim.secure.read(string.format("%s/.nvim.lua", args.file))
        if contents then
            assert(loadstring(contents))()
        end
    end,
})

autocmd("FileType", {
    desc = "Enable Spellchecker",
    pattern = { "gitcommit", "tex", "octo", "typst" },
    callback = function() vim.wo[0][0].spell = true end,
})
