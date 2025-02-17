return {
    "mistweaverco/kulala.nvim",
    opts = {
        icons = {
            lualine = "󰖟",
            inlay = {
                loading = "󰔛",
                done = "",
                error = "",
            },
            textHighlight = "Comment",
        },
    },
    keys = function()
        local kulala = require("kulala")
        return {
            { "[r", kulala.jump_prev, ft = "http" },
            { "]r", kulala.jump_next, ft = "http" },
            { "<leader><leader>", kulala.run, ft = "http" },
        }
    end,
}
