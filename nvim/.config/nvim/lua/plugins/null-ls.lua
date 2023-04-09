local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    border = "rounded",
    sources = {
        -- Markdown
        formatting.markdownlint,

        -- TS / JS / JSON
        formatting.rome,

        -- Shell
        formatting.shfmt,

        -- Lua
        diagnostics.selene,
        formatting.stylua,

        -- Python
        formatting.black,

        -- C++
        diagnostics.cppcheck,
    },
})
