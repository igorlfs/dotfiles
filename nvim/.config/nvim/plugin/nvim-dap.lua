local util = require("igorlfs.util")

local ok, dap = pcall(require, "dap")

if not ok then
    return
end

local switchbuf = "usevisible,usetab,newtab"

dap.defaults.fallback.switchbuf = switchbuf

-- Adapters
dap.adapters.emmylua = { type = "executable", command = "emmylua_dap" }
require("igorlfs.dap.debugpy")
require("igorlfs.dap.js-debug-adapter")

--- Keymaps
util.keymap("[f", dap.up, "DAP Up")
util.keymap("]f", dap.down, "DAP Down")
util.keymap("<F5>", dap.continue, "DAP Continue")
util.keymap("<F7>", dap.focus_frame, "DAP Focus Frame")
util.keymap("<F19>", function()
    dap.defaults.fallback.switchbuf = "uselast"
    dap.focus_frame()
    dap.defaults.fallback.switchbuf = switchbuf
end, "DAP Force Focus Frame")
util.keymap("<F8>", function()
    vim.ui.input({ prompt = "Log point message: " }, function(input)
        dap.set_breakpoint(nil, nil, input)
    end)
end, "Toggle Logpoint")
util.keymap("<F9>", dap.toggle_breakpoint, "Toggle Breakpoint")
util.keymap("<F10>", dap.step_over, "Step Over")
util.keymap("<F11>", dap.step_into, "Step Into")
util.keymap("<F16>", function()
    dap.terminate({ hierarchy = true })
end, "DAP Terminate")
util.keymap("<F18>", dap.run_to_cursor, "Run to Cursor")
util.keymap("<F21>", function()
    vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
        dap.set_breakpoint(input)
    end)
end, "Conditional Breakpoint")
util.keymap("<F23>", dap.step_out, "Step Out")

-- Signs
for _, group in pairs({
    "DapBreakpoint",
    "DapBreakpointCondition",
    "DapBreakpointRejected",
    "DapLogPoint",
}) do
    vim.fn.sign_define(group, { text = "●" })
end
vim.fn.sign_define("DapStopped", { text = "", numhl = "debugPC" })
