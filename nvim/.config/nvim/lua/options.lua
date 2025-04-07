local o = vim.o
local data = vim.fn.stdpath("data")

-- Miscellaneous

o.gdefault = true -- Replace all line matches during substitution
o.updatetime = 200 -- Time for CursorHold event (e.g., LSP)
o.scrolloff = 4 -- Context lines when scrolling
o.clipboard = "unnamedplus" -- Use system clipboard
o.fillchars = [[eob: ,fold: ,foldopen:󰅀,foldsep: ,foldclose:󰅂,diff: ]] -- Fancy symbols
o.jumpoptions = "view" -- Prevents moving cursor when switching files
o.exrc = true -- Enable per-project config file (.nvim.lua)
o.showmode = false -- Hide message indicating current mode
o.tabclose = "left" -- When closing a tab, go to the one on the left
o.guifont = "ZedMono Nerd Font:h11" -- Font for Neovide
o.title = true -- Title for the Neovim Window
o.diffopt = "internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram" -- Better diffs
o.confirm = true -- Ask to save unsaved changes

-- History
o.undofile = true -- Enable persistent undo
o.swapfile = false -- A swap file is yet to save me
o.shadafile = "NONE" -- Don't save history

-- Completion
o.completeopt = "menuone,noselect,noinsert,fuzzy" -- More intuitive completion options
o.pumheight = 10 -- Limit completion window up to 10 lines
o.wildoptions = "pum,tagfile,fuzzy" -- Enable fuzzy finding commands

-- Softwrap
o.wrap = false -- Disable softwrap by default
o.linebreak = true -- Wrap words, not chars
o.breakindent = true -- Indent softwrapped lines
o.showbreak = "↳ " -- Wrap indicator

-- Statuscolumn

o.number = true -- Print the line number in front of the current line
o.relativenumber = true -- Print the line numbers for motion
o.numberwidth = 2 -- Minimum width for the number in the status column

-- Cursor

o.cursorlineopt = "number" -- Highlight only line number
o.cursorline = true -- Highlight current line

-- Spell

o.spellfile = data .. "/spell/en.utf-8.add," .. data .. "/spell/pt.utf-8.add" -- Custom dictionary files
o.spelllang = "en,pt_br" -- Languages to spell check
o.spelloptions = "camel" -- Consider camelCase when checking spell
o.spellsuggest = "best,9" -- Limit the number of suggestions for spell

-- Folds

o.foldtext = "" -- Highlight folds
o.foldlevelstart = 99 -- Don't close any folds at the start
o.foldmethod = "expr" -- Fold method for treesitter and LSP

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
