return {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = true,
    keys = {
        {
            "S",
            mode = { "n", "o", "x" },
            function() require("flash").treesitter() end,
            desc = "Flash Treesitter",
        },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        {
            "R",
            mode = { "o", "x" },
            function() require("flash").treesitter_search() end,
            desc = "Treesitter Search",
        },
    },
}
