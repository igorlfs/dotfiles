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
    elseif filetype == "qf" then
        return "QuickFix"
    elseif buftype == "terminal" then
        return "Terminal"
    elseif file == "" then
        return "[No Name]"
    else
        return vim.fn.fnamemodify(file, ":t")
    end
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/noice.nvim" },
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
                lualine_c = { { "filename", path = 1 } },
                lualine_x = {
                    {
                        noice.status.mode.get_hl,
                        cond = noice.status.mode.has,
                    },
                    "diff",
                },
                lualine_y = { "diagnostics" },
                lualine_z = { "selectioncount" },
            },
            tabline = {
                lualine_a = {
                    {
                        "tabs",
                        max_length = vim.o.columns,
                        mode = 1,
                        show_modified_status = false,
                        fmt = function(_, context)
                            local buflist = vim.fn.tabpagebuflist(context.tabnr)
                            local winnr = vim.fn.tabpagewinnr(context.tabnr)
                            local bufnr = buflist[winnr]
                            local mod = vim.fn.getbufvar(bufnr, "&mod")

                            return title(bufnr) .. (mod == 1 and " ●" or "")
                        end,
                    },
                },
            },
        })
    end,
}
