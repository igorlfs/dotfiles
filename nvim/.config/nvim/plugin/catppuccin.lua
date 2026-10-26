local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("catppuccin/nvim"), name = "catppuccin" },
})

require("catppuccin").setup({
    integrations = {
        dap = true,
    },
    term_colors = true,
    custom_highlights = function(C)
        return {
            ModeCommand = { fg = C.base, bg = C.peach, style = { "bold" } },
            ModeInsert = { fg = C.base, bg = C.green, style = { "bold" } },
            ModeNormal = { fg = C.base, bg = C.blue, style = { "bold" } },
            ModeOther = { fg = C.base, bg = C.teal, style = { "bold" } },
            ModeReplace = { fg = C.base, bg = C.red, style = { "bold" } },
            ModeVisual = { fg = C.base, bg = C.mauve, style = { "bold" } },

            ["@type.builtin"] = { fg = C.yellow },

            -- For operators like "new", "or", "typeof"...
            ["@keyword.operator"] = { link = "Operator" },

            ["@tag"] = { fg = C.mauve },
            ["@type.tag.css"] = { fg = C.mauve },

            ["@tag.attribute"] = { fg = C.lavender },

            ["@markup.raw"] = { fg = C.teal }, -- Do not highlight "non string" stuff as string
            ["@markup.list"] = { fg = C.sky }, -- Avoids a clash with the previous override

            ["@module"] = { fg = C.lavender, style = { "italic" } },
        }
    end,
})

vim.cmd.colorscheme("catppuccin-mocha")

vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { dim = true })
