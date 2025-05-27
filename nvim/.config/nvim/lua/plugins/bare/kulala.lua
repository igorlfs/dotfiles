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
            { "[r", kulala.jump_prev, ft = "http", desc = "Goto next request" },
            { "]r", kulala.jump_next, ft = "http", desc = "Goto prev request" },
            { "<leader><leader>", kulala.run, ft = "http", desc = "Kulala Run" },
            { "<leader>re", kulala.set_selected_env, desc = "Kulala Env" },
            { "<leader>rc", kulala.copy, ft = "http", desc = "Kulala Copy (Curl)" },
            { "<leader>rp", kulala.from_curl, ft = "http", desc = "Kulala Paste (Curl)" },
        }
    end,
}
