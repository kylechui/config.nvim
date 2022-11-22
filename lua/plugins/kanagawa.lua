local ok, kanagawa = pcall(require, "kanagawa")
if not ok then
    print("Failed to load kanagawa.nvim")
    return
end

kanagawa.setup({
    globalStatus = true,
})
-- Emphasize window separators
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NONE" })
