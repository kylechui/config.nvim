-- I"m lazy
local map = vim.api.nvim_buf_set_keymap

map(0, "n", "<C-\">", "<Cmd>term time python3 %<CR>", { noremap = true, silent = true })
map(0, "n", "<C-CR>", "<Cmd>term time python3 %<input.txt<CR><Cmd>term time ./%:r.out<input.txt<CR>", { noremap = true, silent = true })
