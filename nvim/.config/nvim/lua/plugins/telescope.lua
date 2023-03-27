local tl = require("telescope")
local actions = require("telescope.actions")

tl.setup({
    tl.load_extension("fzf"),
    tl.load_extension("noice"),
    defaults = {
        file_ignore_patterns = {
            "^.git/*",
            "node_modules/*",
            ".mypy_cache/*",
        },
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
        },
        live_grep = {
            additional_args = function()
                return { "--hidden" }
            end,
        },
    },
})

local keymap = vim.keymap.set
local builtin = require("telescope.builtin")

keymap("n", "<leader>ff", builtin.find_files)
keymap("n", "<leader>fg", builtin.live_grep)
keymap("n", "<leader>fb", builtin.buffers)

keymap("n", "<leader>fs", "<cmd>Telescope persisted<CR>")
