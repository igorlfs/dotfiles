lua<<EOF
-- Function to pick a pid
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

local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = "lldb"
}

local dap = require('dap')
dap.configurations.cpp = {
  {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = "${workspaceFolder}/main",
          --request = "attach",
          --pid = pick_process,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          --args = {"input.txt"},
          args = function()
          return vim.fn.input('Input file: ', vim.fn.getcwd() .. '/', 'file')
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
          runInTerminal = false,
  },
}
dap.configurations.c = dap.configurations.cpp
EOF
tnoremap <Esc> <C-\><C-n>
" Virtual Text
let g:dap_virtual_text = v:true
" Change Breakpoint character " Open PR nvim-dap
sign define DapBreakpoint  text=● texthl=WarningMsg
" UI
lua << EOF
require("dapui").setup()
EOF
" Mappings
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F9> <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <F8> <Cmd>lua require'dap'.run_to_cursor()<CR>
nnoremap <silent> <F7> <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <F6> <Cmd>lua require'dap'.pause()<CR>
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F4> <Cmd>lua require'dap'.disconnect()<CR> :lua require'dap'.stop()<CR>
"nnoremap <silent> <F3> <Cmd>lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
nnoremap <silent> <F3> <Cmd>lua require'dapui'.toggle()<CR>
nnoremap <silent> <F2> <Cmd>lua require'dapui'.eval()<CR>
