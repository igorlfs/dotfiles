return {
    ------ Miscellaneous
    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        opts = { direction = "float", float_opts = { border = "rounded" } },
        keys = { { "<A-t>", "<CMD>ToggleTerm<CR>", desc = "Toggle Terminal", mode = { "n", "t" } } },
    },
    -- Sessions
    {
        "jedrzejboczar/possession.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        opts = { autosave = { current = true } },
        keys = { { "<leader>fs", "<CMD>Telescope possession list<CR>", desc = "Find Sessions" } },
        cmd = { "PossessionSave" },
    },
    -- Package Manager for language servers, debug adapters, linters and formatters
    { "williamboman/mason.nvim", opts = { ui = { border = "rounded" } }, cmd = "Mason" },

    ------ LSP Extensions
    -- textDocument/documentColor
    { "brenoprata10/nvim-highlight-colors", opts = { enable_short_hex = false } },
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
        keys = { { "<A-v>", "<CMD>DapVirtualTextToggle<CR>", desc = "Toggle DAP Virtual Text" } },
    },

    ------ Editing
    -- Pairs
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = { ignored_next_char = "" } },
    -- Surround
    { "kylechui/nvim-surround", event = "VeryLazy", config = true },
    -- Comments
    { "numToStr/Comment.nvim", config = true },
    -- Indentation
    { "nmac427/guess-indent.nvim", config = true },
    -- Tags
    { "windwp/nvim-ts-autotag", event = "InsertEnter", config = true },
    -- (f-)Strings
    { "axelvc/template-string.nvim", event = "InsertEnter", config = true },

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
        opts = {
            scope = { enabled = false },
            exclude = { filetypes = { "csv" } },
        },
    },

    ------ Language Extensions
    -- Rust
    {
        "mrcjkb/rustaceanvim",
        ft = "rust",
        init = function()
            vim.g.rustaceanvim = {
                tools = { float_win_config = { border = "rounded" } },
            }
        end,
    },
    -- Preview Markdown
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
        ft = "markdown",
    },
    -- CSV
    { "cameron-wags/rainbow_csv.nvim", config = true },
}
