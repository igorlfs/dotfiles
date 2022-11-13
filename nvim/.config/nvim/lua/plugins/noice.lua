require("noice").setup({
    messages = {
        view_search = false, -- disable virtualtext  with search count
    },
    lsp = {
        override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = true,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
    },
})
