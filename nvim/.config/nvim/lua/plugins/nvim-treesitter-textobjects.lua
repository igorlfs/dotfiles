---@param query string
local function peek(query) require("nvim-treesitter-textobjects.lsp_interop").peek_definition_code(query) end

---@param query string
local function select(query) require("nvim-treesitter-textobjects.select").select_textobject(query) end

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
        {
            "af",
            function() select("@function.outer") end,
            mode = { "x", "o" },
        },
        {
            "if",
            function() select("@function.inner") end,
            mode = { "x", "o" },
        },
        {
            "ac",
            function() select("@class.outer") end,
            mode = { "x", "o" },
        },
        {
            "ic",
            function() select("@class.inner") end,
            mode = { "x", "o" },
        },
        {
            "aa",
            function() select("@parameter.outer") end,
            mode = { "x", "o" },
        },
        {
            "ai",
            function() select("@parameter.inner") end,
            mode = { "x", "o" },
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
