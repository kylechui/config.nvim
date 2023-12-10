return {
    [1] = "numToStr/Comment.nvim",
    version = "^0.8.0",
    keys = {
        { mode = "n", [1] = "<C-/>", [2] = "<Plug>(comment_toggle_linewise_current)" },
        {
            mode = "x",
            [1] = "<C-/>",
            [2] = "<Cmd>norm gbgv<CR>",
        },
        {
            mode = { "n", "x" },
            [1] = "gc",
        },
        {
            mode = { "n", "x" },
            [1] = "gb",
        },
    },
    config = function()
        require("Comment").setup()
        require("Comment.ft").set("coq", { "(*%s*)", "(*%s*)" })
    end,
}
