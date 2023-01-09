local g = vim.g

-- Behavior
vim.opt.termguicolors = true -- Enable full color support
vim.opt.updatetime = 200 -- Time for CursorHold event (e.g., LSP)
vim.opt.hlsearch = false -- Don't keep searches highlighted
vim.opt.linebreak = true -- Break lines correctly
vim.opt.scrolloff = 4 -- Context lines when scrolling
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.wildmode = "longest,list,full" -- Funky completion for commands
vim.opt.conceallevel = 2 -- Hide verbosity in markdown and LaTeX

-- Spell
vim.opt.spelllang:append({ "pt_br" }) -- Additional language to spell check
vim.opt.spelloptions:append({ "camel" }) -- Consider camelCase when checking spell
vim.opt.spellfile = -- Custom dictionary files
    { vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"), vim.fn.expand("~/.config/nvim/spell/pt.utf-8.add") }

-- Folds
vim.opt.foldenable = false -- Prevents folds from auto closing
vim.opt.foldmethod = "expr" -- Enable treesitter folds
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Tabs
vim.opt.expandtab = true -- Expand tabs to spaces
vim.opt.tabstop = 4 -- Width of a tab
vim.opt.shiftwidth = 4 -- Indent's width

-- Lateral line
vim.opt.number = true -- Print the line number in front of the current line
vim.opt.relativenumber = true -- Print the line numbers for motion
vim.opt.signcolumn = "yes" -- Always draw the extra column to indicate git or diagnostics

-- Status line
vim.opt.ruler = false -- Hide the line and column number of the cursor position
vim.opt.laststatus = 3 -- Global status line

-- Command line
vim.opt.showcmd = false -- Hide current (unfinished) command
vim.opt.showmode = false -- Hide message indicating current mode

-- History
vim.opt.undofile = true -- Enable persistent undo
vim.opt.shadafile = "NONE" -- Don't save history

-- Providers
g.python3_host_prog = "/usr/bin/python3"
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Plugins
g.vimtex_view_method = "zathura"
g.jukit_mappings_ext_enabled = {} -- disable jukit default mappings
