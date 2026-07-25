-- Neogit sets up the buffers in a weird that ends up requiring a schedule
vim.schedule(function()
    vim.wo[0][0].cursorlineopt = "line"
end)
