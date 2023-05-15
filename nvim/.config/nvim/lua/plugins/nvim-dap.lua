local dap_status, dap = pcall(require, "dap")
local ui_status, ui = pcall(require, "dapui")

if not dap_status then
    vim.notify("dap not found")
    return
end

if not ui_status then
    vim.notify("dap-ui not found")
    return
end

-- Adapters
-- C, C++
dap.adapters.codelldb = require("plugins.util").codelldb
-- JS, TS
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
    },
}

-- Signs
local sign = vim.fn.sign_define
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

-- Keymaps
local keymap = vim.keymap.set
keymap("n", "<F2>", ui.eval)
keymap("n", "<F3>", function()
    ui.float_element("breakpoints")
end)

keymap("n", "<F4>", dap.terminate)
keymap("n", "<F5>", require("plugins.util").start_or_continue_dap)
keymap("n", "<F6>", dap.run_to_cursor)
keymap("n", "<F7>", function()
    dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
keymap("n", "<F8>", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
keymap("n", "<F9>", dap.toggle_breakpoint)
keymap("n", "<F10>", dap.step_over)
keymap("n", "<F11>", dap.step_into)
keymap("n", "<F12>", dap.step_out)

-- UI
ui.setup({
    icons = {
        expanded = "󰅀",
        collapsed = "󰅂",
        current_frame = "󰅂",
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
            elements = { "console", "repl" },
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

-- use nvim-dap events to open and close the windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
    ui.open({ reset = true })
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    ui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    ui.close()
end
