local keymap = vim.keymap.set
local opts = { buffer = true }

keymap("n", "<leader>so", "<cmd>SMLReplStart<CR>", opts)
keymap("n", "<leader>sc", "<cmd>SMLReplStop<CR>", opts)

-- Ugly hack so we can send yank the current paragraph,
-- move to window on the left (REPL), paste, press enter,
-- and move back to the original window
keymap("n", "<leader><leader>", "yip<C-w>wpi<CR><C-\\><C-n><C-w>w", opts)
