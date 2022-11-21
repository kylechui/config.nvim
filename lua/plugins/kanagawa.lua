require("kanagawa").setup({
    globalStatus = true,
})
-- Emphasize window separators
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NONE" })
