local status, catppuccin = pcall(require, "catppuccin")

if not status then
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
                jukit_cellmarker_colors = { bg = mocha.mantle, fg = mocha.mantle },
                jukit_textcell_bg_colors = { bg = mocha.crust },
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
        noice = true,
        octo = true,
        mini = true,
    },
})

vim.cmd.colorscheme("catppuccin")
