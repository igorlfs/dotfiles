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
        return vim.fn.fnamemodify(file, ":.")
    end
end

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
        extensions = { "nvim-tree", "toggleterm" },
        options = {
            globalstatus = true,
            section_separators = { left = "", right = "" },
            component_separators = { left = "|", right = "|" },
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

                        return title(bufnr) .. (mod == 1 and " +" or "")
                    end,
                },
            },
        },
    },
}
