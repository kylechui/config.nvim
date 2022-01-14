-- I'm lazy
local map = vim.api.nvim_set_keymap

map('n', '<C-\'>', '<Cmd>!g++ -Wall -std=c++17 -o %:r.out %<CR><Cmd>term time ./%:r.out<CR>', { noremap = true, silent = true })
map('n', '<C-CR>', '<Cmd>!g++ -Wall -std=c++17 -o %:r.out %<CR><Cmd>term time ./%:r.out<input.txt<CR>', { noremap = true, silent = true })
