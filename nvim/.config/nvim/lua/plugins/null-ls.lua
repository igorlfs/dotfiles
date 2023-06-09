return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "LostNeophyte/null-ls-embedded" },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
        local null_ls = require("null-ls")
        local embedded = require("null-ls-embedded")
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        return {
            border = "rounded",
            sources = {
                -- Markdown
                formatting.markdownlint,

                -- SML
                formatting.smlfmt,

                -- Shell
                formatting.shfmt,

                -- YAML
                formatting.yamlfmt,

                -- Lua
                diagnostics.selene,
                formatting.stylua,

                -- Python
                formatting.black,
                formatting.isort,

                -- C++
                diagnostics.cppcheck,

                -- Format inline code
                embedded.nls_source,
            },
        }
    end,
}
