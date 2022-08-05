vim.opt_local.spell = true
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.textwidth = 80

vim.keymap.set("n", "<C-CR>", "<Cmd>MarkdownPreview<CR>", { buffer = true })

local surr_utils = require("nvim-surround.utils")
local ts_utils = require("nvim-treesitter.ts_utils")
local query = vim.treesitter.query

require("nvim-surround").buffer_setup({
    delimiters = {
        ["l"] = {
            add = function()
                return {
                    { "[" },
                    { "](" .. vim.fn.getreg("+"):gsub("\n", "") .. ")" },
                }
            end,
            find = function()
                return require("nvim-surround.config").get_selection({ pattern = "%b[]%b()" })
            end,
            delete = function()
                return require("nvim-surround.config").get_selections({ char = "l", pattern = "^(%[)().-(%]%b())()$" })
            end,
            change = {
                target = function()
                    return require("nvim-surround.config").get_selections({
                        char = "l",
                        pattern = "^()()%b[]%((.-)()%)$",
                    })
                end,
                replacement = function()
                    return {
                        { "" },
                        { vim.fn.getreg("+"):gsub("\n", "") .. "" },
                    }
                end,
            },
        },
    },
})
