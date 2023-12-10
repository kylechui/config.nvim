return {
    [1] = "whonore/Coqtail",
    version = "^1.7.0",
    ft = "coq",
    config = function()
        vim.g.coqtail_noimap = true
        vim.keymap.set("n", "<A-l>", vim.cmd.CoqToLine, { silent = true })
        vim.keymap.set("n", "<A-j>", vim.cmd.CoqNext, { silent = true })
        vim.keymap.set("n", "<A-k>", vim.cmd.CoqUndo, { silent = true })
        vim.cmd.highlight("CoqtailChecked guibg=#1a651a")
        vim.cmd.highlight("CoqtailSent guibg=#258e25")
    end,
}
