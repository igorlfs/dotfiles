local status, treesitter = pcall(require, "nvim-treesitter.configs")

if not status then
    vim.notify("treesitter not found")
    return
end

treesitter.setup({
    ensure_installed = {
        "c",
        "cpp",
        "make",
        "lua",
        "python",
        "vim",
        "vimdoc",
        "java",
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
        "latex",
        "bibtex",
        "rust",
        "typescript",
        "javascript",
    },
    highlight = {
        enable = true,
        disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },
    indent = {
        enable = true,
        disable = { "python" },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        lsp_interop = {
            enable = true,
            border = "rounded",
            floating_preview_opts = {},
            peek_definition_code = {
                ["<leader>pf"] = "@function.outer",
                ["<leader>pc"] = "@class.outer",
            },
        },
    },
})

vim.treesitter.language.register("markdown", "octo")
vim.treesitter.language.register("gitcommit", "NeogitCommitMessage")
