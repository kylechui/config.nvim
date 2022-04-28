local map = vim.keymap.set

map("n", "<C-\">", "<Cmd>term time python3 %<CR>", {
    silent = true,
    buffer = true,
})
map("n", "<C-CR>", "<Cmd>term time python3 %<input.txt<CR><Cmd>term time ./%:r.out<input.txt<CR>", {
    silent = true,
    buffer = true,
})
