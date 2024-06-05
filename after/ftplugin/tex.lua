vim.opt_local.spell = true
vim.opt_local.colorcolumn = "0"
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

vim.keymap.set("n", "<C-CR>", "<Cmd>VimtexCompile<CR>", { buffer = true })
vim.keymap.del("i", "]]", { buffer = true })

vim.keymap.set("n", "K", function()
    local curpos = vim.api.nvim_win_get_cursor(0)
    curpos[2] = curpos[2] + 1
    local file = vim.fn.expand("%:p:r"):gsub(" ", "\\ ")
    vim.fn.jobstart(
        "zathura --synctex-forward "
            .. tostring(curpos[1])
            .. ":"
            .. tostring(curpos[2])
            .. ":"
            .. file
            .. ".tex "
            .. file
            .. ".pdf",
        { detach = true }
    )
end, { buffer = true })

local config = require("nvim-surround.config")
require("nvim-surround").buffer_setup({
    surrounds = {
        ['"'] = {
            add = { "``", "''" },
            find = "``.-''",
            delete = "^(``)().-('')()$",
        },

        ["Q"] = {
            add = { "``", "''" },
            find = "``.-''",
            delete = "^(``)().-('')()$",
        },
        ["q"] = {
            add = { "`", "'" },
            find = "`.-'",
            delete = "^(`)().-(')()$",
        },
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
        ["e"] = {
            add = function()
                local env = config.get_input("Enter an environment: ")
                return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
            end,
            find = function()
                return config.get_selection({
                    node = "generic_environment",
                })
            end,
            delete = [[^(\begin%b{})().*(\end%b{})()$]],
            change = {
                target = [[^\begin{(.-)()%}.*\end{(.-)()}$]],
                replacement = function()
                    local env = require("nvim-surround.config").get_input("Environment: ")
                    return { { env }, { env } }
                end,
            },
        },
    },
})
