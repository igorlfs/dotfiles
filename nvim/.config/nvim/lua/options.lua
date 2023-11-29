local g = vim.g
local o = vim.opt

g.mapleader = " "
g.maplocalleader = "ç"

-- Miscellaneous
o.termguicolors = true -- Enable full color support
o.updatetime = 200 -- Time for CursorHold event (e.g., LSP)
o.diffopt:append({ "linematch:60" }) -- Better diffs
o.hlsearch = false -- Don't keep searches highlighted
o.linebreak = true -- Break lines correctly
o.scrolloff = 4 -- Context lines when scrolling
o.clipboard = "unnamedplus" -- Use system clipboard
o.sessionoptions:remove({ "buffers" }) -- Update options saved by sessions
o.fillchars:append([[eob: ,fold: ,foldopen:󰅀,foldsep: ,foldclose:󰅂]]) -- Fancy fold symbols
o.jumpoptions = "view" -- Prevents moving cursor when switching files
o.exrc = true -- Enable per-project config file (.nvim.lua)
o.showmode = false -- Hide message indicating current mode
o.smoothscroll = true -- Smooth scrolling
o.undofile = true -- Enable persistent undo
o.shortmess:append("Ic") -- Skip message at the start and reduce vim's verboseness
o.pumheight = 10 -- Limit completion window up to 10 lines
o.switchbuf = "usetab" -- Avoid wacky jumps with nvim-dap

-- Search
o.ignorecase = true -- Ignore case when searching
o.smartcase = true -- But also don't ignore if we use upper case

-- Statuscolumn
o.number = true -- Print the line number in front of the current line
o.relativenumber = true -- Print the line numbers for motion

-- Cursor
o.cursorlineopt = "number" -- Only highlight line number
o.cursorline = true -- Highlight current line

-- Spell
local spell = vim.fn.stdpath("config") .. "/spell/"
o.spellfile = { spell .. "en.utf-8.add", spell .. "pt.utf-8.add" } -- Custom dictionary files
o.spelllang:append({ "pt_br" }) -- Additional language to spell check
o.spelloptions:append({ "camel" }) -- Consider camelCase when checking spell

-- Folds
o.foldlevelstart = 99 -- Don't close any folds at the start
o.foldcolumn = "1" -- Clickable column that shows folds

-- Splits
o.splitbelow = true
o.splitright = true
o.splitkeep = "screen" -- Keep the same relative cursor position when splitting

-- Tabs
o.expandtab = true -- Expand tabs to spaces
o.tabstop = 4 -- Width of a tab
o.shiftwidth = 4 -- Indent's width
o.shiftround = true -- Round indent to multiple of 'shiftwidth'

-- Providers
g.python3_host_prog = vim.fn.expand("~/.local/share/virtualenvs/nvim-*/bin/python")
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
