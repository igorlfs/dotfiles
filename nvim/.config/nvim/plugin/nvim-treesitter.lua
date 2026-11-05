local api = vim.api

api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        if name == "nvim-treesitter" and kind == "update" then
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    { src = require("igorlfs.util").gh("nvim-treesitter/nvim-treesitter") },
})

api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
        ---@diagnostic disable-next-line: inject-field
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

vim.treesitter.language.register("kulala_http", "http")
