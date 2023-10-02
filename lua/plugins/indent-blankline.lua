return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = {
        indent = {
            char = "┆",
        },
    },
    init = function()
        vim.opt.list = true
        vim.opt.listchars:append("eol:↲")
        vim.opt.listchars:append("trail:•")
    end,
}
