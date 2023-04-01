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

dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = "launch",
        name = "Module",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
        console = "integratedTerminal", -- Redirect user input, allowing to send input using the console
        module = function()
            return vim.fn.input("Module: ")
        end,
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
        cwd = "${workspaceFolder}",
        pythonPath = "/usr/bin/python",
    },
    {
        -- This configuration will launch the current file
        type = "python",
        request = "launch",
        name = "File",
        console = "integratedTerminal",
        program = "${file}",
        cwd = "${workspaceFolder}",
        pythonPath = "/usr/bin/python",
    },
}

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
