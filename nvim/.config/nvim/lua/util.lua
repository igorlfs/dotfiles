local M = {}

-- DAP adapter for C, C++ and Rust
M.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

return M
