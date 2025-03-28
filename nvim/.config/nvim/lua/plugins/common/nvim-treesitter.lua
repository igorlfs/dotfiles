return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "css",
                "diff",
                "fish",
                "gitcommit",
                "gitignore",
                "html",
                "http",
                "javascript",
                "json",
                "jsonc",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "svelte",
                "toml",
                "typescript",
                "typst",
                "vim",
                "vimdoc",
                "yaml",
            },
            indent = {
                enable = true,
                disable = { "python", "html" },
            },
        })
    end,
}
