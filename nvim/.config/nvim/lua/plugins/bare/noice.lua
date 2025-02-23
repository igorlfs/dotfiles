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
    },
}
