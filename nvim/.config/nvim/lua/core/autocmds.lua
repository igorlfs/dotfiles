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

-- Switch between header / implementation for C/C++
au("FileType", {
    group = ag("switchHeader", {}),
    pattern = { "cpp", "c" },
    callback = function()
        keymap("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = true })
    end
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
local python = ag("Python", {})
au("FileType", {
    group = python,
    pattern = { "python", "json" },
    callback = function()
        keymap("n", "<leader>ho", "<cmd>call jukit#splits#history()<CR>", { buffer = true })
        keymap("n", "<leader>hc", "<cmd>call jukit#splits#close_history()<CR>", { buffer = true })
        keymap("n", "<leader><space>", "<cmd>call jukit#send#section(1)<CR>", { buffer = true })
    end
})
