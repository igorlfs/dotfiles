local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("nvim-treesitter/nvim-treesitter-textobjects") },
})

local ts_swap = require("nvim-treesitter-textobjects.swap")
local ts_select = require("nvim-treesitter-textobjects.select").select_textobject

-- stylua: ignore start
util.keymap("<C-.>", function() ts_swap.swap_next("@parameter.inner") end)
util.keymap("<C-,>", function() ts_swap.swap_previous("@parameter.inner") end)
util.keymap("af", function() ts_select("@function.outer") end, nil, { "x", "o" })
util.keymap("if", function() ts_select("@function.inner") end, nil, { "x", "o" })
util.keymap("aa", function() ts_select("@parameter.outer") end, nil, { "x", "o" })
util.keymap("ia", function() ts_select("@parameter.inner") end, nil, { "x", "o" })
-- stylua: ignore end
