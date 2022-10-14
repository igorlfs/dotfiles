local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

require("Comment").setup()

require("catppuccin").setup({
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    integrations = {
        dap = {
            enabled = true,
            enable_ui = true,
        },
    }
})

require("fidget").setup()

require("neorg").setup({
    load = {
        ["core.highlights"] = {
            config = {
                todo_items_match_color = "all",
            },
        },
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
    },
})

require("nvim-autopairs").setup()

require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "comment", "make", "lua", "python", "vim", "norg" },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = { "python" },
    },
})

local null_ls = require("null-ls")
local augroup = ag("LspFormatting", {})
null_ls.setup({
    on_attach = function(client, bufnr)
        -- Autoformat on save
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            au("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
    sources = {
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.todo_comments,
    },
})

require("toggleterm").setup({
    open_mapping = [[<a-p>]],
    direction = "float",
    float_opts = {
        border = "curved",
    },
})
