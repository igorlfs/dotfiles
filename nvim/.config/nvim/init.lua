require("globals")
require("options")
require("keymaps")
require("autocmds")
require("diagnostics")
require("filetype")
require("watch")
require("lsp")

if vim.g.neovide ~= nil then
    require("neovide")
end

-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
    { import = "plugins.common" },
    { import = "plugins.bare", cond = function() return not vim.g.vscode end },
}, {
    dev = {
        path = "~/code/git/",
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
