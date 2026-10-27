if vim.g.colors_name then
    vim.cmd("highlight clear")
end
vim.g.colors_name = "cafeline"

local hl = require("igorlfs.util").hl
local p = require("igorlfs.cafeline").palette

vim.g.terminal_color_0 = p.overlay
vim.g.terminal_color_8 = p.overlay
vim.g.terminal_color_1 = p.red
vim.g.terminal_color_9 = p.red
vim.g.terminal_color_2 = p.green
vim.g.terminal_color_10 = p.green
vim.g.terminal_color_3 = p.yellow
vim.g.terminal_color_11 = p.yellow
vim.g.terminal_color_4 = p.blue
vim.g.terminal_color_12 = p.blue
vim.g.terminal_color_5 = p.pink
vim.g.terminal_color_13 = p.pink
vim.g.terminal_color_6 = p.sky
vim.g.terminal_color_14 = p.sky
vim.g.terminal_color_7 = p.text
vim.g.terminal_color_15 = p.text

require("igorlfs.cafeline.groups")()
require("igorlfs.cafeline.syntax")()
require("igorlfs.cafeline.treesitter")()
require("igorlfs.cafeline.tokens")()
require("igorlfs.cafeline.plugins")()

hl("DiagnosticError", { fg = p.red })
hl("DiagnosticWarn", { fg = p.yellow })
hl("DiagnosticInfo", { fg = p.blue })
hl("DiagnosticHint", { fg = p.lavender })
hl("DiagnosticOk", { fg = p.green })
hl("DiagnosticUnderlineError", { sp = p.red, update = true })
hl("DiagnosticUnderlineWarn", { sp = p.yellow, update = true })
hl("DiagnosticUnderlineInfo", { sp = p.blue, update = true })
hl("DiagnosticUnderlineHint", { sp = p.lavender, update = true })
hl("DiagnosticUnderlineOk", { sp = p.green, update = true })
hl("DiagnosticUnnecessary", { dim = true })

hl("debugPC", { bg = p.crust })


