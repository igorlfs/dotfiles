local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("esmuellert/codediff.nvim") },
})

util.keymap("<leader>vo", "<CMD>CodeDiff<CR>", "Diff Head")
util.keymap("<leader>vc", "<CMD>CodeDiff history %<CR>", "Diff Current File")
