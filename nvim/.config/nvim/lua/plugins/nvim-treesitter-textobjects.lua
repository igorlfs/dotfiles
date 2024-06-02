---@param query string
local function peek(query) require("nvim-treesitter-textobjects.lsp_interop").peek_definition_code(query) end

return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    keys = {
        {
            "<leader>pf",
            function() peek("@function.outer") end,
            desc = "Preview Function",
        },
        {
            "<leader>pc",
            function() peek("@class.outer") end,
            desc = "Preview Class",
        },
    },
    opts = {
        lsp_interop = {
            floating_preview_opts = {
                border = "rounded",
            },
        },
    },
}
