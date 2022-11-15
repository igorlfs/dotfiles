local dap = require("dap")
local dapui = require("dapui")

-- UI setup
dapui.setup({
    icons = {
        expanded = "▾",
        collapsed = "▸",
        current_frame = "▸",
    },
    windows = {
        indent = 2,
    },
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.3 },
                { id = "breakpoints", size = 0.2 },
                { id = "stacks", size = 0.2 },
                { id = "watches", size = 0.3 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = { "console" },
            size = 0.3,
            position = "bottom",
        },
    },
    controls = {
        enabled = false,
    },
    floating = {
        border = "rounded",
    },
    render = {
        -- Hide variable types as C++'s are verbose
        max_type_length = 0,
    },
})

-- C++ adapter
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

-- C++ config
dap.configurations.cpp = {
    {
        name = "Launch CodeLLDB",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = vim.fn.getcwd(),
        showDisassembly = "never", -- Disables assembly when source code isn't found
        expressions = "native", -- Allows evaluating expressions such as "this"

        -- Set arguments
        -- args = function()
        --     local args_string = vim.fn.input("Arguments: ")
        --     return vim.split(args_string, " ")
        -- end,
    },
}

-- Clone C++ config to C
dap.configurations.c = dap.configurations.cpp

-- Python adapter
dap.adapters.python = {
    type = "executable",
    command = "/usr/bin/python3",
    args = { "-m", "debugpy.adapter" },
}

-- Python config
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
        -- This configuration will launch the current file if used.
        type = "python",
        request = "launch",
        name = "File",
        console = "integratedTerminal",
        program = "${file}",
        cwd = "${workspaceFolder}",
        pythonPath = "/usr/bin/python",
    },
}

-- signs
local sign = vim.fn.sign_define
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

-- keymaps
local keymap = vim.keymap.set
keymap("n", "<F2>", dapui.eval)
keymap("n", "<F4>", dap.terminate)
keymap("n", "<F5>", dap.continue)
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

-- use nvim-dap events to open and close the windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end
