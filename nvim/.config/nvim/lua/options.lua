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
o.shortmess = "ltToOCFIc" -- Reduce vim's verboseness and remove intro message
o.confirm = true
o.winborder = "rounded"
o.nrformats = "bin,hex,blank"

-- History

o.undofile = true -- Enable persistent undo
o.swapfile = false -- A swap file is yet to save me
o.shadafile = "NONE" -- Don't save history

-- Completion

o.complete = ".,o" -- completion sources: current buffer + omnifunc
o.completeopt = "menuone,popup,noselect,noinsert,fuzzy" -- More intuitive completion options
o.pumheight = 10 -- Limit completion window up to 10 lines
o.wildoptions = "pum,tagfile,fuzzy" -- Enable fuzzy finding commands

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
o.spelllang = "en,pt_br"
o.spelloptions = "camel"
o.spellsuggest = "best,9" -- Limit the number of suggestions for spell

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
