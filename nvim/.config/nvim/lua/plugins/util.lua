local M = {}

function M.peek_or_show_documentation()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
        local filetype = vim.bo.filetype
        if vim.tbl_contains({ "vim", "help" }, filetype) then
            vim.cmd("h " .. vim.fn.expand("<cword>"))
        elseif vim.tbl_contains({ "man" }, filetype) then
            vim.cmd("Man " .. vim.fn.expand("<cword>"))
        elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
            require("crates").show_popup()
        else
            vim.lsp.buf.hover()
        end
    end
end

function M.launch_jukit_with_venv()
    if os.getenv("VIRTUAL_ENV") then
        vim.cmd("JukitOut source $(poetry env info --path)/bin/activate")
    else
        vim.cmd("call jukit#splits#output()")
    end
end

function M.start_or_continue_dap()
    -- (Re-)reads launch.json if present
    if vim.fn.filereadable(".vscode/launch.json") then
        require("dap.ext.vscode").load_launchjs(
            nil,
            { codelldb = { "c", "cpp" }, ["pwa-node"] = { "javascript", "typescript" } }
        )
    end
    require("dap").continue()
end

-- DAP adapter for C, C++ and Rust
M.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

-- Add additional capabilities supported by nvim-cmp
M.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Add additional capabilities supported by UFO
M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

function M.title(bufnr)
    local file = vim.fn.bufname(bufnr)
    local buftype = vim.fn.getbufvar(bufnr, "&buftype")
    local filetype = vim.fn.getbufvar(bufnr, "&filetype")

    if filetype == "checkhealth" then
        return "checkhealth"
    elseif filetype == "TelescopePrompt" then
        return "Telescope"
    elseif filetype == "NvimTree" then
        return "NvimTree"
    elseif buftype == "terminal" then
        local _, mtch = string.match(file, "term:(.*):(%a+)")
        return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ":t")
    elseif file == "" then
        return "[No Name]"
    else
        return vim.fn.fnamemodify(file, ":.")
    end
end

return M
