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
    keys = {
        { "[r", function() require("kulala").jump_prev() end, ft = "http" },
        { "]r", function() require("kulala").jump_next() end, ft = "http" },
        { "<leader><leader>", function() require("kulala").run() end, ft = "http" },
    },
}
