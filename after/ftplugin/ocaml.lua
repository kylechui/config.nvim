local map = vim.keymap.set

map("n", "<C-'>", function()
    vim.cmd.term("ocaml '%'")
end, {
    silent = true,
    buffer = true,
})

map("n", "<C-CR>", "<Cmd>term time ocaml %<input.txt<CR><Cmd>term time ./%:r.out<input.txt<CR>", {
    silent = true,
    buffer = true,
})
