require("lspconfig").tinymist.setup({
    offset_encoding = "utf-8",
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onSave",
    },
})
