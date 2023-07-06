return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "windwp/nvim-ts-autotag", config = true },
        },
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
                    "julia",
                    "typescript",
                    "javascript",
                    "html",
                    "css",
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
                textobjects = {
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
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
        end,
    },
}
