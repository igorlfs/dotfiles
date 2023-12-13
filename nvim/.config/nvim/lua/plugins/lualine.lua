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

        require("lualine").setup({
            options = {
                globalstatus = true,
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "branch" },
                lualine_b = { { "filename", path = 1 } },
                lualine_c = { { "navic", color_correction = "static" } },
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
                        use_mode_colors = true,
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

        -- Lualine does not respect showtabline
        -- See Lualine#1013 and Lualine#1048
        require("lualine").hide({ place = { "tabline" }, unhide = false })
        vim.api.nvim_create_autocmd({ "TabNew", "TabClosed" }, {
            group = vim.api.nvim_create_augroup("lualine_tmp", { clear = true }),
            callback = function()
                if vim.fn.tabpagenr("$") == 1 then
                    require("lualine").hide({ place = { "tabline" }, unhide = false })
                else
                    require("lualine").hide({ place = { "tabline" }, unhide = true })
                end
            end,
        })
    end,
}
