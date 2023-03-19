return {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
        show_end_of_line = true,
        show_current_context = true,
    },
    config = function()
        vim.opt.listchars:append("eol:↲")
        vim.opt.listchars:append("trail:•")
    end,
}
