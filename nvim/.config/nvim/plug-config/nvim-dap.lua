-- C++ apdater
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = "lldb"
}

-- C++ Config
local dap = require('dap')
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = "${workspaceFolder}/main",
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    -- use 2 args: 
    -- -i flag to indicate input file
    -- actual filename
    args = {"-i", function()
      return vim.fn.input('Input file: ')
    end},
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
    runInTerminal = false,

    -- Instead of launching the program directly, nvim-dap also supports attaching 
    -- to a running process, so you can debug with an external terminal
    --
    -- This is useful when you want to give input step-by-step to a program, 
    -- which is not that great, given that you'll usually just test with an 
    -- input file. However, doing so, requires implementation changes, 
    -- therefore it may have an use case.
    --
    -- See https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#pick-a-process
    -- for the actual function that allows to choose a process
    --request = "attach",
    --pid = pick_process,
  },
}
-- Also use the same configuration for C
dap.configurations.c = dap.configurations.cpp

---- UI
-- The UI does NOT work well with runInTerminal = true
require("dapui").setup()
