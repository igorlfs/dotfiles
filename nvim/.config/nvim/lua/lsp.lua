local lspconfig = require("lspconfig")

vim.diagnostic.open_float({ width = 80 })

require("utils")

-- Diagnostic keymaps
map("n", "<space>e", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>q", vim.diagnostic.setloclist)

-- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

    map("n", "gD", vim.lsp.buf.declaration)
    map("n", "gd", vim.lsp.buf.definition)
    map("n", "K", vim.lsp.buf.hover)
    map("n", "gi", vim.lsp.buf.implementation)
    map({"n", "i"}, "<C-k>", vim.lsp.buf.signature_help)
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
    map("n", "<leader>wl", function()
        vim.inspect(vim.lsp.buf.list_workspace_folders())
    end)
    map("n", "<leader>D", vim.lsp.buf.type_definition)
    map("n", "<leader>rn", vim.lsp.buf.rename)
    map("n", "gr", vim.lsp.buf.references)
    map("n", "<leader>ca", vim.lsp.buf.code_action)

    if client.server_capabilities.documentFormattingProvider then
        vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
        ]])
    end

    if client.server_capabilities.documentHighlightProvider then
        vim.cmd([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                autocmd BufLeave * lua vim.lsp.buf.clear_references()
            augroup END
        ]])
    end
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Enable borders
local handlers =  {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "clangd", "pylsp", "texlab", "tsserver", "eslint" }
for _, lsp in ipairs(servers) do
    require("lspconfig")[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        handlers = handlers,
    })
end

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    window = {
        documentation = cmp.config.window.bordered(),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer", option = { keyword_pattern = [[\k\+]] } },
        { name = "path" },
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
            return vim_item
        end
    }
})

-- cmp-cmdline setup
cmp.setup.cmdline(":", {
    sources = {
        { name = "cmdline" },
    }, 
    mapping = cmp.mapping.preset.cmdline()
})
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer", option = { keyword_pattern = [[\k\+]] } },
    },
    mapping = cmp.mapping.preset.cmdline()
})
cmp.setup.cmdline("?", {
    sources = {
        { name = "buffer", option = { keyword_pattern = [[\k\+]] } },
    },
    mapping = cmp.mapping.preset.cmdline()
})

-- nvim-autopairs setup
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
