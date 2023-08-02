return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require("telescope")
        telescope.load_extension("fzf")
        telescope.load_extension("noice")
        telescope.load_extension("possession")

        local actions = require("telescope.actions")
        telescope.setup({
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
                buffers = {
                    mappings = {
                        i = {
                            ["<c-d>"] = actions.delete_buffer,
                        },
                    },
                },
                find_files = {
                    hidden = true,
                },
                live_grep = {
                    additional_args = { "--hidden" },
                },
            },
        })
    end,
    keys = {
        { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "[F]ind [F]iles" },
        { "<leader>fg", "<CMD>Telescope live_grep<CR>", desc = "[F]ind [G]rep" },
        { "<leader>fb", "<CMD>Telescope buffers<CR>", desc = "[F]ind [B]uffers" },
    },
}
