local dap_status, dap = pcall(require, "dap")

if not dap_status then
    vim.notify("dap not found")
    return
end

dap.configurations.cpp = {
    {
        name = "Launch CodeLLDB",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        expressions = "native", -- Allows evaluating expressions such as "this"
    },
}
dap.configurations.c = dap.configurations.cpp

dap.configurations.javascript = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch JS-Debug",
        program = "${file}",
        cwd = "${workspaceFolder}",
    },
}

dap.configurations.typescript = {
    {
        -- Config options
        -- https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
        type = "pwa-node",
        request = "launch",
        name = "Launch JS-Debug",
        runtimeArgs = { "--loader", "ts-node/esm" },
        args = { "${file}" },
        console = "integratedTerminal",
        skipFiles = { "<node_internals>/**", "**/node_modules/**" },
        resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
        },
    },
}
