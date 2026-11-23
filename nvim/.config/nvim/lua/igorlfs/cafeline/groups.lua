local colors = require("colors")

local hl = require("igorlfs.util").hl

-- from :h highlight-groups

---@param p table<string,string>
return function(p)
    local dark = vim.o.background == "dark"

    hl("ColorColumn", { bg = p.surface })

    hl("Conceal", { bg = p.overlay })

    hl("CurSearch", { bg = p.red, fg = p.mantle })

    hl("CursorColumn", { link = "CursorLine" })
    hl("CursorLine", { bg = dark and colors.blend(p.surface, p.base, 0.33) or colors.blend(p.mantle, p.text, 0.9) })

    hl("Directory", { fg = p.blue })

    hl("DiffAdd", { bg = colors.blend(p.green, p.base, 0.18) })
    hl("DiffChange", { bg = colors.blend(p.blue, p.base, 0.07) })
    hl("DiffDelete", { bg = colors.blend(p.red, p.base, 0.18) })
    hl("DiffText", { bg = colors.blend(p.blue, p.base, 0.30) })

    hl("OkMsg", { fg = p.green })
    hl("ErrorMsg", { fg = p.red, bold = true })
    hl("WarningMsg", { fg = p.yellow })

    hl("WinSeparator", { fg = p.crust })

    hl("Folded", { fg = p.blue, bg = dark and p.surface or colors.blend(p.mantle, p.text, 0.95) })

    hl("IncSearch", { bg = p.sky, fg = p.mantle })
    hl("Substitute", { bg = p.surface, fg = p.pink })
    hl("LineNr", { fg = p.surface })
    hl("CursorLineNr", { fg = p.lavender, bold = true })

    hl("MatchParen", { reverse = true })

    hl("MCursor", { reverse = true, dim = true })

    hl("ModeMsg", { fg = p.text, bold = true })

    hl("MsgSeparator", { bg = dark and p.mantle or p.crust })

    hl("MoreMsg", { fg = p.blue })

    hl("NonText", { fg = p.overlay })

    hl("Normal", { fg = p.text, bg = p.base })
    hl("NormalFloat", { fg = p.text, bg = p.mantle })
    hl("FloatBorder", { fg = p.blue, bg = p.mantle })

    hl("Pmenu", { bg = p.mantle, fg = p.overlay })
    hl("PmenuSel", { bg = p.surface, bold = true })
    hl("PmenuMatch", { fg = p.text, bold = true })
    hl("PmenuSbar", { bg = p.surface })
    hl("PmenuThumb", { bg = p.overlay })
    hl("ComplMatchIns", { bg = p.overlay })

    hl("Question", { fg = p.blue })

    hl("QuickFixLine", { bg = colors.blend(p.surface, p.base, 0.70), bold = true })

    hl("Search", { fg = p.mantle, bg = p.mauve })

    hl("SpellBad", { sp = p.red, update = true })
    hl("SpellCap", { sp = p.yellow, update = true })
    hl("SpellLocal", { sp = p.green, update = true })
    hl("SpellRare", { sp = p.blue, update = true })

    hl("StatusLine", { fg = p.text, bg = p.mantle })

    hl("TabLine", { fg = dark and p.overlay or p.text, bg = p.crust, dim = dark })

    hl("TabLineFill", { fg = p.text, bg = p.mantle })
    hl("TabLineSel", { link = "Normal" })

    hl("Title", { fg = p.blue, bold = true })

    hl("Visual", { bg = dark and p.surface or p.crust, bold = dark })

    hl("WinBar", {})
    hl("WinBarNC", { link = "WinBar" })
end
