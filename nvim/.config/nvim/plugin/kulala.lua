local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("mistweaverco/kulala.nvim") },
})

local kulala = require("kulala")

kulala.setup({
    icons = {
        inlay = {
            loading = "󰔛",
            done = "",
            error = "",
        },
        textHighlight = "Comment",
    },
    ui = {
        win_opts = {
            wo = {
                signcolumn = "no",
            },
            bo = {
                buflisted = true,
            },
        },
        syntax_hl = {
            ["@operator.kulala_http"] = "Operator",
            ["@punctuation.bracket.kulala_http"] = "@punctuation.bracket",
            ["@variable.kulala_http"] = "@variable",
        },
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "http" },
    callback = function()
        util.keymap("[r", kulala.jump_prev, "Goto prev request")
        util.keymap("]r", kulala.jump_next, "Goto next request")

        util.keymap("<leader><leader>", kulala.run, "Kulala Run")
    end,
})
