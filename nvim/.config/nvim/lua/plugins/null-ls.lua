local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    border = "rounded",
    sources = {
        -- TS / JSON / YAML / Markdown
        formatting.prettier,

        -- Python
        diagnostics.mypy,

        formatting.ruff,
        formatting.black,

        -- C++
        diagnostics.cppcheck,
    },
})
