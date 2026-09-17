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

api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
        require("nvim-treesitter.parsers").kulala_http = {
            install_info = {
                url = "https://github.com/mistweaverco/tree-sitter-kulala-http",
                generate = false,
                generate_from_json = false,
                queries = "queries/kulala_http",
            },
        }
    end,
})

api.nvim_set_hl(0, "@query_param.name.kulala_http", { link = "@parameter" })
api.nvim_set_hl(0, "@query_param.value.kulala_http", { link = "String" })

vim.treesitter.language.register("kulala_http", "http")
