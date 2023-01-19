local tl = require("telescope")
local actions = require("telescope.actions")

tl.setup({
    tl.load_extension("fzf"),
    tl.load_extension("noice"),
    tl.load_extension("session-lens"),
    defaults = {
        mappings = {
            i = {
                ["<Tab>"] = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous,
                ["<C-n>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<C-p>"] = actions.toggle_selection + actions.move_selection_better,
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
            file_ignore_patterns = { "^.git", "^build", ".gradle" },
        },
        live_grep = {
            additional_args = function()
                return { "--hidden" }
            end,
            file_ignore_patterns = { "^.git", "^build", ".gradle" },
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
