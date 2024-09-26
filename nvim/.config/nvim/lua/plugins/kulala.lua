return {
    "mistweaverco/kulala.nvim",
    opts = {
        default_view = "headers_body",
        winbar = true,
        icons = {
            lualine = "󰖟",
            inlay = {
                loading = "󰔛",
                done = "",
                error = "",
            },
        },
    },
    keys = {
        { "[q", function() require("kulala").jump_prev() end, ft = "http" },
        { "]q", function() require("kulala").jump_next() end, ft = "http" },
        { "<leader><leader>", function() require("kulala").run() end, ft = "http" },
    },
}
