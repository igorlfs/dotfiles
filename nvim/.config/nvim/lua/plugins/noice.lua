require("noice").setup({
    messages = {
        view_search = false, -- disable view for search count messages
    },
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    -- "Classic" command line
    cmdline = {
        view = "cmdline",
    },
    routes = {
        -- Show "recording" messages
        {
            view = "notify",
            filter = { event = "msg_showmode" },
        },
        -- Hide "written" messages
        {
            filter = {
                event = "msg_show",
                kind = "",
                find = "written",
            },
            opts = { skip = true },
        },
    },
})

local keymap = vim.keymap.set

-- clear notifications
keymap("n", "<leader>n", require("notify").dismiss)

-- we use separate mappings so we can centralize the screen in normal mode
-- but we don't want to insert zz in insert mode
keymap("n", "<C-d>", function()
    if not require("noice.lsp").scroll(4) then
        return "<C-d>zz"
    end
end, { silent = true, expr = true })

keymap("i", "<C-d>", function()
    if not require("noice.lsp").scroll(4) then
        return "<C-d>"
    end
end, { silent = true, expr = true })

keymap("n", "<C-u>", function()
    if not require("noice.lsp").scroll( -4) then
        return "<C-u>zz"
    end
end, { silent = true, expr = true })

keymap("i", "<C-u>", function()
    if not require("noice.lsp").scroll( -4) then
        return "<C-u>"
    end
end, { silent = true, expr = true })
