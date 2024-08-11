local ft = { "python" }

return {
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    init = function()
        vim.g.molten_tick_rate = 200
        vim.g.molten_auto_image_popup = true

        -- Output Window
        vim.g.molten_auto_open_output = false
        vim.g.molten_output_win_max_height = 30

        -- Virtual Text
        vim.g.molten_virt_text_output = true
    end,
    keys = {
        { "<leader><leader>", "<CMD>MoltenEvaluateOperator<CR>", desc = "Evaluate Operator", ft = ft },
        { "<leader>mr", "<CMD>MoltenReevaluateCell<CR>", desc = "Re-evaluate cell", ft = ft },
        { "<leader>ml", "<CMD>MoltenEvaluateLine<CR>", desc = "Evaluate Line", ft = ft },
        { "<leader>md", "<CMD>MoltenDelete<CR>", desc = "Delete Cell", ft = ft },
        { "<leader>ms", "<CMD>MoltenDeinit<CR>", desc = "Molten Stop", ft = ft },
        { "<leader>mo", "<CMD>MoltenEnterOutput<CR>", desc = "Show/enter output window", ft = ft },
        { "<leader>mh", "<CMD>MoltenHideOutput<CR>", desc = "Hide output window", ft = ft },
        { "]m", "<CMD>MoltenNext<CR>", desc = "Goto next cell", ft = ft },
        { "[m", "<CMD>MoltenPrev<CR>", desc = "Goto prev cell", ft = ft },
        {
            "<leader><leader>",
            ":<C-u>MoltenEvaluateVisual<CR>",
            desc = "Evaluate visual selection",
            ft = ft,
            mode = { "v" },
        },
    },
}
