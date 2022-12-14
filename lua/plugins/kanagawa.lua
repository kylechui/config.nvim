local ok, kanagawa = pcall(require, "kanagawa")
if not ok then
    print("Failed to load kanagawa.nvim")
    return
end

kanagawa.setup({
    globalStatus = true,
})
local hl = vim.api.nvim_set_hl
-- Emphasize window separators
hl(0, "WinSeparator", { fg = "NONE" })

-- Telescope theming
local colors = require("kanagawa.colors").setup()
hl(0, "TelescopeBorder", { fg = colors.sumiInk0, bg = colors.sumiInk0 })
hl(0, "TelescopeNormal", { fg = colors.fujiWhite, bg = colors.sumiInk0 })
hl(0, "TelescopePromptBorder", { fg = colors.sumiInk2, bg = colors.sumiInk2 })
hl(0, "TelescopePromptNormal", { fg = colors.fujiWhite, bg = colors.sumiInk2 })
hl(0, "TelescopeSelection", { fg = colors.fujiWhite, bg = colors.sumiInk2 })
hl(0, "TelescopePreviewTitle", { fg = colors.sumiInk2, bg = colors.oniViolet })
hl(0, "TelescopePromptTitle", { fg = colors.sumiInk2, bg = colors.sakuraPink })
