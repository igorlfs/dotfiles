local dap_status, dap = pcall(require, "dap")

if not dap_status then
    vim.notify("dap not found")
    return
end

local ui_status, ui = pcall(require, "dapui")

if not ui_status then
    vim.notify("dap-ui not found")
    return
end

ui.setup({
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
keymap("n", "<F2>", ui.eval)
keymap("n", "<F3>", function()
    ui.float_element("breakpoints")
end)

-- use nvim-dap events to open and close the windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
    ui.open({ reset = true })
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    ui.close()
end
