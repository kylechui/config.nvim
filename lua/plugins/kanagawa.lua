require("kanagawa").setup({
    globalStatus = true,
})
-- Make split boundaries thin and crisp
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NONE" })
