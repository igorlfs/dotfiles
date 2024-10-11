return {
    "echasnovski/mini.ai",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    config = function()
        local ai = require("mini.ai")

        ai.setup({
            n_lines = 500,
            search_method = "cover",
            custom_textobjects = {
                f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                u = ai.gen_spec.function_call(),
                c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
                t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
            },
        })
    end,
}
