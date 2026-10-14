local util = require("igorlfs.util")

local ok, dap = pcall(require, "dap")

if not ok then
    return
end

local api = vim.api
local fn = vim.fn

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
        if input then
            dap.set_breakpoint(nil, nil, input)
        end
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
        if input then
            dap.set_breakpoint(input)
        end
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
    fn.sign_define(group, { text = "●" })
end
fn.sign_define("DapStopped", { text = "", numhl = "debugPC" })

api.nvim_create_autocmd("SessionWritePre", {
    callback = function()
        local breakpoints = {}

        for buf, buf_breakpoints in pairs(require("dap.breakpoints").get()) do
            local fname = api.nvim_buf_get_name(buf)

            for _, breakpoint in ipairs(buf_breakpoints) do
                breakpoints[#breakpoints + 1] = {
                    filename = fname,
                    line = breakpoint.line,
                    condition = breakpoint.condition,
                    log_message = breakpoint.logMessage,
                    hit_condition = breakpoint.hitCondition,
                }
            end
        end

        vim.g.DAP_breakpoints = vim.json.encode(breakpoints)
    end,
})

api.nvim_create_autocmd("SessionLoadPost", {
    callback = function()
        if vim.g.DAP_breakpoints == nil then
            return
        end

        ---@type table<string,integer>
        local bufs_by_name = {}

        for _, buf in ipairs(api.nvim_list_bufs()) do
            local buf_name = api.nvim_buf_get_name(buf)
            bufs_by_name[buf_name] = buf
        end

        ---@type integer[]
        local new_bufs = {}

        for _, breakpoint in ipairs(vim.json.decode(vim.g.DAP_breakpoints) or {}) do
            local buf = bufs_by_name[breakpoint.filename]

            if buf == nil then
                buf = fn.bufadd(breakpoint.filename)
                new_bufs[#new_bufs + 1] = buf
                bufs_by_name[breakpoint.filename] = buf
            end

            if buf and api.nvim_buf_is_valid(buf) then
                require("dap.breakpoints").set(breakpoint, buf, breakpoint.line)
            end
        end

        for _, buf in ipairs(new_bufs) do
            api.nvim_buf_delete(buf)
        end
    end,
})
