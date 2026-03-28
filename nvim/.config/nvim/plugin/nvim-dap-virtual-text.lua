local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("theHamsta/nvim-dap-virtual-text") },
})

require("nvim-dap-virtual-text").setup({ enabled = false })

util.keymap("<A-v>", "<CMD>DapVirtualTextToggle<CR>", "Toggle DAP Virtual Text")
