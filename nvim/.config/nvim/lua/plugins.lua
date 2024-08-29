return {
    ------ Miscellaneous
    -- Sessions
    {
        "jedrzejboczar/possession.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        opts = { autosave = { current = true } },
        keys = { { "<leader>fs", "<CMD>Telescope possession list<CR>", desc = "Find Sessions" } },
        cmd = { "PossessionSave" },
        init = function() vim.opt.sessionoptions:remove({ "buffers" }) end,
    },
    -- Package Manager for language servers, debug adapters, linters and formatters
    { "williamboman/mason.nvim", config = true },

    ------ LSP Extensions
    -- textDocument/documentColor
    {
        "brenoprata10/nvim-highlight-colors",
        opts = { enable_short_hex = false, enable_named_colors = false },
    },
    -- textDocument/documentHighlight
    {
        "RRethy/vim-illuminate",
        event = "LspAttach",
        config = function() require("illuminate").configure({ providers = { "lsp" } }) end,
    },
    -- workspace/willRename
    {
        "igorlfs/nvim-lsp-file-operations",
        branch = "fix/31",
        event = "LspAttach",
        dependencies = { "nvim-tree/nvim-tree.lua", "nvim-lua/plenary.nvim" },
        config = true,
    },

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
    -- Indentation
    { "nmac427/guess-indent.nvim", config = true },
    -- Tags
    { "windwp/nvim-ts-autotag", event = "InsertEnter", config = true },
    -- (f-)Strings
    { "axelvc/template-string.nvim", event = "InsertEnter", config = true },

    ------ Eye Candy
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
    -- Lua
    { "folke/lazydev.nvim", ft = "lua", config = true },
    -- JSON
    { "b0o/schemastore.nvim", lazy = true },
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
}
