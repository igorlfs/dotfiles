local status, lualine = pcall(require, "lualine")

if not status then
    vim.notify("lualine not found")
    return
end

lualine.setup({
    options = {
        globalstatus = true,
        refresh = {
            statusline = 100,
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "diff" },
        lualine_x = { "diagnostics" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    tabline = {
        lualine_a = {
            {
                "tabs",
                max_length = vim.o.columns, -- Maximum width of tabs component.
                mode = 1, -- 1: Shows tab_name
                fmt = function(_, context)
                    -- Display path to current file, from cwd
                    -- Show + if buffer is modified in tab
                    local buflist = vim.fn.tabpagebuflist(context.tabnr)
                    local winnr = vim.fn.tabpagewinnr(context.tabnr)
                    local bufnr = buflist[winnr]
                    local mod = vim.fn.getbufvar(bufnr, "&mod")

                    local title = require("plugins.util").title(bufnr)

                    return title .. (mod == 1 and " +" or "")
                end,
            },
        },
    },
})
