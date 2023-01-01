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

    -- Highlighting
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    -- Colorscheme
    use({ "catppuccin/nvim", as = "catppuccin", run = ":CatppuccinCompile" })
    -- Explorer
    use("nvim-tree/nvim-tree.lua")
    -- Terminal
    use("akinsho/toggleterm.nvim")

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

    ------ Git
    use("lewis6991/gitsigns.nvim")
    use({
        "TimUntersberger/neogit",
        config = function()
            require("neogit").setup({
                disable_commit_confirmation = true,
            })
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
    -- Snippets Collection
    use("rafamadriz/friendly-snippets")
    -- Integrate snippets with completion
    use("saadparwaiz1/cmp_luasnip")
    -- Integrate DAP with completion
    use("rcarriga/cmp-dap")
    -- Completion Engine
    use("hrsh7th/nvim-cmp")

    ------ Language Specific
    -- LaTeX
    use("lervag/vimtex")
    -- Jupyter
    use("luk400/vim-jukit")
    -- Java
    use("mfussenegger/nvim-jdtls")
    -- Norg
    use({
        "nvim-neorg/neorg",
        run = ":Neorg sync-parsers",
    })
    -- Lua
    use({
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup()
        end,
    })

    ------- Vimscript
    use("tpope/vim-dispatch")

    ------ Libraries
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

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require("packer").sync()
    end
end)
