local map = vim.keymap.set

map(0, "n", "<C-\">", "<Cmd>term time python3 %<CR>", { silent = true })
map(0, "n", "<C-CR>", "<Cmd>term time python3 %<input.txt<CR><Cmd>term time ./%:r.out<input.txt<CR>", { silent = true })
