local M = {}

local dap_status, dap = pcall(require, "dap")

if not dap_status then
    vim.notify("dap not found")
    return
end

-- C, C++ and Rust adapter
-- Export it so it can be used with rust-tools
M.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

dap.adapters.codelldb = M.codelldb

-- JS and TS adapter
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
    },
}

return M
