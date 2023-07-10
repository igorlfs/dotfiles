local g = vim.g
local o = vim.opt

g.mapleader = " " -- Use space as leader

-- Miscellanous
o.termguicolors = true -- Enable full color support
o.updatetime = 200 -- Time for CursorHold event (e.g., LSP)
o.diffopt:append({ "linematch:60" }) -- Better diffs
o.hlsearch = false -- Don't keep searches highlighted
o.linebreak = true -- Break lines correctly
o.scrolloff = 4 -- Context lines when scrolling
o.clipboard = "unnamedplus" -- Use system clipboard
o.wildmode = "longest:full,full" -- Funky completion for commands
o.conceallevel = 3 -- Hide verbosity in markdown and LaTeX
o.sessionoptions:remove({ "buffers", "folds" }) -- Update options saved by sessions
o.fillchars:append([[eob: ,fold: ,foldopen:󰅀,foldsep: ,foldclose:󰅂]]) -- Fancy fold symbols
o.jumpoptions = "view" -- Prevents moving cursor when switching files
o.exrc = true -- Enable per-project config file (.nvim.lua)
o.showmode = false -- Hide message indicating current mode
o.smoothscroll = true -- Smooth scrolling
o.undofile = true -- Enable persistent undo
o.shadafile = "NONE" -- Don't save history
o.shortmess:append("I") -- skip message at the start

-- Statuscolumn
o.number = true -- Print the line number in front of the current line
o.relativenumber = true -- Print the line numbers for motion

-- Cursor
o.cursorlineopt = "number" -- Only highlight numberline
o.cursorline = true -- Highlight current line

-- Spell
o.spelllang:append({ "pt_br" }) -- Additional language to spell check
o.spelloptions:append({ "camel" }) -- Consider camelCase when checking spell
-- Custom dictionary files
o.spellfile = {
    os.getenv("XDG_CONFIG_HOME") .. "nvim/spell/en.utf-8.add",
    os.getenv("XDG_CONFIG_HOME") .. "nvim/spell/pt.utf-8.add",
}

-- Folds
-- UFO requires a large value for these settings
o.foldlevel = 99
o.foldlevelstart = 99
o.foldcolumn = "1"

-- Splits
o.splitbelow = true
o.splitright = true
o.splitkeep = "screen" -- Keep the same relative cursor position when splitting

-- Tabs
o.expandtab = true -- Expand tabs to spaces
o.tabstop = 4 -- Width of a tab
o.shiftwidth = 4 -- Indent's width

-- Providers
g.python3_host_prog = "/usr/bin/python3"
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
