local cmp = require("cmp")
local snippy = require("snippy")

cmp.setup({
    enabled = function()
        -- Enable completion in prompt buffers to use cmp-dap
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
    end,
    snippet = {
        expand = function(args)
            snippy.expand_snippet(args.body)
        end,
    },
    view = {
        entries = { name = "custom", selection_order = "near_cursor" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs( -4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif snippy.can_expand_or_advance() then
                snippy.expand_or_advance()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif snippy.can_jump( -1) then
                snippy.previous()
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
        { name = "snippy" },
        {
            name = "buffer",
            option = {
                keyword_pattern = [[\k\+]],
                -- Enable completion from all visible buffers
                get_bufnrs = function()
                    local bufs = {}
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        bufs[vim.api.nvim_win_get_buf(win)] = true
                    end
                    return vim.tbl_keys(bufs)
                end,
            },
        },
        { name = "crates" },
        { name = "path" },
    }),
    formatting = {
        format = function(_, vim_item)
            -- Limit completion window to 50 characters
            vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
            return vim_item
        end,
    },
})

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer", option = { keyword_pattern = [[\k\+]] } },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        {
            name = "cmdline",
            -- Prevent expanding %, see cmp-cmdline#33
            keyword_pattern = [=[[^[:blank:]%]*]=],
            option = {
                ignore_cmds = { "Man", "!" },
            },
        },
    }),
})

-- DAP Completion
cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
        { name = "dap" },
    },
})
