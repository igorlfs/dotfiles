-- Courtesy of
-- https://github.com/stevearc/overseer.nvim/blob/master/doc/recipes.md#make-similar-to-vim-dispatch
-- With a slight modification:
-- don't open quickfix is there isn't any output to be parsed (i.e., open_on_match)
-- I don't really understand what is params.bang, but this works

return {
    "stevearc/overseer.nvim",
    cmd = "Make",
    config = function()
        require("overseer").setup()

        vim.api.nvim_create_user_command("Make", function(params)
            local args = vim.fn.expandcmd(params.args)
            -- Insert args at the '$*' in the makeprg
            local cmd, num_subs = vim.o.makeprg:gsub("%$%*", args)
            if num_subs == 0 then
                cmd = cmd .. " " .. args
            end
            local task = require("overseer").new_task({
                cmd = cmd,
                components = {
                    { "on_output_quickfix", open_on_match = not params.bang, open_height = 8 },
                    "default",
                },
            })
            task:start()
        end, {
            desc = "Run your makeprg as an Overseer task",
            nargs = "*",
            bang = true,
        })

        vim.api.nvim_create_autocmd("FileType", {
            desc = "Async build for C, C++",
            group = vim.api.nvim_create_augroup("make", {}),
            pattern = { "cpp", "c", "make" },
            callback = function() vim.keymap.set("n", "<leader>m", "<CMD>Make<CR>", { buffer = true, desc = "Build" }) end,
        })
    end,
}
