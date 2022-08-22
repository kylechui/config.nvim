vim.opt_local.spell = true
vim.opt_local.colorcolumn = "0"
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

vim.keymap.set("n", "<C-CR>", "<Cmd>VimtexCompile<CR>", { buffer = true })

local config = require("nvim-surround.config")
require("nvim-surround").buffer_setup({
    surrounds = {
        ["c"] = {
            add = function()
                local cmd = config.get_input("Enter a command: ")
                return { { "\\" .. cmd .. "{" }, { "}" } }
            end,
            find = "\\%a+%b{}",
            delete = "^(\\%a+{)().-(})()$",
            change = {
                target = "^\\(%a+)(){.-}()()$",
                replacement = function()
                    local cmd = config.get_input("Enter a command: ")
                    return { { cmd }, { "" } }
                end,
            },
        },
    },
})
