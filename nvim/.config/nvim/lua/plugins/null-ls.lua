return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "LostNeophyte/null-ls-embedded" },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
        local null_ls = require("null-ls")
        local embedded = require("null-ls-embedded")
        local formatting = null_ls.builtins.formatting
        return {
            border = "rounded",
            sources = {
                -- Markdown
                formatting.markdownlint,

                -- Shell
                formatting.shfmt,

                -- YAML
                formatting.yamlfmt,

                -- Lua
                formatting.stylua,

                -- Python
                formatting.black,
                formatting.isort,

                -- Format inline code
                embedded.nls_source,
            },
        }
    end,
}
