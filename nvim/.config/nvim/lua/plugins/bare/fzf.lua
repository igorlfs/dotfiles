return {
    "ibhagwan/fzf-lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        "hide",
        fzf_opts = {
            ["--cycle"] = true,
        },
        winopts = {
            border = "solid",
            preview = {
                border = "solid",
            },
        },
        keymap = {
            fzf = {
                true,
                ["ctrl-p"] = "toggle+up",
                ["ctrl-n"] = "toggle+down",
                ["tab"] = "down",
                ["btab"] = "up",
            },
        },
        files = {
            -- See https://github.com/ibhagwan/fzf-lua/issues/1585
            formatter = { "path.filename_first", 2 },
        },
        lsp = {
            jump1 = true,
            includeDeclaration = false,
            code_actions = {
                -- See https://github.com/ibhagwan/fzf-lua/issues/1295
                previewer = false,
                -- Exclude code actions from resume state
                -- See https://github.com/ibhagwan/fzf-lua/discussions/2425
                no_resume = true,
            },
        },
        grep = {
            hidden = true,
            -- Inherit config
            -- Used to ignore searching inside the .git folder
            RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
        },
    },
    keys = function()
        local fzflua = require("fzf-lua")
        return {
            { "<leader>ff", fzflua.global, desc = "FZF Files" },
            { "<leader>ft", fzflua.tabs, desc = "FZF Tabs" },
            { "<leader>fg", fzflua.live_grep, desc = "FZF Grep" },
            { "<leader>fb", fzflua.buffers, desc = "FZF Buffers" },
            { "<leader>fw", fzflua.grep_cword, desc = "FZF Word" },
            { "<leader>fz", fzflua.zoxide, desc = "FZF Zoxide" },
            { "<leader>fr", fzflua.resume, desc = "FZF Resume" },
            { "<leader>fd", fzflua.diagnostics_workspace, desc = "FZF Diagnostics" },
            { "<leader>db", fzflua.dap_breakpoints, desc = "DAP Breakpoints" },
            { "<leader>df", fzflua.dap_frames, desc = "DAP Frames" },
            { "grt", fzflua.lsp_typedefs, desc = "FZF Type Definition" },
            { "grr", fzflua.lsp_references, desc = "LSP Find References" },
            { "gO", fzflua.lsp_document_symbols, desc = "Document Symbols" },
        }
    end,
    cmd = { "FzfLua" },
    init = function() require("fzf-lua").register_ui_select({ no_resume = true }) end,
}
