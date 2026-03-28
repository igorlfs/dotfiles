local o = vim.o

-- Miscellaneous

o.gdefault = true -- Replace all line matches during substitution
o.updatetime = 200 -- Time for CursorHold event (e.g., LSP)
o.scrolloff = 4
o.clipboard = "unnamedplus" -- Use system clipboard
o.fillchars = [[eob: ,fold: ,foldopen:󰅀,foldsep: ,foldclose:󰅂,diff: ]] -- Fancy symbols
o.jumpoptions = "view" -- Prevents moving cursor when switching files
o.exrc = true
o.tabclose = "left"
o.guifont = "ZedMono Nerd Font:h11"
o.title = true
o.confirm = true
o.winborder = "rounded"

-- History

o.undofile = true -- Enable persistent undo
o.swapfile = false -- A swap file is yet to save me
o.shadafile = "NONE" -- Don't save history

-- Completion

o.completeopt = "menuone,popup,noselect,noinsert,fuzzy" -- More intuitive completion options
o.pumheight = 10 -- Limit completion window up to 10 lines

-- Softwrap

o.wrap = false -- Disable softwrap by default
o.linebreak = true -- Wrap words, not chars
o.breakindent = true -- Indent softwrapped lines
o.showbreak = "↳ " -- Wrap indicator

-- Statuscolumn

o.number = true
o.relativenumber = true
o.numberwidth = 2

-- Command line

o.cmdheight = 0 -- Hide command line window

-- Cursor

o.cursorlineopt = "number"
o.cursorline = true

-- Spell

local spell = vim.fn.stdpath("data") .. "/spell/"

o.spellfile = spell .. "en.utf-8.add," .. spell .. "pt.utf-8.add" -- Custom dictionary files
o.spelloptions = "camel"

-- Folds

o.foldtext = ""
o.foldlevelstart = 99
o.foldmethod = "expr" -- Fold method for treesitter and LSP

-- Splits

o.splitbelow = true
o.splitright = true
o.splitkeep = "topline"

-- Indentation

o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.shiftround = true

-- Array Options
-- (we don't talk about these)

vim.cmd("set nrformats+=blank")
vim.cmd("set spelllang+=pt_br")
-- Limit the number of suggestions for spell
vim.cmd("set spellsuggest+=9")
-- Enable fuzzy finding commands
vim.cmd("set wildoptions+=fuzzy")
-- Reduce vim's verboseness
vim.cmd("set shortmess+=c")
-- Allows using `gf` when file contains square brackets
-- See https://github.com/vim/vim/issues/19147
vim.cmd("set isfname+=[,]")
-- Local plugins
vim.cmd("set packpath+=~/code/nvim-plugins/")
