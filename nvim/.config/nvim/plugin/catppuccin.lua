local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("catppuccin/nvim"), name = "catppuccin" },
})

require("catppuccin").setup({
    term_colors = true,
    auto_integrations = true,
    custom_highlights = function(C)
        return {
            ModeCommand = { fg = C.base, bg = C.peach, style = { "bold" } },
            ModeInsert = { fg = C.base, bg = C.green, style = { "bold" } },
            ModeNormal = { fg = C.base, bg = C.blue, style = { "bold" } },
            ModeOther = { fg = C.base, bg = C.teal, style = { "bold" } },
            ModeReplace = { fg = C.base, bg = C.red, style = { "bold" } },
            ModeVisual = { fg = C.base, bg = C.mauve, style = { "bold" } },
        }
    end,
})

vim.cmd.colorscheme("catppuccin-mocha")
