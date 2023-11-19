local function isFileTypeOpen(filetype)
    local current_tabpage = vim.api.nvim_get_current_tabpage()
    local windows = vim.api.nvim_tabpage_list_wins(current_tabpage)

    for _, window in ipairs(windows) do
        local buffer = vim.api.nvim_win_get_buf(window)
        local buffer_filetype = vim.api.nvim_get_option_value("filetype", { buf = buffer })

        if buffer_filetype == filetype then
            return true
        end
    end

    return false
end

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "rcarriga/nvim-dap-ui", -- we need this to patch a bug, see below
    },
    keys = {
        { "<A-e>", "<CMD>NvimTreeToggle<CR>", desc = "Toggle Explorer" },
    },
    opts = {
        renderer = {
            highlight_git = true,
            icons = {
                show = {
                    git = false,
                },
            },
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
        },
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
        view = {
            adaptive_size = true,
        },
    },
    config = function(_, opts)
        require("nvim-tree").setup(opts)

        -- Fix nvim-dapui's split sizes, see nvim-dap-ui#175
        local api = require("nvim-tree.api")
        local Event = api.events.Event
        api.events.subscribe(Event.TreeClose, function()
            -- Since we may have dapui hidden, we check if it's open
            -- (instead of checking if the session is active)
            if isFileTypeOpen("dapui_scopes") then
                require("dapui").open({ reset = true })
            end
        end)
    end,
}
