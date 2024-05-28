return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
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
                "markdown",
                "markdown_inline",
                "bibtex",
                "rust",
                "typescript",
                "javascript",
                "html",
                "css",
                "gdscript",
                "svelte",
                "typst",
            },
            highlight = {
                enable = true,
                disable = function(_, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
            indent = {
                enable = true,
                disable = { "python", "html" },
            },
        })
    end,
}
