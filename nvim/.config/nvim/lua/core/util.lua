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

return M
