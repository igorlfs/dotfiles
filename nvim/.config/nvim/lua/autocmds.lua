local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
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
        keymap("t", "<A-i>", "<C-\\><C-n><C-w>w", { desc = "Toggle Split/Code" })
    end,
})

autocmd("FileType", {
    desc = "Enable spellchecker",
    group = defaults,
    pattern = { "gitcommit", "tex", "NeogitCommitMessage" },
    command = "setlocal spell",
})

autocmd("FileType", {
    desc = "Disable foldcolumn",
    group = defaults,
    pattern = {
        "neotest-summary",
        "dap-repl",
        "NeogitCommitMessage",
        "NeogitStatus",
    },
    callback = function() vim.opt_local.foldcolumn = "0" end,
})

autocmd("FileType", {
    desc = "Jukit convert notebooks",
    group = jukit,
    pattern = { "python", "json" },
    callback = function()
        keymap(
            "n",
            "<leader>es",
            "<CMD>call jukit#convert#notebook_convert('jupyter-notebook')<cr>",
            { buffer = true, desc = "Jukit [E]xport [S]ource" }
        )
    end,
})

local lsp_group = augroup("lsp", { clear = false })
autocmd("LspAttach", {
    desc = "LSP",
    group = lsp_group,
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local lsp = vim.lsp
        local methods = lsp.protocol.Methods
        local lsp_buf = lsp.buf

        -- Lenses
        if client and client.supports_method(methods.textDocument_codeLens) then
            autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = ev.buf,
                callback = function() lsp.codelens.refresh() end,
            })
        end

        -- Buffer local mappings.
        keymap({ "n", "i" }, "<C-h>", lsp_buf.signature_help, { buffer = ev.buf })

        keymap("n", "<A-h>", function() lsp.inlay_hint(0, nil) end, { buffer = ev.buf, desc = "Toggle Hints" })

        keymap({ "n", "v" }, "<leader>la", lsp_buf.code_action, { buffer = ev.buf, desc = "[L]SP [A]ctions" })
        keymap("n", "<leader>lr", lsp_buf.rename, { buffer = ev.buf, desc = "[L]SP [R]ename" })
        keymap("n", "<leader>ll", lsp.codelens.run, { buffer = ev.buf, desc = "[L]SP [L]ens" })

        -- NOTE we define this mapping here, instead of using "<leader>f" because it overrides nvim's default gd
        -- (which is a primitive way of going to definition), in spite of it being a Telescope mapping
        keymap("n", "gd", "<CMD>Telescope lsp_definitions<CR>", { buffer = ev.buf, desc = "[G]o to [D]efinition" })
    end,
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

autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = augroup("highlight_yank", {}),
    callback = function() vim.highlight.on_yank() end,
})
