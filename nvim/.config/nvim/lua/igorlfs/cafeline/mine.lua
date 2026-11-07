local hl = require("igorlfs.util").hl

---@param p table<string,string>
return function(p)
    local dark = vim.o.background == "dark"

    hl("StatusLinePathDir", { bg = dark and p.surface or p.crust, bold = true })
    hl("StatusLineVimSelection", { link = "TermCursor" })
    hl("StatusLineAutoFormat", { link = "DiagnosticWarn" })
    hl("StatusLineVimSpell", { link = "Function" })
    hl("StatusLineDapIcon", { link = "Function" })
    hl("StatusLineCursorFollow", { link = "Boolean" })
    hl("StatusLineBusy", { link = "Boolean" })

    hl("ModeCommand", { fg = p.base, bg = p.peach, bold = true })
    hl("ModeInsert", { fg = p.base, bg = p.green, bold = true })
    hl("ModeNormal", { fg = p.base, bg = p.blue, bold = true })
    hl("ModeOther", { fg = p.base, bg = p.sky, bold = true })
    hl("ModeReplace", { fg = p.base, bg = p.red, bold = true })
    hl("ModeVisual", { fg = p.base, bg = p.mauve, bold = true })
end
