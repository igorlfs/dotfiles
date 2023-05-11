local g = vim.g
local o = vim.opt

-- Behavior
o.termguicolors = true -- Enable full color support
o.updatetime = 200 -- Time for CursorHold event (e.g., LSP)
o.diffopt:append({ "linematch:60" }) -- Better diffs
o.hlsearch = false -- Don't keep searches highlighted
o.linebreak = true -- Break lines correctly
o.scrolloff = 4 -- Context lines when scrolling
o.clipboard = "unnamedplus" -- Use system clipboard
o.wildmode = "longest,list,full" -- Funky completion for commands
o.conceallevel = 2 -- Hide verbosity in markdown and LaTeX
o.sessionoptions:append("localoptions") -- Extend options saved by sessions
o.fillchars:append([[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]) -- Fancy fold symbols
o.jumpoptions = "view" -- Prevents moving cursor when switching files
o.exrc = true -- Enable per-project config file (.nvim.lua)
o.smoothscroll = true -- Scroll within visual lines

-- Spell
o.spelllang:append({ "pt_br" }) -- Additional language to spell check
o.spelloptions:append({ "camel" }) -- Consider camelCase when checking spell
o.spellfile = -- Custom dictionary files
    { vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"), vim.fn.expand("~/.config/nvim/spell/pt.utf-8.add") }

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

-- Lateral line
o.number = true -- Print the line number in front of the current line
o.relativenumber = true -- Print the line numbers for motion
o.signcolumn = "yes" -- Always draw the extra column to indicate git or diagnostics

-- Status line
o.laststatus = 0 -- Hide status line

-- Command line
o.showmode = false -- Hide message indicating current mode

-- History
o.undofile = true -- Enable persistent undo
o.shadafile = "NONE" -- Don't save history

-- Providers
g.python3_host_prog = "/usr/bin/python3"
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Plugins
g.vimtex_view_method = "zathura"
g.jukit_mappings_ext_enabled = {} -- disable jukit default mappings
