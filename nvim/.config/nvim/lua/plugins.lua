return {
    ------ Miscellaneous
    -- Library used by many plugins
    { "nvim-lua/plenary.nvim" },
    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        opts = {
            direction = "float",
            float_opts = { border = "rounded" },
        },
        keys = { { "<a-p>", "<CMD>ToggleTerm<CR>", desc = "Toggle Float Term", mode = { "n", "t" } } },
    },
    -- Sessions
    {
        "jedrzejboczar/possession.nvim",
        opts = {
            autosave = {
                current = true,
            },
        },
        keys = { { "<leader>fs", "<CMD>Telescope possession list<CR>", desc = "Search Sessions" } },
        cmd = { "PossessionSave" },
    },
    -- Developer Tools Package Manager
    {
        "williamboman/mason.nvim",
        opts = { ui = { border = "rounded" } },
        cmd = "Mason",
    },

    ------ LSP Extensions
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
        "NeogitOrg/neogit",
        dependencies = {
            "sindrets/diffview.nvim",
            cmd = { "DiffviewOpen", "DiffviewFileHistory" },
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
    -- Surround
    { "kylechui/nvim-surround", event = { "BufReadPost", "BufNewFile" }, config = true },
    -- Comments
    { "numToStr/Comment.nvim", event = { "BufReadPost", "BufNewFile" }, config = true },
    -- Snippets
    { "honza/vim-snippets" },
    -- Indentation
    { "nmac427/guess-indent.nvim", event = { "VimEnter" }, config = true },

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
    {
        "lervag/vimtex",
        init = function()
            -- Avoid startup warning about Tree-sitter
            -- Prefer Tree-sitter's highlighting as it allows spell-checking
            vim.g.vimtex_syntax_enabled = 0
            vim.g.vimtex_syntax_conceal_disable = 1
        end,
    },
    {
        "luk400/vim-jukit",
        ft = { "python", "json", "julia" },
        init = function()
            vim.g.jukit_mappings_ext_enabled = {} -- disable default mappings
            vim.g.jukit_terminal = "nvimterm"
        end,
    },
    { "linux-cultist/venv-selector.nvim", event = { "BufReadPost", "BufNewFile" }, config = true },
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
