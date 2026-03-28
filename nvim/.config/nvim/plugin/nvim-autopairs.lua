local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("windwp/nvim-autopairs") },
})

require("nvim-autopairs").setup({ ignored_next_char = "", enable_check_bracket_line = false })
