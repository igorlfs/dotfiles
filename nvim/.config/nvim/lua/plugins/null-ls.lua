local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    border = "rounded",
    sources = {
        -- Markdown
        formatting.markdownlint,

        -- Lua
        formatting.stylua,

        -- Python
        formatting.black,

        -- C++
        diagnostics.cppcheck,
    },
})
