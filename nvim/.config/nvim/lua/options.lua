local g = vim.g
local o = vim.o
local config = vim.fn.stdpath("config")

-- Leaders

g.mapleader = " "
g.maplocalleader = "ç"

-- Miscellaneous

o.gdefault = true -- Replace all line matches during substitution
o.updatetime = 200 -- Time for CursorHold event (e.g., LSP)
o.scrolloff = 4 -- Context lines when scrolling
o.clipboard = "unnamedplus" -- Use system clipboard
o.fillchars = [[eob: ,fold: ,foldopen:󰅀,foldsep: ,foldclose:󰅂]] -- Fancy fold symbols
o.jumpoptions = "view" -- Prevents moving cursor when switching files
o.exrc = true -- Enable per-project config file (.nvim.lua)
o.showmode = false -- Hide message indicating current mode
o.undofile = true -- Enable persistent undo
o.tabclose = "left" -- When closing a tab, go to the one on the left
o.shadafile = "NONE" -- Don't save history
o.guifont = "ZedMono Nerd Font:h12" -- Font for Neovide
o.title = true

-- Completion
o.completeopt = "menuone,noselect,noinsert,fuzzy" -- More intuitive completion options
o.pumheight = 10 -- Limit completion window up to 10 lines
o.wildoptions = "pum,tagfile,fuzzy" -- Enable fuzzy finding commands

-- Softwrap
o.wrap = false -- Disable softwrap by default
o.linebreak = true -- Wrap words, not chars
o.breakindent = true -- Indent softwrapped lines
o.showbreak = " " -- Wrap indicator

-- Statuscolumn

o.number = true -- Print the line number in front of the current line
o.relativenumber = true -- Print the line numbers for motion
o.foldcolumn = "1" -- Clickable column that shows folds

-- Cursor

o.cursorlineopt = "number" -- Highlight only line number
o.cursorline = true -- Highlight current line

-- Spell

o.spellfile = config .. "/spell/en.utf-8.add," .. config .. "/spell/pt.utf-8.add" -- Custom dictionary files
o.spelllang = "en,pt_br" -- Languages to spell check
o.spelloptions = "camel" -- Consider camelCase when checking spell
o.spellsuggest = "best,9" -- Limit the number of suggestions for spell

-- Folds

o.foldlevelstart = 99 -- Don't close any folds at the start

-- Splits

o.splitbelow = true
o.splitright = true
o.splitkeep = "screen" -- Keep the same relative cursor position when splitting

-- Indentation

o.expandtab = true -- Expand tabs to spaces
o.tabstop = 4 -- Width of a tab
o.shiftwidth = 4 -- Indent's width
o.shiftround = true -- Round indent to multiple of 'shiftwidth'

-- Options

vim.opt.shortmess:append("Ic") -- Reduce vim's verboseness and remove intro message

-- Providers

g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
