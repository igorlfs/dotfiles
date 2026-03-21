return {
    ------ DAP Extensions
    -- Virtual Text Variables
    {
        "theHamsta/nvim-dap-virtual-text",
        opts = { enabled = false },
        keys = { { "<A-v>", "<CMD>DapVirtualTextToggle<CR>", desc = "Toggle DAP Virtual Text" } },
    },
}
