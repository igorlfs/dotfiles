local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local clear = vim.api.nvim_clear_autocmds
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
    pattern = { "gitcommit", "tex" },
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

-- Reload packer
au("BufWritePost", {
    group = ag("packer", {}),
    pattern = "plugins.lua",
    command = "source <afile> | PackerCompile",
})

-- Autoformat on save
local lsp_group = ag("lsp", { clear = false })
au("LspAttach", {
    group = lsp_group,
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.supports_method("textDocument/formatting") then
            au("BufWritePre", {
                clear({ group = lsp_group, buffer = bufnr }),
                group = lsp_group,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        filter = function(c)
                            return c.name ~= "tsserver" and c.name ~= "lua_ls"
                        end,
                    })
                end,
            })
        end
    end,
})
