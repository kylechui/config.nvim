return {
    dir = "/home/kylec/Documents/github/nvim-surround/main",
    event = "VeryLazy",
    config = function()
        vim.cmd.highlight("default link NvimSurroundHighlight Todo")
        require("nvim-surround").setup()
    end,
}
