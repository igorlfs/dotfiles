local dap = require 'dap'
dap.adapters.cpptools = {
  type = 'executable',
  command = '/home/user/.local/share/nvim/site/autoload/plugged/vimspector/gadgets/linux/vscode-cpptools/debugAdapters/OpenDebugAD7'
}
local dap = require 'dap'
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "cpptools",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
}
dap.configurations.c = dap.configurations.cpp

---- UI
require("dapui").setup()
