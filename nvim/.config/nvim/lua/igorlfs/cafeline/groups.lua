local colors = require("colors")

local hl = require("igorlfs.util").hl

-- from :h highlight-groups

---@param p table<string,string>
return function(p)
    hl("ColorColumn", { bg = p.surface })

    hl("Conceal", { bg = p.overlay })

    hl("CurSearch", { bg = p.red, fg = p.mantle })

    hl("CursorColumn", { link = "CursorLine" })
    hl("CursorLine", { bg = colors.darken(p.surface, 0.45, p.base) })

    hl("Directory", { fg = p.blue })

    hl("DiffAdd", { bg = colors.darken(p.green, 0.18, p.base) })
    hl("DiffChange", { bg = colors.darken(p.blue, 0.07, p.base) })
    hl("DiffDelete", { bg = colors.darken(p.red, 0.18, p.base) })
    hl("DiffText", { bg = colors.darken(p.blue, 0.30, p.base) })

    hl("OkMsg", { fg = p.green })
    hl("ErrorMsg", { fg = p.red, bold = true })
    hl("WarningMsg", { fg = p.yellow })

    hl("WinSeparator", { fg = p.crust })

    hl("Folded", { fg = p.blue, bg = p.surface })

    hl("IncSearch", { bg = p.sky, fg = p.mantle })
    hl("Substitute", { bg = p.surface, fg = p.pink })
    hl("LineNr", { fg = p.surface })
    hl("CursorLineNr", { fg = p.lavender, bold = true })

    hl("MatchParen", { reverse = true })

    hl("MCursor", { reverse = true, dim = true })

    hl("ModeMsg", { fg = p.text, bold = true })

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

    hl("QuickFixLine", { bg = colors.darken(p.surface, 0.70, p.base), bold = true })

    hl("Search", { fg = p.mantle, bg = p.mauve })

    hl("SpellBad", { sp = p.red, update = true })
    hl("SpellCap", { sp = p.yellow, update = true })
    hl("SpellLocal", { sp = p.green, update = true })
    hl("SpellRare", { sp = p.blue, update = true })

    hl("StatusLine", { fg = p.text, bg = p.mantle })

    hl("TabLine", { fg = p.overlay, bg = p.crust, dim = true })
    hl("TabLineFill", { bg = p.mantle, fg = p.text })
    hl("TabLineSel", { link = "Normal" })

    hl("Title", { fg = p.blue, bold = true })

    hl("Visual", { bg = p.surface })

    hl("WinBar", {})
    hl("WinBarNC", { link = "WinBar" })
end
