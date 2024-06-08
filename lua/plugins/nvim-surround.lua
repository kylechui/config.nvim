return {
    dir = "/home/kylec/Documents/github/nvim-surround/main",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            move_cursor = "sticky",
        })
    end,
}
