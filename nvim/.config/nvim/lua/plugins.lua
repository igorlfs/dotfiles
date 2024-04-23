return {
    ------ Miscellaneous
    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        opts = {
            direction = "float",
            float_opts = { border = "rounded" },
        },
        keys = { { "<A-t>", "<CMD>ToggleTerm<CR>", desc = "Toggle Terminal", mode = { "n", "t" } } },
    },
    -- Sessions
    {
        "jedrzejboczar/possession.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            autosave = {
                current = true,
            },
        },
        keys = { { "<leader>fs", "<CMD>Telescope possession list<CR>", desc = "[F]ind [S]essions" } },
        cmd = { "PossessionSave" },
    },
    ------ Package Manager
    -- Language servers, debug adapters, linters and formatters
    {
        "williamboman/mason.nvim",
        opts = { ui = { border = "rounded" } },
        cmd = "Mason",
    },
    -- Lua Modules
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },

    ------ LSP Extensions
    -- textDocument/documentColor
    {
        "brenoprata10/nvim-highlight-colors",
        opts = { render = "virtual" },
    },
    -- textDocument/documentHighlight
    {
        "RRethy/vim-illuminate",
        event = "LspAttach",
        config = function() require("illuminate").configure({ providers = { "lsp" } }) end,
    },
    -- workspace/willRename
    {
        "antosha417/nvim-lsp-file-operations",
        event = "LspAttach",
        dependencies = { "nvim-tree/nvim-tree.lua", "nvim-lua/plenary.nvim" },
        config = true,
    },
    -- textDocument/onTypeFormatting
    { "yioneko/nvim-type-fmt" },

    ------ DAP Extensions
    -- Virtual Text Variables
    {
        "theHamsta/nvim-dap-virtual-text",
        opts = { enabled = false },
        cmd = "DapVirtualTextToggle",
    },
    -- Python
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local debugpy_python_path = require("mason-registry").get_package("debugpy"):get_install_path()
                .. "/venv/bin/python3"
            require("dap-python").setup(debugpy_python_path)
        end,
    },

    ------ VCS
    {
        "NeogitOrg/neogit",
        branch = "nightly",
        dependencies = {
            { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "Neogit",
        config = true,
    },
    -- GitHub
    {
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "Octo",
        config = true,
    },

    ------ Editing
    -- Pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { check_ts = true, ignored_next_char = "" },
    },
    -- Surround
    { "kylechui/nvim-surround", event = "VeryLazy", config = true },
    -- -- Comments
    { "numToStr/Comment.nvim", config = true },
    -- Indentation
    { "nmac427/guess-indent.nvim", config = true },
    -- (f-)Strings
    {
        "axelvc/template-string.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true,
    },

    ------ Eye Candy
    -- Code Context
    {
        "SmiteshP/nvim-navic",
        event = "VeryLazy",
        opts = { lsp = { auto_attach = true }, highlight = true },
    },
    -- UI
    { "stevearc/dressing.nvim", event = "VeryLazy", config = true },
    -- Indent Guides
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = "ibl",
        opts = { scope = { enabled = false } },
    },

    ------ Language Extensions
    -- Rust
    { "mrcjkb/rustaceanvim", ft = "rust" },
    -- Python
    {
        "linux-cultist/venv-selector.nvim",
        cmd = { "VenvSelect", "VenvSelectCached" },
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim",
        },
        config = true,
    },
    -- Preview Markdown
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
        ft = "markdown",
    },
    -- CSV
    {
        "cameron-wags/rainbow_csv.nvim",
        config = true,
        ft = { "csv", "tsv" },
        init = function()
            -- Avoid updating the statusline value
            vim.g.disable_rainbow_statusline = 1
        end,
    },
    -- Neorg
    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim" },
        ft = "norg",
        config = true,
    },
}
