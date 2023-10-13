------ Jukit
-- Update launch mapping to be virtual env aware
vim.keymap.set("n", "<localleader>o", function()
    if os.getenv("VIRTUAL_ENV") then
        vim.cmd("JukitOut source $(poetry env info --path)/bin/activate")
    else
        vim.cmd("call jukit#splits#output()")
    end
end, { desc = "Jukit Split [O]pen", buffer = true })
