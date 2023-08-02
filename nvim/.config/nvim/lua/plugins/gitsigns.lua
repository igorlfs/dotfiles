return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        preview_config = {
            border = "rounded",
        },
        on_attach = function()
            local gs = package.loaded.gitsigns
            local keymap = vim.keymap.set

            -- Navigation
            keymap("n", "]c", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function() gs.next_hunk() end)
                return "<Ignore>"
            end, { expr = true })

            keymap("n", "[c", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function() gs.prev_hunk() end)
                return "<Ignore>"
            end, { expr = true })

            -- Actions
            keymap("n", "<leader>hS", gs.stage_buffer)
            keymap("n", "<leader>hR", gs.reset_buffer)
            keymap("n", "<leader>tb", gs.toggle_current_line_blame)
            keymap("n", "<leader>td", gs.toggle_deleted)
            keymap("n", "<leader>hs", gs.stage_hunk, { desc = "[H]unk [S]tage" })
            keymap("n", "<leader>hr", gs.reset_hunk, { desc = "[H]unk [R]eset" })
            keymap("n", "<leader>hp", gs.preview_hunk, { desc = "[H]unk [P]review" })
            keymap("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[H]unk [U]ndo" })
            keymap("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "[H]unk [B]lame" })
            keymap(
                "v",
                "<leader>hs",
                function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                { desc = "Stage selection" }
            )
            keymap(
                "v",
                "<leader>hr",
                function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                { desc = "Reset selection" }
            )

            -- Text object
            keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
    },
}
