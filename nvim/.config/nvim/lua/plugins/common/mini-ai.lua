return {
    "nvim-mini/mini.ai",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    config = function()
        local ai = require("mini.ai")

        ai.setup({
            n_lines = 500,
            search_method = "cover",
            -- Avoid conflicts with built-in LSP mappings for incremental selection
            -- See https://github.com/echasnovski/mini.nvim/discussions/1887
            mappings = {
                around_next = "a.",
                inside_next = "i.",
                around_last = "a,",
                inside_last = "i,",
            },
            custom_textobjects = {
                f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                u = ai.gen_spec.function_call(),
                c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
            },
        })
    end,
}
