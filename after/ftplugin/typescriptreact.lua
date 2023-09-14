vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.textwidth = 120

require("nvim-surround").buffer_setup({
    surrounds = {
        p = {
            add = { "console.log(", ")" },
            find = "console%.log%b()",
            delete = "^(console%.log%()().-(%))()$",
        },
    },
})
