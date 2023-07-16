local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local clear = vim.api.nvim_clear_autocmds
local keymap = vim.keymap.set

local defaults = augroup("Defaults", {})
local jukit = augroup("Jukit", {})

autocmd("FileType", {
    desc = "Disable newline comments when inserting lines with o/O",
    group = defaults,
    pattern = { "*" },
    command = "setlocal formatoptions-=o",
})

autocmd("Termopen", {
    desc = "Unclutter terminal",
    group = defaults,
    pattern = { "*" },
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
        -- Use a fixed width to avoid resizing vim-jukit
        vim.opt_local.winfixwidth = true
        keymap("t", "<A-i>", "<C-\\><C-n><C-w>w")
    end,
})

autocmd("FileType", {
    desc = "Enable spellchecker",
    group = defaults,
    pattern = { "gitcommit", "tex", "NeogitCommitMessage" },
    command = "setlocal spell",
})

autocmd("FileType", {
    desc = "Async build with C, C++",
    group = augroup("make", {}),
    pattern = { "cpp", "c", "make" },
    callback = function() keymap("n", "<leader>m", "<cmd>Make<CR>", { buffer = true }) end,
})

autocmd("FileType", {
    desc = "Jukit convert notebooks",
    group = jukit,
    pattern = { "python", "json" },
    callback = function() keymap("n", "<leader>np", "<cmd>call jukit#convert#notebook_convert('jupyter-notebook')<cr>") end,
})

local lsp_group = augroup("lsp", { clear = false })
autocmd("LspAttach", {
    desc = "LSP",
    group = lsp_group,
    callback = function(ev)
        -- Autoformat
        local excluded = { "lua_ls" }
        autocmd("BufWritePre", {
            clear({ group = lsp_group, buffer = ev.buf }),
            group = lsp_group,
            buffer = ev.buf,
            callback = function()
                vim.lsp.buf.format({
                    filter = function(c) return not vim.tbl_contains(excluded, c.name) end,
                })
            end,
        })

        -- Buffer local mappings.
        local lsp = vim.lsp.buf
        local opts = { buffer = ev.buf }

        keymap("n", "<leader>H", function() vim.lsp.inlay_hint(0, nil) end, opts)
        keymap("n", "K", lsp.hover, opts)
        keymap("n", "gD", lsp.declaration, opts)
        keymap({ "n", "i" }, "<C-k>", lsp.signature_help, opts)
        keymap({ "n", "v" }, "<leader>ca", lsp.code_action, opts)
        keymap("n", "<leader>rn", lsp.rename, opts)
        keymap("n", "<leader>F", function() lsp.format({ async = true }) end, opts)
        keymap("n", "<leader>wl", function() print(vim.inspect(lsp.list_workspace_folders())) end, opts)
        keymap("n", "<leader>wa", lsp.add_workspace_folder, opts)
        keymap("n", "<leader>wr", lsp.remove_workspace_folder, opts)

        -- Telescope Stuff
        local telescope = require("telescope.builtin")

        keymap("n", "gd", telescope.lsp_definitions, opts)
        keymap("n", "gi", telescope.lsp_implementations, opts)
        keymap("n", "gr", function() telescope.lsp_references({ show_line = false }) end, opts)
        keymap("n", "<leader>D", telescope.lsp_type_definitions, opts)
        keymap("n", "<leader>ic", telescope.lsp_incoming_calls, opts)
        keymap("n", "<leader>oc", telescope.lsp_outgoing_calls, opts)
        keymap("n", "<leader>ds", telescope.lsp_document_symbols, opts)

        -- Note: diagnostics are NOT specific to LSP
        keymap("n", "<leader>E", telescope.diagnostics, opts)
    end,
})

autocmd({ "VimEnter", "DirChanged" }, {
    desc = "Venv autoselect",
    pattern = "*",
    callback = function()
        local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
        if venv ~= "" then
            require("venv-selector").retrieve_from_cache()
        end
    end,
    once = true,
})

autocmd("FileType", {
    desc = "Jukit Mappings",
    group = jukit,
    pattern = { "python", "julia" },
    callback = function()
        local opts = { buffer = true }

        -- Splits
        -- Opening and Closing
        keymap("n", "<leader>so", "<cmd>call jukit#splits#output()<CR>", opts)
        keymap("n", "<leader>sh", "<cmd>call jukit#splits#history()<CR>", opts)
        keymap("n", "<leader>sc", "<cmd>call jukit#splits#close_output_and_history(1)<CR>", opts)
        -- Move
        keymap("n", "<A-i>", "<C-w>wi")

        -- Sending Code
        -- Current Cell
        keymap("n", "<leader><leader>", "<cmd>call jukit#send#section(1)<CR>", opts)
        -- All cells up to current one
        keymap("n", "<leader>cc", "<cmd>call jukit#send#until_current_section()<CR>", opts)

        -- Cells
        -- Create
        keymap("n", "<leader>cO", "<cmd>call jukit#cells#create_above(0)<CR>", opts)
        keymap("n", "<leader>co", "<cmd>call jukit#cells#create_below(0)<CR>", opts)
        keymap("n", "<leader>cT", "<cmd>call jukit#cells#create_above(1)<CR>", opts)
        keymap("n", "<leader>ct", "<cmd>call jukit#cells#create_below(1)<CR>", opts)
        -- Delete
        keymap("n", "<leader>cd", "<cmd>call jukit#cells#delete()<CR>", opts)
        -- Split
        keymap("n", "<leader>cs", "<cmd>call jukit#cells#split()<CR>", opts)
        -- Merge
        keymap("n", "<leader>cM", "<cmd>call jukit#cells#merge_above()<CR>", opts)
        keymap("n", "<leader>cm", "<cmd>call jukit#cells#merge_below()<CR>", opts)
        -- Navigation
        keymap("n", "<leader>j", "<cmd>call jukit#cells#jump_to_next_cell()<CR>", opts)
        keymap("n", "<leader>k", "<cmd>call jukit#cells#jump_to_previous_cell()<CR>", opts)
        -- Move
        keymap("n", "<leader>ck", "<cmd>call jukit#cells#move_up()<CR>", opts)
        keymap("n", "<leader>cj", "<cmd>call jukit#cells#move_down()<CR>", opts)

        -- Export to PDF
        -- Use data saved by jukit to build the output
        keymap("n", "<leader>pd", "<cmd>call jukit#convert#save_nb_to_file(0,1,'pdf')<CR>", opts)
        -- Re-run all cells to build the output
        keymap("n", "<leader>pD", "<cmd>call jukit#convert#save_nb_to_file(1,1,'pdf')<CR>", opts)
    end,
})
