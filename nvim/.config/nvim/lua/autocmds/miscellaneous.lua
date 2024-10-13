local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local keymap = require("util").keymap

local defaults = augroup("Defaults", {})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("Checktime", {}),
    desc = "Check if we need to reload the file when it changed",
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

autocmd("FileType", {
    desc = "Disable newline comments when inserting lines with o/O",
    group = defaults,
    callback = function() vim.opt_local.formatoptions:remove("o") end,
})

autocmd("Termopen", {
    desc = "Unclutter terminal",
    group = defaults,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
        vim.opt_local.foldcolumn = "0"
    end,
})

autocmd("FileType", {
    desc = "Enable Softwrap",
    group = defaults,
    pattern = { "tex", "octo", "typst", "markdown" },
    callback = function() vim.opt_local.wrap = true end,
})

autocmd("FileType", {
    desc = "Disable foldcolumn",
    pattern = {
        "neotest-summary",
        "dap-repl",
        "NeogitCommitMessage",
        "NeogitCommitView",
        "NeogitPopup",
        "NeogitStatus",
        "NeogitDiffView",
    },
    callback = function() vim.opt_local.foldcolumn = "0" end,
})

-- This could be built-in (see nvim-dap#1194 for discussion)
autocmd("FileType", {
    desc = "Quit DAP-Float",
    pattern = { "dap-float" },
    callback = function() keymap("q", "<C-w>q", { buffer = 0 }) end,
})

-- From https://github.com/neovim/neovim/pull/30164#issuecomment-2315421660
autocmd("FileType", {
    desc = "Enable treesitter folds",
    callback = function(args)
        if not pcall(vim.treesitter.start, args.buf) then
            return
        end

        if vim.api.nvim_buf_line_count(args.buf) > 40000 then
            return
        end
        vim.api.nvim_buf_call(args.buf, function()
            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[0][0].foldmethod = "expr"
            vim.cmd.normal("zx")
        end)
    end,
})

autocmd("BufWinEnter", {
    desc = "Set options on DAP-UI windows",
    group = augroup("set_dap_win_options", { clear = true }),
    pattern = { "DAP *" },
    callback = function(args)
        local win = vim.fn.bufwinid(args.buf)
        vim.schedule(function()
            if win and not vim.api.nvim_win_is_valid(win) then
                return
            end
            vim.api.nvim_set_option_value("foldcolumn", "0", { win = win })
        end)
    end,
})

autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = defaults,
    callback = function() vim.highlight.on_yank() end,
})

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
    group = defaults,
    pattern = { "gitcommit", "tex", "NeogitCommitMessage", "octo", "typst" },
    callback = function() vim.opt_local.spell = true end,
})

autocmd("User", {
    pattern = "TelescopePreviewerLoaded",
    callback = function() vim.wo.wrap = true end,
})
