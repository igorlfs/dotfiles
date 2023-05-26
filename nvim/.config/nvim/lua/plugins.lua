local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    -- Package manager
    use("wbthomason/packer.nvim")

    -- Colorscheme
    use({ "catppuccin/nvim", as = "catppuccin", run = ":CatppuccinCompile" })
    -- Explorer
    use("nvim-tree/nvim-tree.lua")
    -- Terminal
    use({
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<a-p>]],
                direction = "float",
                float_opts = {
                    border = "rounded",
                },
            })
        end,
    })
    -- Sessions
    use({
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup({
                auto_session_suppress_dirs = { "~/" },
            })
            vim.keymap.set("n", "<leader>fs", require("auto-session.session-lens").search_session)
        end,
    })
    -- Library used by many plugins
    use("nvim-lua/plenary.nvim")

    ------ Treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-textobjects")

    ------ LSP
    use("neovim/nvim-lspconfig")
    use("jose-elias-alvarez/null-ls.nvim")
    use("LostNeophyte/null-ls-embedded")

    ------ LSP Extensions
    -- workspace/willRename
    use({
        "antosha417/nvim-lsp-file-operations",
        config = function()
            require("lsp-file-operations").setup()
        end,
    })
    -- textDocument/foldingRange (lineFoldingOnly)
    use({
        "kevinhwang91/nvim-ufo",
        requires = "kevinhwang91/promise-async",
        config = function()
            require("ufo").setup()
            -- Don't change fold level when opening and closing all folds
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
        end,
    })

    ------ DAP
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use({
        "LiadOz/nvim-dap-repl-highlights",
        config = function()
            require("nvim-dap-repl-highlights").setup()
        end,
    })
    use("mfussenegger/nvim-dap-python")

    ------ Mini
    use("echasnovski/mini.indentscope")

    ------ Install LSP/DAP
    use({
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({ ui = { border = "rounded" } })
        end,
    })
    use({
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end,
    })

    ------ Git
    use("lewis6991/gitsigns.nvim")
    use("sindrets/diffview.nvim")
    use({
        "TimUntersberger/neogit",
        config = function()
            require("neogit").setup({
                disable_commit_confirmation = true,
                integrations = {
                    diffview = true,
                },
            })
        end,
    })
    -- Github
    use({
        "pwntester/octo.nvim",
        config = function()
            require("octo").setup({
                use_local_fs = true,
                mappings = {
                    review_diff = {
                        add_review_comment = { lhs = "<space>ac", desc = "add a new review comment" },
                        add_review_suggestion = { lhs = "<space>as", desc = "add a new review suggestion" },
                    },
                },
            })
        end,
    })

    ------ Tests
    use("nvim-neotest/neotest")
    use("nvim-neotest/neotest-python")
    use("rouge8/neotest-rust")
    use("haydenmeade/neotest-jest")
    use("andy-bell101/neotest-java")

    ------ Fuzzy Finder
    use("nvim-telescope/telescope.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    ------ Editing
    -- Pairs
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    })
    -- Tags
    use({
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    })
    -- Surround
    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end,
    })
    -- Comments
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })
    -- Colors
    use("uga-rosa/ccc.nvim")
    -- Indent
    use({
        "nmac427/guess-indent.nvim",
        config = function()
            require("guess-indent").setup()
        end,
    })
    -- Tasks
    use({
        "stevearc/overseer.nvim",
        config = function()
            require("overseer").setup()
        end,
    })

    ------  Autocomplete
    -- Completion sources
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-cmdline")
    use("rcarriga/cmp-dap")
    use("dcampos/cmp-snippy")
    -- Snippets Engine
    use("dcampos/nvim-snippy")
    -- Snippets Collection
    use("honza/vim-snippets")
    -- Completion Engine
    use("hrsh7th/nvim-cmp")

    ------ Language Specific
    -- LaTeX
    use("lervag/vimtex")
    -- Python
    use({
        "linux-cultist/venv-selector.nvim",
        config = function()
            require("venv-selector").setup()
        end,
    })
    -- Jupyter
    use("luk400/vim-jukit")
    -- SML
    use("jez/vim-better-sml")
    -- JSON / YAML
    use("b0o/schemastore.nvim")
    -- Java
    use("mfussenegger/nvim-jdtls")
    -- Lua
    use("folke/neodev.nvim")
    -- Markdown
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })
    -- Rust
    use("simrat39/rust-tools.nvim")
    use({
        "saecki/crates.nvim",
        config = function()
            require("crates").setup({
                null_ls = {
                    enabled = true,
                },
                popup = {
                    border = "rounded",
                },
            })
        end,
    })

    ---- UI
    -- vim.ui.select, vim.ui.input
    use({
        "stevearc/dressing.nvim",
        config = function()
            require("dressing").setup()
        end,
    })
    -- messages, cmdline
    use({ "folke/noice.nvim", requires = "MunifTanjim/nui.nvim" })

    ------ Eye candy
    -- Status Line
    use("nvim-lualine/lualine.nvim")
    -- Status Column
    use("luukvbaal/statuscol.nvim")
    -- Icons
    use("nvim-tree/nvim-web-devicons")
    -- Notifications
    use({
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                on_open = function(win)
                    vim.api.nvim_win_set_config(win, { focusable = false })
                end,
            })
        end,
    })
    -- Indent Guides
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                max_indent_increase = 1,
                show_trailing_blankline_indent = false,
            })
        end,
    })
    -- Highlight word under the cursor
    use({
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({ providers = { "lsp" } })
        end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require("packer").sync()
    end
end)
