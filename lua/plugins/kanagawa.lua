return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        globalStatus = true,
    },
    config = function()
        vim.cmd.colorscheme("kanagawa")
    end,
}
