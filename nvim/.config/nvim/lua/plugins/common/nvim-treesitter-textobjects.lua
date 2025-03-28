return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    keys = function()
        local swap = require("nvim-treesitter-textobjects.swap")
        return {
            { "<C-.>", function() swap.swap_next("@parameter.inner") end },
            { "<C-,>", function() swap.swap_previous("@parameter.inner") end },
        }
    end,
}
