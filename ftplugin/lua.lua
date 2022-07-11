local map = vim.keymap.set

map("n", "<Leader>t", "<Plug>PlenaryTestFile", {
    silent = true,
    buffer = true,
})
