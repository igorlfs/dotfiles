return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "folke/noice.nvim",
    },
    config = function()
        local telescope = require("telescope")
        telescope.load_extension("noice")

        local actions = require("telescope.actions")
        telescope.setup({
            defaults = {
                sorting_strategy = "ascending",
                path_display = { "filename_first" },
                layout_config = {
                    prompt_position = "top",
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
        telescope.load_extension("fzf")
    end,
    keys = {
        { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find Files" },
        { "<leader>fg", "<CMD>Telescope live_grep<CR>", desc = "Find Grep" },
        { "<leader>fw", "<CMD>Telescope grep_string<CR>", desc = "Find Word" },
        { "<leader>fc", "<CMD>Telescope resume<CR>", desc = "Find Continue" },
        { "<leader>fb", "<CMD>Telescope buffers<CR>", desc = "Find Buffers" },
        { "<leader>fd", "<CMD>Telescope diagnostics<CR>", desc = "Find Diagnostics" },
        { "<leader>fi", "<CMD>Telescope lsp_implementations<CR>", desc = "Find Implementation" },
        { "<leader>ft", "<CMD>Telescope lsp_type_definitions<CR>", desc = "Find Type Definition" },
        { "gd", "<CMD>Telescope lsp_definitions<CR>", desc = "Go to Definition" },
        { "grr", "<CMD>Telescope lsp_references<CR>", desc = "Find References" },
        { "gO", "<CMD>Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
    },
}
