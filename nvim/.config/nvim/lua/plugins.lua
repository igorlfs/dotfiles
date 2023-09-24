return {
    ------ Miscellaneous
    -- Library used by many plugins
    { "nvim-lua/plenary.nvim", lazy = true },
    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        opts = {
            direction = "float",
            float_opts = { border = "rounded" },
        },
        keys = { { "<A-t>", "<CMD>ToggleTerm<CR>", desc = "Toggle Terminal", mode = { "n", "t" } } },
    },
    -- Sessions
    {
        "jedrzejboczar/possession.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            autosave = {
                current = true,
            },
        },
        keys = { { "<leader>fs", "<CMD>Telescope possession list<CR>", desc = "[F]ind [S]essions" } },
        cmd = { "PossessionSave" },
    },
    -- Developer Tools Package Manager
    {
        "williamboman/mason.nvim",
        opts = { ui = { border = "rounded" } },
        cmd = "Mason",
    },
    -- Quickfix
    { "kevinhwang91/nvim-bqf", ft = "qf" },

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
            { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        cmd = "Neogit",
        config = true,
    },
    -- Github
    {
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "DaikyXendo/nvim-web-devicons",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "Octo",
        config = true,
    },

    ------ Editing
    -- Pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { check_ts = true, ignored_next_char = "" },
    },
    -- Tags
    {
        "windwp/nvim-ts-autotag",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true,
    },
    -- Surround
    { "kylechui/nvim-surround", event = "VeryLazy", config = true },
    -- Comments
    -- Snippets
    { "honza/vim-snippets" },
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },
    -- Indentation
    { "nmac427/guess-indent.nvim", config = true },
    -- Refactoring
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = true,
    },

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
    -- LaTeX
    {
        "lervag/vimtex",
        init = function()
            -- Avoid startup warning about Tree-sitter
            -- Prefer Tree-sitter's highlighting as it allows spell-checking
            vim.g.vimtex_syntax_enabled = 0
            vim.g.vimtex_syntax_conceal_disable = 1
        end,
    },
    -- REPL
    {
        "luk400/vim-jukit",
        ft = { "python", "json", "julia" },
        init = function()
            vim.g.jukit_mappings_ext_enabled = {} -- disable default mappings
            vim.g.jukit_terminal = "nvimterm"
        end,
    },
    -- Java's JDTLS extensions
    { "mfussenegger/nvim-jdtls", ft = "java" },
    -- Preview Markdown
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
        ft = "markdown",
    },
    -- Crates
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { popup = { border = "rounded" } },
    },
}
