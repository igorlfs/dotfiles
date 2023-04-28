-- Courtesy of
-- https://github.com/stevearc/overseer.nvim/blob/master/doc/recipes.md#make-similar-to-vim-dispatch
-- With a slight modifiaction:
-- don't open quickfix is there isn't any output to be parsed (e.g., open_on_match)
-- I don't really understand what is params.bang, but this works

local overseer_status, overseer = pcall(require, "overseer")

if not overseer_status then
    vim.notify("overseer not found")
    return
end

vim.api.nvim_create_user_command("Make", function(params)
    local task = overseer.new_task({
        cmd = vim.split(vim.o.makeprg, "%s+"),
        args = params.fargs,
        components = {
            { "on_output_quickfix", open_on_match = not params.bang, open_height = 8 },
            "default",
        },
    })
    task:start()
end, {
    desc = "",
    nargs = "*",
    bang = true,
})
