local hl = require("igorlfs.util").hl
local p = require("igorlfs.cafeline").palette

-- from :h treesitter-highlight-groups

return function()
    hl("@variable", { fg = p.text })
    hl("@variable.builtin", { fg = p.red })
    hl("@variable.parameter", { fg = p.maroon })
    hl("@variable.parameter.builtin", { fg = p.maroon, bold = true })
    hl("@variable.member", { fg = p.lavender })

    hl("@constant.builtin", { link = "Constant" })

    hl("@module", { fg = p.lavender, italic = true })
    hl("@module.builtin", { fg = p.lavender, italic = true })

    hl("@string", { link = "String" })
    hl("@string.documentation", { link = "String" })
    hl("@string.regexp", { fg = p.pink })
    hl("@string.escape", { fg = p.pink })
    hl("@string.special", { link = "Special" })
    hl("@string.special.symbol", { fg = p.pink })
    hl("@string.special.path", { link = "Special" })
    hl("@string.special.url", { fg = p.blue, italic = true })

    hl("@type.builtin", { link = "Type" })

    hl("@attribute", { link = "Constant" })
    hl("@attribute.builtin", { fg = p.peach, bold = true })
    hl("@property", { fg = p.lavender })

    hl("@function", { link = "Function" })
    hl("@function.builtin", { link = "Function" })
    hl("@function.call", { link = "Function" })
    hl("@function.macro", { link = "Macro" })

    hl("@function.method", { link = "Function" })
    hl("@function.method.call", { link = "Function" })

    hl("@constructor", { fg = p.yellow })

    hl("@keyword.operator", { link = "Operator" })

    hl("@keyword.conditional.ternary", { link = "Operator" })

    hl("@keyword.directive", { link = "PreProc" })
    hl("@keyword.directive.define", { link = "Define" })

    hl("@punctuation.bracket", { link = "Delimiter" })

    hl("@comment", { link = "Comment" })
    hl("@comment.documentation", { link = "Comment" })

    hl("@comment.error", { fg = p.base, bg = p.red, bold = true })
    hl("@comment.warning", { fg = p.base, bg = p.yellow, bold = true })
    hl("@comment.todo", { fg = p.base, bg = p.lavender, bold = true })
    hl("@comment.note", { fg = p.base, bg = p.blue, bold = true })

    hl("@markup.heading.1", { fg = p.red, bold = true })
    hl("@markup.heading.2", { fg = p.peach, bold = true })
    hl("@markup.heading.3", { fg = p.yellow, bold = true })
    hl("@markup.heading.4", { fg = p.green, bold = true })
    hl("@markup.heading.5", { fg = p.sky, bold = true })
    hl("@markup.heading.6", { fg = p.blue, bold = true })

    hl("@markup.quote", { fg = p.pink })
    hl("@markup.math", { fg = p.blue })

    hl("@markup.link", { fg = p.lavender })
    hl("@markup.link.label", { fg = p.lavender })
    hl("@markup.link.url", { fg = p.blue, italic = true })

    hl("@markup.raw", { link = "Special" })

    hl("@markup.list", { link = "Operator" })
    hl("@markup.list.checked", { fg = p.green })
    hl("@markup.list.unchecked", { fg = p.overlay })

    hl("@tag", { fg = p.mauve })
    hl("@tag.builtin", { fg = p.mauve, bold = true })
    hl("@tag.attribute", { link = "@property" })
    hl("@tag.delimiter", { link = "Delimiter" })

    -- Language specific stuff

    hl("@constructor.lua", { link = "@punctuation.bracket" })

    hl("@query_param.name.kulala_http", { link = "@variable.parameter" })
    hl("@query_param.value.kulala_http", { link = "String" })
end
