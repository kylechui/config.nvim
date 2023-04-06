return {
    "numToStr/Comment.nvim",
    keys = {
        { mode = "n", "<C-/>", "<Plug>(comment_toggle_linewise_current)" },
        { mode = "x", "<C-/>", "<Cmd>norm gbgv<CR>" },
        "gc",
        "gb",
    },
    config = true,
}
