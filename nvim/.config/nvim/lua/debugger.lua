local dap = require("dap")
local dapui = require("dapui")

-- UI setup
dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.3 },
                { id = "breakpoints", size = 0.2 },
                { id = "watches", size = 0.5 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = { "console" },
            size = 0.25,
            position = "bottom",
        },
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
dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb",
}

-- C++ config
dap.configurations.cpp = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = vim.fn.getcwd(),
        stopOnEntry = false,

        -- Set arguments
        -- args = function()
        --     local args_string = vim.fn.input("Arguments: ")
        --     return vim.split(args_string, " ")
        -- end,

        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        runInTerminal = true,
    },
}

-- clone C++ config to C
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
        name = "Launch file",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
        console = "integratedTerminal", -- Redirect user input, allowing to send input using the console
        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = "/usr/bin/python",
    },
}

    },
}

-- signs
local sign = vim.fn.sign_define
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})


-- keymaps
require("utils")

map("n", "<F2>", dapui.eval)
map("n", "<F4>", dap.terminate)
map("n", "<F5>", dap.continue)
map("n", "<F6>", dap.run_to_cursor)
map("n", "<F7>", function() 
    dap.set_breakpoint(nil,nil,vim.fn.input("Log point message: "))
end)
map("n", "<F8>", function() 
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
map("n", "<F9>", dap.toggle_breakpoint)
map("n", "<F10>", dap.step_over)
map("n", "<F11>", dap.step_into)
map("n", "<F12>", dap.step_out)

-- use nvim-dap events to open and close the windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
