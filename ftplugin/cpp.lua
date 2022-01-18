-- I'm lazy
local map = vim.api.nvim_buf_set_keymap

map(0, 'n', '<C-\'>', '<Cmd>!g++ -Wall -std=c++17 -o "%:r.out" "%"<CR><Cmd>term time "./%:r.out"<CR>', { noremap = true, silent = true })
map(0, 'n', '<C-CR>', '<Cmd>!g++ -Wall -std=c++17 -o "%:r.out" "%"<CR><Cmd>term time "./%:r.out"<"%:h/input.txt"<CR>', { noremap = true, silent = true })
