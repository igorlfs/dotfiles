local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
    -- Hide variable types as C++'s are verbose
    render = { max_type_length = 0 } 
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
        program = vim.fn.getcwd() .. "/binary",
        cwd = vim.fn.getcwd(),
        stopOnEntry = false,

        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,

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

        -- If you use `runInTerminal = true` and resize the terminal window,
        -- lldb-vscode will receive a `SIGWINCH` signal which can cause problems
        -- To avoid that uncomment the following option
        -- See https://github.com/mfussenegger/nvim-dap/issues/236#issuecomment-1066306073
        postRunCommands = { "process handle -p true -s false -n false SIGWINCH" },
    },
}

-- clone C++ config to C
dap.configurations.c = dap.configurations.cpp

-- Python adapter
dap.adapters.python = {
    type = "executable";
    command = "/usr/bin/python3";
    args = { "-m", "debugpy.adapter" };
}

-- Python config
dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = "python"; -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = "launch";
        name = "Launch file";

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}"; -- This configuration will launch the current file if used.
        pythonPath = "/usr/bin/python"
    },
}

-- signs
local sign = vim.fn.sign_define
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
sign("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})


-- keymaps
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

map("n", "<F2>", ":lua require'dapui'.eval()<CR>", opts)
map("n", "<F4>", ":lua require'dap'.terminate()<CR>", opts)
map("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
map("n", "<F7>", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
map("n", "<F8>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
map("n", "<F9>", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
map("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
map("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
map("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)

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
