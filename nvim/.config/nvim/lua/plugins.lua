return require("packer").startup(function(use)
    -- Package manager
    use("wbthomason/packer.nvim")

    -- Highlighting
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    -- Colorscheme
    use({ "catppuccin/nvim", as = "catppuccin", run = ":CatppuccinCompile" })
    -- Explorer
    use("nvim-tree/nvim-tree.lua")
    -- Terminal
    use("akinsho/toggleterm.nvim")
    -- Git
    use("lewis6991/gitsigns.nvim")

    ------ Sessions
    -- Automatic sessions
    use({
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup({ auto_session_suppress_dirs = { "~" } })
        end,
    })
    -- Telescope Integration
    use("rmagatti/session-lens")

    ------ LSP
    use("neovim/nvim-lspconfig")
    use("jose-elias-alvarez/null-ls.nvim")

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

    ------ Tests
    use("nvim-neotest/neotest")
    use("nvim-neotest/neotest-python")

    ------ Fuzzy Finder
    use({ "nvim-telescope/telescope.nvim", tag = "0.1.0" })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    ------ Editing
    -- Pairs
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
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

    ------  Autocomplete
    -- Completion sources
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-cmdline")
    -- Snippets Engine
    use("L3MON4D3/LuaSnip")
    -- Integrate snippets with completion
    use("saadparwaiz1/cmp_luasnip")
    -- Integrate DAP with completion
    use("rcarriga/cmp-dap")
    -- Completion Engine
    use("hrsh7th/nvim-cmp")

    ------ Language Specific
    ------ LaTeX
    use("lervag/vimtex")
    -- Snippets
    use("brennier/quicktex")
    ------ Java
    use("mfussenegger/nvim-jdtls")
    ------ Norg
    use("nvim-neorg/neorg")
    ------ Lua
    use({
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup()
        end,
    })

    ------- Vimscript
    use("tpope/vim-dispatch")
    use("tpope/vim-fugitive")
    -- Jupyter
    use("luk400/vim-jukit")

    ------ Libraries
    -- Neorg, Neotest, null-ls, ...
    use("nvim-lua/plenary.nvim")
    -- Noice
    use("MunifTanjim/nui.nvim")

    ------ Eye candy
    -- Icons
    use("nvim-tree/nvim-web-devicons")
    -- UI
    use("folke/noice.nvim")
    -- Notifications
    use("rcarriga/nvim-notify")
    -- Indent Guides
    use("lukas-reineke/indent-blankline.nvim")
    -- Highlight word under the cursor
    use({
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({ providers = { "lsp" } })
        end,
    })
end)
