return {
    ------ Miscellaneous
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

    ------ Eye Candy
    -- Rainbow Brackets
    { "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },

    ------ Language Extensions
    -- TypeScript
    { "yioneko/nvim-vtsls", lazy = true },
}
