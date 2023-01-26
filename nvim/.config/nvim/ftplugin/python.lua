local keymap = vim.keymap.set
local opts = { buffer = true }

------ Jukit
-- Splits
-- Opening and Closing
keymap("n", "<leader>so", "<cmd>call jukit#splits#output()<cr>", opts)
keymap("n", "<leader>sh", "<cmd>call jukit#splits#history()<cr>", opts)
keymap("n", "<leader>sc", "<cmd>call jukit#splits#close_output_and_history(1)<cr>", opts)

-- Sending Code
-- Current Cell
keymap("n", "<leader><leader>", "<cmd>call jukit#send#section(1)<cr>", opts)
-- All cells up to current one
keymap("n", "<leader>cc", "<cmd>call jukit#send#until_current_section()<cr>", opts)

-- Cells
-- Create
keymap("n", "<leader>cR", "<cmd>call jukit#cells#create_above(0)<cr>", opts)
keymap("n", "<leader>cr", "<cmd>call jukit#cells#create_below(0)<cr>", opts)
keymap("n", "<leader>cT", "<cmd>call jukit#cells#create_above(1)<cr>", opts)
keymap("n", "<leader>ct", "<cmd>call jukit#cells#create_below(1)<cr>", opts)
-- Delete
keymap("n", "<leader>cd", "<cmd>call jukit#cells#delete()<cr>", opts)
-- Split
keymap("n", "<leader>cs", "<cmd>call jukit#cells#split()<cr>", opts)
-- Merge
keymap("n", "<leader>cM", "<cmd>call jukit#cells#merge_above()<cr>", opts)
keymap("n", "<leader>cm", "<cmd>call jukit#cells#merge_below()<cr>", opts)
-- Navigation
keymap("n", "<leader>j", "<cmd>call jukit#cells#jump_to_next_cell()<cr>", opts)
keymap("n", "<leader>k", "<cmd>call jukit#cells#jump_to_previous_cell()<cr>", opts)
