return {
    "hat0uma/csvview.nvim",
    config = true,
    ft = "csv",
    keys = {
        {
            "<leader><leader>",
            function() require("csvview").toggle(nil, { view = { display_mode = "border" } }) end,
            desc = "Align CSV",
            ft = "csv",
        },
    },
}
