local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then
    print("Failed to load indent-blankline.nvim")
    return
end

local opt = vim.opt
opt.listchars:append("eol:↲")
opt.listchars:append("trail:•")

indent_blankline.setup({
    show_end_of_line = true,
    show_current_context = true,
})
