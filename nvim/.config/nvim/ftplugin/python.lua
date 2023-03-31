local keymap = vim.keymap.set
local opts = { buffer = true }

------ Jukit
-- Splits
-- Opening and Closing
keymap("n", "<leader>so", "<cmd>call jukit#splits#output()<CR>", opts)
keymap("n", "<leader>sh", "<cmd>call jukit#splits#history()<CR>", opts)
keymap("n", "<leader>sc", "<cmd>call jukit#splits#close_output_and_history(1)<CR>", opts)

-- Sending Code
-- Current Cell
keymap("n", "<leader><leader>", "<cmd>call jukit#send#section(1)<CR>", opts)
-- All cells up to current one
keymap("n", "<leader>cc", "<cmd>call jukit#send#until_current_section()<CR>", opts)

-- Cells
-- Create
keymap("n", "<leader>cO", "<cmd>call jukit#cells#create_above(0)<CR>", opts)
keymap("n", "<leader>co", "<cmd>call jukit#cells#create_below(0)<CR>", opts)
keymap("n", "<leader>cT", "<cmd>call jukit#cells#create_above(1)<CR>", opts)
keymap("n", "<leader>ct", "<cmd>call jukit#cells#create_below(1)<CR>", opts)
-- Delete
keymap("n", "<leader>cd", "<cmd>call jukit#cells#delete()<CR>", opts)
-- Split
keymap("n", "<leader>cs", "<cmd>call jukit#cells#split()<CR>", opts)
-- Merge
keymap("n", "<leader>cM", "<cmd>call jukit#cells#merge_above()<CR>", opts)
keymap("n", "<leader>cm", "<cmd>call jukit#cells#merge_below()<CR>", opts)
-- Navigation
keymap("n", "<leader>j", "<cmd>call jukit#cells#jump_to_next_cell()<CR>", opts)
keymap("n", "<leader>k", "<cmd>call jukit#cells#jump_to_previous_cell()<CR>", opts)
-- Move
keymap("n", "<leader>ck", "<cmd>call jukit#cells#move_up()<CR>", opts)
keymap("n", "<leader>cj", "<cmd>call jukit#cells#move_down()<CR>", opts)
