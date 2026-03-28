local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("nvim-tree/nvim-web-devicons") },
    { src = util.gh("ibhagwan/fzf-lua") },
})

local fzflua = require("fzf-lua")

fzflua.setup({
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
    },
    grep = {
        hidden = true,
        -- Inherit config
        -- Used to ignore searching inside the .git folder
        RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
    },
    tabs = {
        locate = false,
    },
    ui_select = {
        no_resume = true,
    },
})

util.keymap("<leader>ff", fzflua.global, "FZF Files")
util.keymap("<leader>fu", fzflua.undotree, "FZF Undotree")
util.keymap("<leader>ft", fzflua.tabs, "FZF Tabs")
util.keymap("<leader>fg", fzflua.live_grep, "FZF Grep")
util.keymap("<leader>fb", fzflua.buffers, "FZF Buffers")
util.keymap("<leader>fw", fzflua.grep_cword, "FZF Word")
util.keymap("<leader>fz", fzflua.zoxide, "FZF Zoxide")
util.keymap("<leader>fr", fzflua.resume, "FZF Resume")
util.keymap("<leader>fd", fzflua.diagnostics_workspace, "FZF Diagnostics")
util.keymap("<leader>db", fzflua.dap_breakpoints, "DAP Breakpoints")
util.keymap("<leader>df", fzflua.dap_frames, "DAP Frames")
util.keymap("grt", fzflua.lsp_typedefs, "FZF Type Definition")
util.keymap("grr", fzflua.lsp_references, "LSP Find References")
util.keymap("gO", fzflua.lsp_document_symbols, "Document Symbols")
