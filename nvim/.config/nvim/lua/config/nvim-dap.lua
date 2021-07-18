-- function to choose a process
local dap = require('dap')
local function pick_process()
  local output = vim.fn.system({'ps', 'a'})
  local lines = vim.split(output, '\n')
  local procs = {}
  for _, line in pairs(lines) do
    -- output format
    --    " 107021 pts/4    Ss     0:00 /bin/zsh <args>"
    local parts = vim.fn.split(vim.fn.trim(line), ' \\+')
    local pid = parts[1]
    local name = table.concat({unpack(parts, 5)}, ' ')
    if pid and pid ~= 'PID' then
      pid = tonumber(pid)
      if pid ~= vim.fn.getpid() then
        table.insert(procs, { pid = tonumber(pid), name = name })
      end
    end
  end
  local choices = {'Select process'}
  for i, proc in ipairs(procs) do
    table.insert(choices, string.format("%d: pid=%d name=%s", i, proc.pid, proc.name))
  end
  local choice = vim.fn.inputlist(choices)
  if choice < 1 or choice > #procs then
    return nil
  end
  return procs[choice].pid
end
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
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
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
    --request = "attach",
    --pid = pick_process,
  },
}
-- Also use the same configuration for C
dap.configurations.c = dap.configurations.cpp

---- UI
-- The UI does NOT work well with runInTerminal = true
require("dapui").setup()

---- Virtual Text
-- Prevents SIGWINCH from cluttering the view
require "nvim-dap-virtual-text/virtual_text".set_error = function() end
