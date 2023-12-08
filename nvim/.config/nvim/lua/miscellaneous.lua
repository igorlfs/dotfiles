-- Autoclear searches
vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local new_hlsearch = vim.tbl_contains({ "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
        if vim.opt.hlsearch:get() ~= new_hlsearch then
            vim.opt.hlsearch = new_hlsearch
        end
    end
end, vim.api.nvim_create_namespace("auto_hlsearch"))
