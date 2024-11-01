return {
    "emmanueltouzery/decisive.nvim",
    ft = "csv",
    keys = {
        {
            "<leader><leader>",
            function() require("decisive").align_csv({}) end,
            desc = "Align CSV",
            ft = "csv",
        },
    },
}
