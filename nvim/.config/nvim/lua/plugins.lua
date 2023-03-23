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
        "olimorris/persisted.nvim",
        config = function()
            require("persisted").setup()
            require("telescope").load_extension("persisted")
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
        end,
    })

    ------ DAP
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")

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
    use({
        "TimUntersberger/neogit",
        config = function()
            require("neogit").setup({ disable_commit_confirmation = true })
        end,
    })
    -- Github
    use({
        "pwntester/octo.nvim",
        config = function()
            require("octo").setup()
        end,
    })

    ------ Tests
    use("nvim-neotest/neotest")
    use("nvim-neotest/neotest-python")
    use("rouge8/neotest-rust")

    ------ Fuzzy Finder
    use({ "nvim-telescope/telescope.nvim", tag = "0.1.x" })
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

    ------  Autocomplete
    -- Completion sources
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-cmdline")
    use("rcarriga/cmp-dap") -- DAP completion
    use("dcampos/cmp-snippy")
    -- Snippets Engine
    use("dcampos/nvim-snippy")
    -- Snippets Collection
    use("honza/vim-snippets")
    -- Completion Engine
    use("hrsh7th/nvim-cmp")

    ------ Language Specific
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
        tag = "v0.3.0",
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

    ------- Vimscript
    use("tpope/vim-dispatch")
    -- Jupyter
    use("luk400/vim-jukit")

    ------ Eye candy
    -- Icons
    use("nvim-tree/nvim-web-devicons")
    -- UI
    use({ "folke/noice.nvim", requires = "MunifTanjim/nui.nvim" })
    -- Notifications
    use("rcarriga/nvim-notify")
    -- Indent Guides
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                max_indent_increase = 1,
                context_char = "│",
                show_current_context = true,
                show_trailing_blankline_indent = false,
            })
        end,
    })
    -- Winbar with context
    use({
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = { "SmiteshP/nvim-navic" },
        config = function()
            require("barbecue").setup({
                attach_navic = false,
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
