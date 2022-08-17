local o = vim.opt
local g = vim.g

-- Behavior
o.termguicolors = true -- Enable full color support
o.updatetime = 200 -- Time for CursorHold event (eg, LSP)
o.hlsearch = false -- Don't keep searches highlighted
o.linebreak = true -- Break words correctly
o.scrolloff = 4 -- Context lines when scrolling
o.clipboard:append { "unnamedplus" } -- Use system clipboard
o.wildmode = "longest,list,full" -- Funky completion for commands
o.spelllang:append { "pt_br" } -- Additional language to spell check
o.sessionoptions:append { "folds" } -- Also save folds in sessions

-- Folds
o.foldenable = false -- Disable folds by default
o.foldmethod = "expr"               -- Enable treesitter folds
o.foldexpr = "nvim_treesitter#foldexpr()"

-- Splits
o.splitbelow = true
o.splitright = true

-- Tabs
o.expandtab = true -- Expand tabs to spaces
o.tabstop = 4 -- Width of a tab
o.shiftwidth = 4 -- Indent's width

-- Appearence
o.number = true -- Print the line number in front of the current line
o.relativenumber = true -- Print the line numbers for motion
o.signcolumn = "yes" -- Always draw the extra column to indicate git or diagnostics
-- status line
o.ruler = false -- Hide the line and column number of the cursor position
o.laststatus = 3 -- Global status line
-- command line
o.showcmd = false -- Hide current (unfinished) command
o.showmode = false -- Hide message indicating current mode

-- History
o.undofile = true -- Enable persistent undo
o.shadafile = "NONE" -- Don't save history

-- Providers
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Plugins
g.catppuccin_flavour = "mocha"
g.vimtex_view_method = "zathura"
