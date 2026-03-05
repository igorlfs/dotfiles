return {
    "esmuellert/codediff.nvim",
    cmd = { "CodeDiff" },
    keys = {
        { "<leader>vo", "<CMD>CodeDiff<CR>", desc = "Diff Head" },
        { "<leader>vc", "<CMD>CodeDiff history %<CR>", desc = "Diff Current File" },
    },
}
