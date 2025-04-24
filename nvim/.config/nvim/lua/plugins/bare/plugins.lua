return {
    ------ Miscellaneous
    -- Package Manager for language servers, debug adapters, linters and formatters
    { "williamboman/mason.nvim", config = true },

    ------ LSP Extensions
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

    ------ Language Extensions
    -- TypeScript
    { "yioneko/nvim-vtsls" },
    -- Lua
    { "folke/lazydev.nvim", ft = "lua", config = true },
}
