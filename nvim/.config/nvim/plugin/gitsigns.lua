local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("lewis6991/gitsigns.nvim") },
})

require("gitsigns").setup({
    gh = true,
    attach_to_untracked = true,
    on_attach = function()
        local gitsigns = require("gitsigns")

        -- Navigation
        util.keymap("]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end, "Goto next hunk")

        util.keymap("[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end, "Goto prev hunk")

        -- Actions
        util.keymap("<leader>hs", gitsigns.stage_hunk, "Hunk Stage")
        util.keymap("<leader>hr", gitsigns.reset_hunk, "Hunk Reset")
        util.keymap("<leader>hp", gitsigns.preview_hunk, "Hunk Preview")
        util.keymap("<leader>hi", gitsigns.preview_hunk_inline, "Hunk Inline Preview")
        util.keymap("<leader>hb", function()
            gitsigns.blame_line({ full = true })
        end, "Hunk Blame")
        util.keymap("<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage selection", "v")
        util.keymap("<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset selection", "v")
        util.keymap("<leader>bs", gitsigns.stage_buffer, "Buffer Stage")
        util.keymap("<leader>br", gitsigns.reset_buffer, "Buffer Reset")
        util.keymap("<A-b>", gitsigns.toggle_current_line_blame, "Toggle Blame")

        -- Text object
        util.keymap("ih", gitsigns.select_hunk, { silent = true }, { "o", "x" })

        -- Refresh statusline to fetch the branch right after attaching
        vim.cmd.redrawstatus()
    end,
})
