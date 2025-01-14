return {
    "folke/noice.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
            hover = {
                silent = true,
            },
        },
        views = {
            hover = {
                scrollbar = false,
            },
            popupmenu = {
                scrollbar = false,
            },
        },
        presets = {
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        -- "Classic" command line
        cmdline = {
            view = "cmdline",
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
