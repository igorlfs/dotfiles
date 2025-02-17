return {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = true,
    keys = function()
        local flash = require("flash")
        return {
            { "S", mode = { "n", "o", "x" }, flash.treesitter, desc = "Flash Treesitter" },
            { "r", mode = "o", flash.remote, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, flash.treesitter_search, desc = "Treesitter Search" },
        }
    end,
}
