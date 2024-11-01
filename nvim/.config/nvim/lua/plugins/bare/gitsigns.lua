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
            local keymap = require("util").keymap

            -- Navigation
            keymap("]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, "Goto next hunk")

            keymap("[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, "Goto prev hunk")

            -- Actions
            keymap("<leader>hs", gitsigns.stage_hunk, "Hunk Stage")
            keymap("<leader>hr", gitsigns.reset_hunk, "Hunk Reset")
            keymap("<leader>hp", gitsigns.preview_hunk, "Hunk Preview")
            keymap("<leader>hi", gitsigns.preview_hunk_inline, "Hunk Inline Preview")
            keymap("<leader>hu", gitsigns.undo_stage_hunk, "Hunk Undo Stage")
            keymap("<leader>hb", function() gitsigns.blame_line({ full = true }) end, "Hunk Blame")
            keymap(
                "<leader>hs",
                function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                "Stage selection",
                "v"
            )
            keymap(
                "<leader>hr",
                function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                "Reset selection",
                "v"
            )
            keymap("<leader>bs", gitsigns.stage_buffer, "Buffer Stage")
            keymap("<leader>br", gitsigns.reset_buffer, "Buffer Reset")
            keymap("<A-b>", gitsigns.toggle_current_line_blame, "Toggle Blame")
            keymap("<A-d>", gitsigns.toggle_deleted, "Toggle Deleted")

            -- Text object
            keymap("ih", ":<C-U>Gitsigns select_hunk<CR>", { silent = true }, { "o", "x" })
        end,
    },
}
