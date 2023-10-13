return {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    lazy = true,
    build = "make install_jsregexp",
    opts = function()
        local types = require("luasnip.util.types")

        return {
            -- Display a cursor-like placeholder in unvisited nodes of the snippet.
            ext_opts = {
                [types.insertNode] = {
                    unvisited = {
                        virt_text = { { "|", "Conceal" } },
                        virt_text_pos = "inline",
                    },
                },
                [types.exitNode] = {
                    unvisited = {
                        virt_text = { { "|", "Conceal" } },
                        virt_text_pos = "inline",
                    },
                },
            },
        }
    end,
    config = function(_, opts)
        require("luasnip").setup(opts)

        -- Load snippets from friendly-snippets
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
