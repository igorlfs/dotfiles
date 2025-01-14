-- https://github.com/neovim/neovim/issues/30198#issuecomment-2326075321
-- Ensure that forced and not configurable `<Tab>` and `<S-Tab>`
-- buffer-local mappings don't override already present ones
local expand_orig = vim.snippet.expand
vim.snippet.expand = function(...)
    local tab_map = vim.fn.maparg("<Tab>", "i", false, true)
    local stab_map = vim.fn.maparg("<S-Tab>", "i", false, true)
    expand_orig(...)
    vim.schedule(function()
        tab_map.buffer, stab_map.buffer = 1, 1
        -- Override temporarily forced buffer-local mappings
        vim.fn.mapset("i", false, tab_map)
        vim.fn.mapset("i", false, stab_map)
    end)
end
