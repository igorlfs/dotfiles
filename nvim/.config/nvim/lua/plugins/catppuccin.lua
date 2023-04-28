local catppuccin_status, catppuccin = pcall(require, "catppuccin")

if not catppuccin_status then
    vim.notify("catppuccin not found")
    return
end

catppuccin.setup({
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    highlight_overrides = {
        mocha = function(mocha)
            return {
                -- see catppuccin/nvim#313
                NormalFloat = { fg = mocha.text, bg = mocha.none },
            }
        end,
    },
    integrations = {
        dap = {
            enabled = true,
            enable_ui = true,
        },
        illuminate = true,
        neotest = true,
        notify = true,
        neogit = true,
        octo = true,
    },
})

vim.cmd.colorscheme("catppuccin")
