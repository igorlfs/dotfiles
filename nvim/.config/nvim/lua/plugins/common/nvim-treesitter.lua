return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c",
                "cpp",
                "make",
                "lua",
                "python",
                "vim",
                "vimdoc",
                "json",
                "jsonc",
                "toml",
                "yaml",
                "query",
                "gitcommit",
                "gitignore",
                "regex",
                "diff",
                "bash",
                "fish",
                "markdown",
                "markdown_inline",
                "bibtex",
                "rust",
                "typescript",
                "javascript",
                "html",
                "css",
                "svelte",
                "typst",
            },
            indent = {
                enable = true,
                disable = { "python", "html" },
            },
        })
    end,
}
