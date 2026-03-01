return {
    [1] = "kylechui/nvim-surround",
    config = function()
        require("nvim-surround").setup({
            move_cursor = "sticky",
        })
    end,
}
