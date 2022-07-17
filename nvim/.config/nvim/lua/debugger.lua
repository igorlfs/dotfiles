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
            size = 0.3,
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
dap.adapters.codelldb = function(on_adapter)
    -- This asks the system for a free port
    local tcp = vim.loop.new_tcp()
    tcp:bind("127.0.0.1", 0)
    local port = tcp:getsockname().port
    tcp:shutdown()
    tcp:close()

    -- Start codelldb with the port
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    local opts = {
        stdio = {nil, stdout, stderr},
        args = {"--port", tostring(port)},
    }
    local handle
    local pid_or_err
    handle, pid_or_err = vim.loop.spawn("codelldb", opts, function(code)
        stdout:close()
        stderr:close()
        handle:close()
        if code ~= 0 then
            print("codelldb exited with code", code)
        end
    end)
    if not handle then
        vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
        stdout:close()
        stderr:close()
        return
    end
    vim.notify("codelldb started. pid=" .. pid_or_err)
    stderr:read_start(function(err, chunk)
        assert(not err, err)
        if chunk then
            vim.schedule(function()
                require("dap.repl").append(chunk)
            end)
        end
    end)
    local adapter = {
        type = "server",
        host = "127.0.0.1",
        port = port
    }
    -- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
    -- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
    vim.defer_fn(function() on_adapter(adapter) end, 500)
end

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
