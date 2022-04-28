vim.opt_local.spell = true
vim.opt_local.colorcolumn = "0"
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

vim.keymap.set("n", "<C-CR>", "<Cmd>VimtexCompile<CR>", { buffer = true })
