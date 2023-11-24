return {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
        require("flash").setup()

        -- Disable within regular search by default
        require("flash").toggle()
    end,
    keys = {
        { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<A-f>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash" },
    },
}
