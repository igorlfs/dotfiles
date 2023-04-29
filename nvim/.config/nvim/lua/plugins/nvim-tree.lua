local status, nvim_tree = pcall(require, "nvim-tree")

if not status then
    vim.notify("nvim-tree not found")
    return
end

nvim_tree.setup({
    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = false,
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    view = {
        adaptive_size = true,
    },
})

-- Keymaps
local keymap = vim.keymap.set
keymap("n", "<leader>v", "<cmd>NvimTreeToggle<CR>")

-- fix nvim-dapui's split sizes, see nvim-dap-ui#175
local api = require("nvim-tree.api")
local Event = api.events.Event
api.events.subscribe(Event.TreeClose, function()
    local dap_status, dap = pcall(require, "dap")
    local dap_ui_status, dapui = pcall(require, "dapui")
    if dap_status and dap_ui_status then
        if dap.session() then
            dapui.open({ reset = true })
        end
    end
end)
