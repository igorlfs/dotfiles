return {
    "hat0uma/csvview.nvim",
    config = true,
    ft = "csv",
    keys = {
        {
            "<leader><leader>",
            function() require("csvview").toggle() end,
            desc = "Align CSV",
            ft = "csv",
        },
    },
}
