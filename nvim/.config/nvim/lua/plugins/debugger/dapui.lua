local dapui = require("dapui")
local dap = require("dap")

-- UI setup
dapui.setup({
    icons = {
        expanded = "▾",
        collapsed = "▸",
        current_frame = "▸",
    },
    windows = {
        indent = 2,
    },
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.3 },
                { id = "breakpoints", size = 0.2 },
                { id = "stacks", size = 0.2 },
                { id = "watches", size = 0.3 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = { "console" },
            size = 0.3,
            position = "bottom",
        },
    },
    controls = {
        enabled = false,
    },
    floating = {
        border = "rounded",
    },
    render = {
        -- Hide variable types as C++'s are verbose
        max_type_length = 0,
    },
})
local keymap = vim.keymap.set
keymap("n", "<leader>e", dapui.eval)

-- use nvim-dap events to open and close the windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end
