require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c",
        "cpp",
        "make",
        "lua",
        "python",
        "vim",
        "java",
        "json",
        "toml",
        "yaml",
        "gitcommit",
        "gitignore",
        "regex",
        "diff",
        "help",
        "bash",
        "markdown",
        "markdown_inline",
        "bibtex",
        "rust",
        "typescript",
        "javascript",
        "vue",
        "html",
        "css",
    },
    auto_install = true,
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

require("nvim-treesitter.parsers").filetype_to_parsername.octo = "markdown"
