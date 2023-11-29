return {
    "benlubas/molten-nvim",
    dependencies = "3rd/image.nvim",
    build = ":UpdateRemotePlugins",
    ft = { "python", "julia" },
    init = function()
        vim.g.molten_image_provider = "image.nvim"

        -- Output Window
        vim.g.molten_auto_open_output = false
        vim.g.molten_output_win_max_height = 30

        -- Virtual Text
        vim.g.molten_virt_text_output = true
    end,
    config = function()
        local keymap = vim.keymap.set
        keymap("n", "<localleader>e", "<CMD>MoltenEvaluateOperator<CR>", { desc = "Evaluate Operator" })
        keymap("n", "<localleader>l", "<CMD>MoltenEvaluateLine<CR>", { desc = "Evaluate Line" })
        keymap("n", "<localleader>r", "<CMD>MoltenReevaluateCell<CR>", { desc = "Re-evaluate cell" })
        keymap("n", "<localleader>d", "<CMD>MoltenDelete<CR>", { desc = "Delete cell" })
        keymap("n", "<localleader>s", "<CMD>MoltenEnterOutput<CR>", { desc = "Show/enter output window" })
        keymap("n", "<localleader>h", "<CMD>MoltenHideOutput<CR>", { desc = "Hide output window" })
        keymap("n", "]q", "<CMD>MoltenNext<CR>", { desc = "Goto next cell" })
        keymap("n", "[q", "<CMD>MoltenPrev<CR>", { desc = "Goto prev cell" })
        keymap("v", "<localleader>e", ":<C-u>MoltenEvaluateVisual<CR>", { desc = "Evaluate visual selection" })
    end,
}
