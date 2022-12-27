local nt = require("nvim-tree")

-- setup
nt.setup({
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

-- keymaps
local keymap = vim.keymap.set
keymap("n", "<leader>v", nt.toggle)

-- fix nvim-dapui's split sizes, see nvim-dap-ui#175
local api = require("nvim-tree.api")
local Event = api.events.Event
api.events.subscribe(Event.TreeClose, function()
    if require("dap").session() then
        require("dapui").open({ reset = true })
    end
end)
