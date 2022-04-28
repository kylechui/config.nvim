local map = vim.keymap.set

map(
    "n",
    "<C-'>",
    "<Cmd>!g++ -Wall -std=c++17 -o '%:r.out' '%'<CR><Cmd>term time './%:r.out'<CR>",
    { silent = true, buffer = true }
)
map(
    "n",
    "<C-CR>",
    "<Cmd>!g++ -Wall -std=c++17 -o '%:r.out' '%'<CR><Cmd>term time './%:r.out'<'%:h/input.txt'<CR>",
    { silent = true, buffer = true }
)
