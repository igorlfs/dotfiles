return {
    ------ Miscellaneous
    -- Library used by many plugins
    { "nvim-lua/plenary.nvim", lazy = true },
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
    -- Developer Tools Package Manager
    {
        "williamboman/mason.nvim",
        opts = { ui = { border = "rounded" } },
        cmd = "Mason",
    },
    -- Quickfix
    { "kevinhwang91/nvim-bqf", ft = "qf" },

    ------ LSP Extensions
    -- textDocument/documentColor
    {
        "uga-rosa/ccc.nvim",
        opts = {
            highlighter = {
                auto_enable = true,
                lsp = true,
            },
        },
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
    -- Goto Breakpoints
    {
        "ofirgall/goto-breakpoints.nvim",
        keys = {
            { "]b", function() require("goto-breakpoints").next() end, desc = "Goto next breakpoint" },
            { "[b", function() require("goto-breakpoints").next() end, desc = "Goto prev breakpoint" },
        },
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
    -- Comments
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
    -- Undo
    {
        "kevinhwang91/nvim-fundo",
        dependencies = "kevinhwang91/promise-async",
        build = function() require("fundo").install() end,
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
    -- LaTeX
    {
        "lervag/vimtex",
        init = function()
            -- Avoid startup warning about Tree-sitter
            -- Prefer Tree-sitter's highlighting as it allows spell checking
            vim.g.vimtex_syntax_enabled = 0
            vim.g.vimtex_syntax_conceal_disable = 1
        end,
    },
    -- Java's JDTLS extensions
    { "mfussenegger/nvim-jdtls", ft = "java" },
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
}
