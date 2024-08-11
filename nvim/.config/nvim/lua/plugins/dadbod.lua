return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        "tpope/vim-dadbod",
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql" } },
    },
    cmd = { "DBUI", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = { { "<A-y>", "<CMD>DBUIToggle<CR>" } },
    init = function() vim.g.db_ui_use_nerd_fonts = 1 end,
}
