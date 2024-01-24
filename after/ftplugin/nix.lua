vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

require("nvim-surround").buffer_setup({
    surrounds = {
        ["$"] = {
            add = { "${", "}" },
            find = "$%b{}",
            delete = "^(%${)().-(})()$",
        },
    },
})
