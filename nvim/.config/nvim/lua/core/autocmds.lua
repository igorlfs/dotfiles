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
    end
})

-- Unclutter terminal
au("Termopen", {
    group = defaults,
    pattern = { "*" },
    command = "setlocal nonumber norelativenumber scrolloff=0"
})

-- Spell
au("FileType", {
    group = defaults,
    pattern = { "markdown", "gitcommit", "tex" },
    command = "setlocal spell"
})

-- Build with C/C++
au("FileType", {
    group = ag("Cpp", {}),
    pattern = { "cpp", "c", "make" },
    callback = function()
        keymap("n", "<leader>m", "<cmd>Make<CR>", { buffer = true })
    end
})

-- Web autofix
au("BufWritePre", {
    group = ag("Web", {}),
    pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", "*.vue" },
    command = "EslintFixAll",
})

-- Alternative mappings for Jukit to avoid conflicts with git-signs
local jukit = ag("Jukit", {})
au("FileType", {
    group = jukit,
    pattern = { "python", "json" },
    callback = function()
        keymap("n", "<leader>ho", "<cmd>call jukit#splits#history()<CR>", { buffer = true })
        keymap("n", "<leader>hc", "<cmd>call jukit#splits#close_history()<CR>", { buffer = true })
        keymap("n", "<leader><space>", "<cmd>call jukit#send#section(1)<CR>", { buffer = true })
    end
})

-- Clear repl for dap
au("FileType", {
    group = ag("dap", {}),
    pattern = { "dap-repl" },
    callback = function()
        keymap("i", "<C-l>", '<ESC>:lua require("dap.repl").clear()<CR>i', { buffer = true })
    end
})
