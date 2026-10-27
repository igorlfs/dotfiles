local hl = require("igorlfs.util").hl

return function()
    hl("@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })

    -- Language specific stuff

    -- Emmylua loud semantic tokens
    hl("@lsp.type.keyword.lua", {})
    hl("@lsp.type.string.lua", {})
    hl("@lsp.type.comment.lua", {})
end
