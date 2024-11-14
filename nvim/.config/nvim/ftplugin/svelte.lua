-- Sometimes, when joining lines in Svelte, the '>' from a closing tag can be erroneously consumed
-- This setting prevents that from happening
-- See https://github.com/neovim/neovim/issues/27260
vim.opt_local.formatoptions:remove("j")
