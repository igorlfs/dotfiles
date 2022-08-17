local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set

-- Disable newline comments when inserting lines with o/O
autocmd(
    "FileType", {
    pattern = { "*" },
    callback = function()
        vim.opt.formatoptions:remove("o")
    end
})

-- Unclutter terminal
autocmd(
    "Termopen", {
    pattern = { "*" },
    command = "setlocal nonumber norelativenumber scrolloff=0"
})

-- Switch between header / implementation for C/C++
autocmd(
    "FileType", {
    pattern = { "cpp", "c" },
    callback = function()
        keymap("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = true })
    end
})

-- Build with C/C++
autocmd(
    "FileType", {
    pattern = { "cpp", "c", "make" },
    callback = function()
        keymap("n", "<leader>m", "<cmd>Make<CR>", { buffer = true })
    end
})

-- Build with Rust
autocmd(
    "FileType", {
    pattern = { "rust" },
    command = "compiler cargo"
})
autocmd(
    "FileType", {
    pattern = { "rust" },
    callback = function()
        keymap("n", "<leader>m", "<cmd>Make build<CR>", { buffer = true })
    end
})
