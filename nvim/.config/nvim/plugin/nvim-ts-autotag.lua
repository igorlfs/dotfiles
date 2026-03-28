local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("windwp/nvim-ts-autotag") },
})

require("nvim-ts-autotag").setup()
