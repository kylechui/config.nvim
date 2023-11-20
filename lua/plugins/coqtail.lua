return {
    "whonore/Coqtail",
    version = "^1.7.0",
    ft = "coq",
    config = function()
        vim.g.coqtail_noimap = true
        vim.keymap.set("n", "<A-l>", vim.cmd.CoqToLine, { silent = true })
        vim.keymap.set("n", "<A-j>", vim.cmd.CoqNext, { silent = true })
        vim.keymap.set("n", "<A-k>", vim.cmd.CoqUndo, { silent = true })
    end,
}
