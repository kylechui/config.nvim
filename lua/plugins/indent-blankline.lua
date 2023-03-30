return {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    opts = {
        show_end_of_line = true,
        show_current_context = true,
        show_current_context_start = true,
        char = "┆",
    },
    init = function()
        vim.opt.list = true
        vim.opt.listchars:append("eol:↲")
        vim.opt.listchars:append("trail:•")
    end,
}
