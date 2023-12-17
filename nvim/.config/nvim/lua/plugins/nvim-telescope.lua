return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "folke/noice.nvim",
        "jedrzejboczar/possession.nvim",
    },
    config = function()
        local telescope = require("telescope")
        telescope.load_extension("fzf")
        telescope.load_extension("noice")
        telescope.load_extension("possession")

        local actions = require("telescope.actions")
        telescope.setup({
            defaults = {
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                },
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
                            ["<C-BS>"] = actions.delete_buffer,
                        },
                    },
                },
                lsp_references = {
                    show_line = false,
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
        { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find Files" },
        { "<leader>fg", "<CMD>Telescope live_grep<CR>", desc = "Find Grep" },
        { "<leader>fb", "<CMD>Telescope buffers<CR>", desc = "Find Buffers" },
        { "<leader>fd", "<CMD>Telescope diagnostics<CR>", desc = "Find Diagnostics" },
        { "<leader>fi", "<CMD>Telescope lsp_implementations<CR>", desc = "Find Implementation" },
        { "<leader>ft", "<CMD>Telescope lsp_type_definitions<CR>", desc = "Find Type Definition" },
        { "<leader>fr", "<CMD>Telescope lsp_references<CR>", desc = "Find References" },
    },
}
