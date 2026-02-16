return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
        { "<A-e>", "<CMD>NvimTreeFindFileToggle<CR>", desc = "Toggle Find File" },
        { "<A-E>", "<CMD>NvimTreeToggle<CR>", desc = "Toggle Explorer" },
    },
    opts = {
        git = {
            enable = false,
        },
        renderer = {
            icons = {
                show = {
                    git = false,
                },
            },
        },
        sync_root_with_cwd = true,
        on_attach = function(bufnr)
            local api = require("nvim-tree.api")

            ---@param desc string
            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, silent = true, nowait = true }
            end

            -- default mappings
            api.map.on_attach.default(bufnr)

            -- custom mappings
            vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Horizontal split"))
        end,
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            diagnostic_opts = true,
        },
        view = {
            adaptive_size = true,
            preserve_window_proportions = true,
        },
    },
}
