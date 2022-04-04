vim.opt_local.spell = true
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.textwidth = 80

-- Rudimentary ways to comment
vim.keymap.set("i", "<C-I>", "**<Esc>i", { buffer = 0 })
vim.keymap.set("i", "<C-B>", "****<Esc>hi", { buffer = 0 })
