return {
    "lukas-reineke/indent-blankline.nvim",
    version = "^3.3.7",
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
