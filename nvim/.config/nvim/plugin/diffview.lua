local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("dlyongemallo/diffview.nvim") },
})

util.keymap("<leader>vo", "<CMD>DiffviewOpen<CR>", "Diff Head")
util.keymap("<leader>vc", "<CMD>DiffviewFileHistory %<CR>", "Diff Current File")

local actions = require("diffview.actions")

local panel_keys = {
    { "n", "q", actions.close },
    { "n", "]q", actions.select_next_entry },
    { "n", "[q", actions.select_prev_entry },
    { "n", "<leader><leader>", actions.toggle_files },
    -- Must be last
    { "n", "<CR>", actions.select_entry },
}

local view_keys = vim.iter(panel_keys):take(#panel_keys - 1):totable()

require("diffview").setup({
    keymaps = {
        disable_defaults = true,
        view = view_keys,
        file_panel = panel_keys,
        file_history_panel = panel_keys,
    },
})
