local function title(bufnr)
    local file = vim.fn.bufname(bufnr)
    local buftype = vim.fn.getbufvar(bufnr, "&buftype")
    local filetype = vim.fn.getbufvar(bufnr, "&filetype")

    if filetype == "checkhealth" then
        return "checkhealth"
    elseif filetype == "TelescopePrompt" then
        return "Telescope"
    elseif filetype == "NvimTree" then
        return "NvimTree"
    elseif buftype == "terminal" then
        local _, mtch = string.match(file, "term:(.*):(%a+)")
        return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ":t")
    elseif file == "" then
        return "[No Name]"
    else
        return vim.fn.fnamemodify(file, ":t")
    end
end

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        local noice = require("noice.api")
        return require("lualine").setup({
            extensions = { "toggleterm" },
            options = {
                globalstatus = true,
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = { { "filename", path = 4 } },
                lualine_x = {
                    {
                        noice.status.mode.get_hl,
                        cond = noice.status.mode.has,
                    },
                    "selectioncount",
                    "diff",
                },
                lualine_y = { "diagnostics" },
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

                            return title(bufnr) .. (mod == 1 and " +" or "")
                        end,
                    },
                },
            },
        })
    end,
}
