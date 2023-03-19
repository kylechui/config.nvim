return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        globalStatus = true,
    },
    config = function()
        vim.cmd.colorscheme("kanagawa")

        local hl = vim.api.nvim_set_hl
        local palette = require("kanagawa.colors").setup().palette
        hl(0, "WinSeparator", { fg = "NONE" })
        hl(0, "TelescopeBorder", { fg = palette.sumiInk0, bg = palette.sumiInk0 })
        hl(0, "TelescopeNormal", { fg = palette.fujiWhite, bg = palette.sumiInk0 })
        hl(0, "TelescopePromptBorder", { fg = palette.sumiInk2, bg = palette.sumiInk2 })
        hl(0, "TelescopePromptNormal", { fg = palette.fujiWhite, bg = palette.sumiInk2 })
        hl(0, "TelescopeSelection", { fg = palette.fujiWhite, bg = palette.sumiInk2 })
        hl(0, "TelescopePreviewTitle", { fg = palette.sumiInk2, bg = palette.oniViolet })
        hl(0, "TelescopePromptTitle", { fg = palette.sumiInk2, bg = palette.sakuraPink })
    end,
}
