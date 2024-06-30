return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "rcarriga/cmp-dap",
    },
    opts = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        return {
            enabled = function()
                -- Enable completion in prompt buffers to use cmp-dap
                return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
                    or require("cmp_dap").is_dap_buffer()
            end,
            snippet = {
                expand = function(args) luasnip.lsp_expand(args.body) end,
            },
            preselect = cmp.PreselectMode.None,
            view = {
                entries = { name = "custom", selection_order = "near_cursor" },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({
                    select = false,
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    -- Prefer jumping if both jumping and expanding are available
                    -- Otherwise, you may recursively expand a snippet without ever jumping
                    -- (which is annoying)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.jumpable(1) then
                        luasnip.jump(1)
                    elseif luasnip.expandable() then
                        luasnip.expand()
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
                { name = "path" },
            }),
            formatting = {
                format = function(_, item)
                    -- Limit completion window to 50 characters
                    item.abbr = string.sub(item.abbr, 1, 50)
                    return item
                end,
            },
            experimental = {
                ghost_text = {
                    hl_group = "LspCodeLens",
                },
            },
        }
    end,
    config = function(_, opts)
        local cmp = require("cmp")
        cmp.setup(opts)

        -- oddly, it appears that using cmp-cmdline prevents this issue with diffview which is caused by noice
        -- https://github.com/sindrets/diffview.nvim/issues/302
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
                },
            }),
        })

        -- DAP Completion
        cmp.setup.filetype({ "dapui_watches", "dapui_hover", "dap-repl" }, {
            sources = {
                { name = "dap" },
            },
        })
    end,
}
