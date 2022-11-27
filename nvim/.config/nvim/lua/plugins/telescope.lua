local tl = require("telescope")

tl.setup({
    tl.load_extension("fzy_native"),
    tl.load_extension("noice"),
    tl.load_extension("session-lens"),
    pickers = {
        find_files = {
            hidden = true,
            file_ignore_patterns = { "^.git" },
        },
        live_grep = {
            additional_args = function()
                return { "--hidden" }
            end,
            file_ignore_patterns = { "^.git" },
        },
    },
})

local keymap = vim.keymap.set
local builtin = require("telescope.builtin")

keymap("n", "<leader>ff", builtin.find_files)
keymap("n", "<leader>fg", builtin.live_grep)
keymap("n", "<leader>fb", builtin.buffers)

local session = require("session-lens")
keymap("n", "<leader>fs", session.search_session)

keymap("n", "z=", builtin.spell_suggest)
