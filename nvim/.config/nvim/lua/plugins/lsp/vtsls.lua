require("lspconfig.configs").vtsls = require("vtsls").lspconfig

require("lspconfig").vtsls.setup({
    settings = {
        typescript = {
            inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
            },
        },
    },
})
