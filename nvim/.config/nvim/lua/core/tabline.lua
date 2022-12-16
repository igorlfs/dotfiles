M = {}

local function title(bufnr)
    local file = vim.fn.bufname(bufnr)
    local buftype = vim.fn.getbufvar(bufnr, "&buftype")
    local filetype = vim.fn.getbufvar(bufnr, "&filetype")

    if buftype == "help" then
        return "help:" .. vim.fn.fnamemodify(file, ":t:r")
    elseif buftype == "quickfix" then
        return "quickfix"
    elseif filetype == "checkhealth" then
        return "checkhealth"
    elseif filetype == "TelescopePrompt" then
        return "Telescope"
    elseif filetype == "git" then
        return "Git"
    elseif filetype == "fugitive" then
        return "Fugitive"
    elseif file:sub(file:len() - 2, file:len()) == "FZF" then
        return "FZF"
    elseif buftype == "terminal" then
        local _, mtch = string.match(file, "term:(.*):(%a+)")
        return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ":t")
    elseif file == "" then
        return "[No Name]"
    else
        return vim.fn.pathshorten(vim.fn.fnamemodify(file, ":p:~:t"))
    end
end

local function modified(bufnr)
    return vim.fn.getbufvar(bufnr, "&modified") == 1 and "[+] " or ""
end

local function cell(index)
    local isSelected = vim.fn.tabpagenr() == index
    local buflist = vim.fn.tabpagebuflist(index)
    local winnr = vim.fn.tabpagewinnr(index)
    local bufnr = buflist[winnr]
    local hl = (isSelected and "%#TabLineSel#" or "%#TabLine#")

    return hl .. "%" .. index .. "T" .. " " .. title(bufnr) .. " " .. modified(bufnr)
end

function M.tabline()
    local line = ""
    for i = 1, vim.fn.tabpagenr("$"), 1 do
        line = line .. cell(i)
    end
    line = line .. "%#TabLineFill#%="
    if vim.fn.tabpagenr("$") > 1 then
        line = line .. "%#TabLine#%999XX"
    end
    return line
end

vim.opt.tabline = "%!v:lua.M.tabline()"
