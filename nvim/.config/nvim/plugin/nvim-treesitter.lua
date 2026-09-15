local api = vim.api

local util = require("igorlfs.util")

api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        if name == "nvim-treesitter" and kind == "update" then
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    { src = util.gh("nvim-treesitter/nvim-treesitter") },
})
