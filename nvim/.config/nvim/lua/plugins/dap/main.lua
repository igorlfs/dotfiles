local dap_status, dap = pcall(require, "dap")

if not dap_status then
    vim.notify("dap not found")
    return
end

-- signs
local sign = vim.fn.sign_define
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

-- utils
-- (Re-)reads launch.json if present
local startOrContinue = function()
    if vim.fn.filereadable(".vscode/launch.json") then
        require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
    end
    dap.continue()
end

-- keymaps
local keymap = vim.keymap.set
keymap("n", "<F4>", dap.terminate)
keymap("n", "<F5>", startOrContinue)
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
