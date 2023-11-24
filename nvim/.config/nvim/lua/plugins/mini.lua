return {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local indentscope = require("mini.indentscope")
        indentscope.setup({
            symbol = "│",
            draw = {
                delay = 0,
                animation = indentscope.gen_animation.none(),
            },
            options = {
                try_as_border = true,
            },
        })
    end,
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "help",
                "lazy",
                "noice",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
            callback = function() vim.b.miniindentscope_disable = true end,
        })
        vim.api.nvim_create_autocmd("Termopen", {
            pattern = { "*" },
            callback = function() vim.b.miniindentscope_disable = true end,
        })
    end,
}
