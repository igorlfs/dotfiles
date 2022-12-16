local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local keymap = vim.keymap.set

-- Disable newline comments when inserting lines with o/O
local defaults = ag("Defaults", {})
au("FileType", {
    group = defaults,
    pattern = { "*" },
    callback = function()
        vim.opt.formatoptions:remove("o")
    end,
})

-- Unclutter terminal
au("Termopen", {
    group = defaults,
    pattern = { "*" },
    command = "setlocal nonumber norelativenumber scrolloff=0",
})

-- Spell
au("FileType", {
    group = defaults,
    pattern = { "markdown", "gitcommit", "tex" },
    command = "setlocal spell",
})

-- Build with C/C++
au("FileType", {
    group = ag("Cpp", {}),
    pattern = { "cpp", "c", "make" },
    callback = function()
        keymap("n", "<leader>m", "<cmd>Make<CR>", { buffer = true })
    end,
})

-- Common Jukit mappings for python and ipynb
local jukit = ag("Jukit", {})
au("FileType", {
    group = jukit,
    pattern = { "python", "json" },
    callback = function()
        keymap("n", "<leader>np", "<cmd>call jukit#convert#notebook_convert('jupyter-notebook')<cr>")
    end,
})

-- Clear repl for dap
au("FileType", {
    group = ag("dap", {}),
    pattern = { "dap-repl" },
    callback = function()
        keymap("i", "<C-l>", '<cmd>lua require("dap.repl").clear()<CR>', { buffer = true })
    end,
})
