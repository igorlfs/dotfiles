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
                    "groovy",
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
                    "dart",
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
                    -- See https://github.com/akinsho/flutter-tools.nvim/issues/267#issuecomment-1616728174
                    disable = { "python", "html", "dart" },
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
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
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
                            ["<leader>pf"] = { query = "@function.outer", desc = "[P]review [F]unction" },
                            ["<leader>pc"] = { query = "@class.outer", desc = "[P]review [C]lass" },
                        },
                    },
                },
            })
            vim.treesitter.language.register("markdown", "octo")
        end,
    },
}
