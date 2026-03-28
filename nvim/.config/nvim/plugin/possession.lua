local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("nvim-lua/plenary.nvim") },
    { src = util.gh("jedrzejboczar/possession.nvim") },
})

require("possession").setup({
    autosave = {
        current = true,
        tmp = true,
        tmp_name = "__",
    },
})

util.keymap("<leader>fs", "<CMD>PossessionPick<CR>", "Find Sessions")
