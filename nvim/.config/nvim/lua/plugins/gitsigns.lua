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
            keymap("n", "<leader>hs", gs.stage_hunk)
            keymap("n", "<leader>hr", gs.reset_hunk)
            keymap("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
            keymap("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
            keymap("n", "<leader>hS", gs.stage_buffer)
            keymap("n", "<leader>hu", gs.undo_stage_hunk)
            keymap("n", "<leader>hR", gs.reset_buffer)
            keymap("n", "<leader>hp", gs.preview_hunk)
            keymap("n", "<leader>hb", function() gs.blame_line({ full = true }) end)
            keymap("n", "<leader>tb", gs.toggle_current_line_blame)
            keymap("n", "<leader>hd", gs.diffthis)
            keymap("n", "<leader>hD", function() gs.diffthis("~") end)
            keymap("n", "<leader>td", gs.toggle_deleted)

            -- Text object
            keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
    },
}
