require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "make", "lua", "python", "vim", "norg", "toml", "java" },
    auto_install = true,
    highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },
    indent = {
        enable = true,
        disable = { "python" },
    },
})
