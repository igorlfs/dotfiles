return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    keys = function()
        local ts_swap = require("nvim-treesitter-textobjects.swap")
        local ts_select = require("nvim-treesitter-textobjects.select").select_textobject
        return {
            -- stylua: ignore start
            { "<C-.>", function() ts_swap.swap_next("@parameter.inner") end },
            { "<C-,>", function() ts_swap.swap_previous("@parameter.inner") end },
            { "af", function() ts_select("@function.outer") end, mode = { "x", "o" } },
            { "if", function() ts_select("@function.inner") end, mode = { "x", "o" } },
            { "aa", function() ts_select("@parameter.outer") end, mode = { "x", "o" } },
            { "ia", function() ts_select("@parameter.inner") end, mode = { "x", "o" } },
            -- stylua: ignore end
        }
    end,
}
