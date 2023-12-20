return {
    "folke/noice.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    opts = {
        messages = {
            view_search = false, -- disable view for search count messages
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            hover = {
                silent = true,
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
    },
    keys = {
        {
            "<c-d>",
            function()
                if not require("noice.lsp").scroll(4) then
                    return "<c-d>"
                end
            end,
            silent = true,
            expr = true,
            desc = "Scroll forward",
            mode = { "i", "n", "s" },
        },
        {
            "<c-u>",
            function()
                if not require("noice.lsp").scroll(-4) then
                    return "<c-u>"
                end
            end,
            silent = true,
            expr = true,
            desc = "Scroll backward",
            mode = { "i", "n", "s" },
        },
    },
}
