local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("nvim-tree/nvim-web-devicons") },
    { src = util.gh("nvim-tree/nvim-tree.lua") },
})

require("nvim-tree").setup({
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
        util.keymap("<C-s>", api.node.open.horizontal, opts("Horizontal split"))
    end,
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        diagnostic_opts = true,
    },
    view = {
        adaptive_size = true,
        signcolumn = "no",
        preserve_window_proportions = true,
    },
})

util.keymap("<A-e>", "<CMD>NvimTreeFindFileToggle<CR>", "Toggle Explorer Find File")
util.keymap("<A-E>", "<CMD>NvimTreeToggle<CR>", "Toggle Explorer")
