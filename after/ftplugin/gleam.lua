vim.opt_local.shiftwidth = 2
vim.bo.commentstring = "// %s"

vim.keymap.set("n", "<C-CR>", function()
    vim.cmd("!exercism submit '%'")
end, { silent = true, buffer = true })

require("nvim-surround").buffer_setup({
    surrounds = {
        ["#"] = {
            add = { "#(", ")" },
            find = "#%b()",
            delete = "^(..)().-(.)()$",
        },
    },
})
