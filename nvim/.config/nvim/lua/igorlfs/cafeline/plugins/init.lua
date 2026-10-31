local hl = require("igorlfs.util").hl

---@param p table<string,string>
return function(p)
    hl("DapBreakpoint", { fg = p.red })
    hl("DapBreakpointCondition", { fg = p.yellow })
    hl("DapBreakpointRejected", { fg = p.mauve })
    hl("DapLogPoint", { fg = p.blue })
    hl("DapStopped", { fg = p.peach })

    hl("NvimTreeFolderIcon", { fg = p.blue })
    hl("NvimTreeImageFile", { fg = p.text })
    hl("NvimTreeIndentMarker", { fg = p.overlay })
    hl("NvimTreeNormal", { fg = p.text, bg = p.mantle })
    hl("NvimTreeSymlink", { fg = p.pink })
    hl("NvimTreeWinSeparator", { fg = p.base, bg = p.base })

    hl("NvimSurroundHighlight", { blink = true })

    hl("FzfLuaNormal", { link = "NormalFloat" })
    hl("FzfLuaBorder", { link = "FloatBorder" })
    hl("FzfLuaHeaderBind", { fg = p.yellow })
    hl("FzfLuaHeaderText", { fg = p.peach })
    hl("FzfLuaDirPart", { link = "NonText" })
    hl("FzfLuaTitle", { link = "FloatTitle" })
    hl("FzfLuaBufFlagCur", { fg = p.peach })
    hl("FzfLuaPathLineNr", { fg = p.green })
    hl("FzfLuaPathColNr", { fg = p.blue })
    hl("FzfLuaTabTitle", { fg = p.sky })
    hl("FzfLuaTabMarker", { fg = p.yellow })
    hl("FzfLuaLiveSym", { fg = p.peach })
    hl("FzfLuaBufFlagAlt", { fg = p.blue })
    hl("FzfLuaBufName", { fg = p.mauve })
end
