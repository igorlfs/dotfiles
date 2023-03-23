local dap, dapui = require("dap"), require("dapui")

dapui.setup({
    icons = {
        expanded = "",
        collapsed = "",
        current_frame = "",
    },
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.5 },
                { id = "watches", size = 0.5 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = { "console" },
            position = "bottom",
            size = 15,
        },
    },
    controls = {
        enabled = false,
    },
    floating = {
        border = "rounded",
    },
    render = {
        indent = 2,
        -- Hide variable types as C++'s are verbose
        max_type_length = 0,
    },
})

local keymap = vim.keymap.set
keymap("n", "<F2>", dapui.eval)
keymap("n", "<F3>", function()
    dapui.float_element("breakpoints")
end)

-- use nvim-dap events to open and close the windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
    vim.api.nvim_command("tabnew %")
    dapui.open({ reset = true })
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
    vim.api.nvim_command("tabclose $")
end
