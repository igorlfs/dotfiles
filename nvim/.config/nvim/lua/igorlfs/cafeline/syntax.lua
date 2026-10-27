local hl = require("igorlfs.util").hl
local p = require("igorlfs.cafeline").palette

-- from :h group-name

return function()
    hl("Constant", { fg = p.peach })
    hl("Comment", { fg = p.overlay, italic = true })
    hl("String", { fg = p.green })
    hl("Character", { fg = p.green })
    hl("Number", { fg = p.peach })
    hl("Boolean", { fg = p.peach })
    hl("Regexp", { fg = p.peach })
    hl("Float", { link = "Number" })

    hl("Identifier", { fg = p.pink })
    hl("Function", { fg = p.blue })

    hl("Statement", { fg = p.mauve })
    hl("Conditional", { fg = p.mauve })
    hl("Repeat", { fg = p.mauve })
    hl("Label", { fg = p.lavender, bold = true })
    hl("Operator", { fg = p.sky })
    hl("Keyword", { fg = p.mauve })
    hl("Exception", { fg = p.mauve })

    hl("PreProc", { fg = p.pink })
    hl("Include", { fg = p.mauve })
    hl("Define", { link = "PreProc" })
    hl("Macro", { fg = p.mauve })
    hl("PreCondit", { link = "PreProc" })

    hl("Type", { fg = p.yellow })
    hl("StorageClass", { fg = p.yellow })
    hl("Structure", { fg = p.yellow })
    hl("Typedef", { link = "Type" })

    hl("Special", { fg = p.pink })
    hl("SpecialChar", { link = "Special" })
    hl("Tag", { link = "Special" })
    hl("Delimiter", { fg = p.overlay })
    hl("SpecialComment", { link = "Special" })
    hl("Debug", { link = "Special" })

    hl("Dimmed", { dim = true })

    hl("Error", { fg = p.red })

    hl("Todo", { bg = p.yellow, fg = p.base, bold = true })

    hl("Added", { fg = p.green })
    hl("Changed", { fg = p.blue })
    hl("Removed", { fg = p.red })

    -- Language specific

    hl("qfLineNr", { fg = p.yellow })
    hl("qfFileName", { fg = p.blue })

    hl("csvCol0", { fg = p.red })
    hl("csvCol1", { fg = p.peach })
    hl("csvCol2", { fg = p.yellow })
    hl("csvCol3", { fg = p.green })
    hl("csvCol4", { fg = p.sky })
    hl("csvCol5", { fg = p.blue })
    hl("csvCol6", { fg = p.mauve })
    hl("csvCol7", { fg = p.lavender })
    hl("csvCol8", { fg = p.pink })
    hl("escCsvCol0", { link = "csvCol0" })
end
