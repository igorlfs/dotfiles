return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
        attach_to_untracked = true,
        preview_config = {
            border = "rounded",
        },
        on_attach = function()
            local gitsigns = require("gitsigns")
            local keymap = vim.keymap.set

            -- Navigation
            keymap("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, { desc = "Goto next hunk" })

            keymap("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, { desc = "Goto prev hunk" })

            -- Actions
            keymap("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Hunk Stage" })
            keymap("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Hunk Reset" })
            keymap("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Hunk Preview" })
            keymap("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Hunk Inline Preview" })
            keymap("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Hunk Undo Stage" })
            keymap("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Hunk Blame" })
            keymap(
                "v",
                "<leader>hs",
                function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                { desc = "Stage selection" }
            )
            keymap(
                "v",
                "<leader>hr",
                function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                { desc = "Reset selection" }
            )
            keymap("n", "<leader>bs", gitsigns.stage_buffer, { desc = "Buffer Stage" })
            keymap("n", "<leader>br", gitsigns.reset_buffer, { desc = "Buffer Reset" })
            keymap("n", "<A-b>", gitsigns.toggle_current_line_blame, { desc = "Toggle Blame" })
            keymap("n", "<A-d>", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })

            -- Text object
            keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
    },
}
