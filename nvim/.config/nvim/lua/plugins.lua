return {
    ------ Miscellaneous
    -- Library used by many plugins
    { "nvim-lua/plenary.nvim" },
    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        opts = {
            open_mapping = [[<a-p>]],
            direction = "float",
            float_opts = {
                border = "rounded",
            },
        },
        keys = {
            { "<a-p>", "<CMD>ToggleTerm<CR>", desc = "Toggle Float Term" },
        },
    },
    -- Sessions
    {
        "jedrzejboczar/possession.nvim",
        opts = {
            autosave = {
                current = true,
            },
        },
        lazy = false,
        keys = { { "<leader>fs", "<CMD>Telescope possession list<CR>", desc = "Search Sessions" } },
    },
    -- Developer Tools Package Manager
    {
        "williamboman/mason.nvim",
        dependencies = "williamboman/mason-lspconfig.nvim",
        opts = { ui = { border = "rounded" } },
    },

    ------ LSP Extensions
    -- textDocument/formatting (async)
    {
        "lukas-reineke/lsp-format.nvim",
        event = { "LspAttach" },
        opts = {
            exclude = "lua_ls",
        },
    },
    -- textDocument/documentColor
    {
        "uga-rosa/ccc.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            highlighter = {
                auto_enable = true,
                lsp = true,
            },
        },
    },
    -- textDocument/documentHighlight
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        config = function() require("illuminate").configure({ providers = { "lsp" } }) end,
    },

    ------ VCS
    {
        "TimUntersberger/neogit",
        dependencies = {
            "sindrets/diffview.nvim",
            cmd = "DiffviewOpen",
        },
        cmd = "Neogit",
        opts = {
            disable_commit_confirmation = true,
            integrations = {
                diffview = true,
            },
        },
    },
    -- Github
    {
        "pwntester/octo.nvim",
        cmd = "Octo",
        opts = {
            use_local_fs = true,
            mappings = {
                review_diff = {
                    add_review_comment = { lhs = "<space>ac", desc = "add a new review comment" },
                    add_review_suggestion = { lhs = "<space>as", desc = "add a new review suggestion" },
                },
            },
        },
    },

    ------ Editing
    -- Pairs
    { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
    -- Tags
    { "windwp/nvim-ts-autotag", config = true },
    -- Surround
    { "kylechui/nvim-surround", event = { "BufReadPost", "BufNewFile" }, config = true },
    -- Comments
    { "numToStr/Comment.nvim", event = { "BufReadPost", "BufNewFile" }, config = true },
    -- Snippets
    { "honza/vim-snippets" },
    -- Update Indent settings according to file
    { "nmac427/guess-indent.nvim", config = true },

    ------ Eye Candy
    -- UI
    { "stevearc/dressing.nvim", event = "VeryLazy", config = true },
    -- Indent Guides
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            max_indent_increase = 1,
            show_trailing_blankline_indent = false,
        },
        config = function(_, opts)
            require("indent_blankline").setup(opts)

            -- See indent-blankline.nvim#449
            for _, keymap in pairs({ "zo", "zO", "zc", "zC", "za", "zA", "zv", "zx", "zX", "zm", "zr" }) do
                vim.keymap.set("n", keymap, keymap .. "<CMD>IndentBlanklineRefresh<CR>", { silent = true })
            end
        end,
    },

    ------ Language Extensions
    { "lervag/vimtex", ft = "tex" },
    { "linux-cultist/venv-selector.nvim", event = { "BufReadPost", "BufNewFile" }, config = true },
    { "luk400/vim-jukit", ft = { "python", "json" } },
    { "jez/vim-better-sml", ft = "sml" },
    { "mfussenegger/nvim-jdtls", ft = "java" },
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
        ft = "markdown",
    },
    {
        "saecki/crates.nvim",
        opts = {
            null_ls = { enabled = true },
            popup = { border = "rounded" },
        },
        ft = "toml",
    },
}
