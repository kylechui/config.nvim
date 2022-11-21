vim.opt_local.spell = true
vim.opt_local.colorcolumn = "0"
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

vim.keymap.set("n", "<C-CR>", "<Cmd>VimtexCompile<CR>", { buffer = true })

--[[ local config = require("nvim-surround.config")
require("nvim-surround").buffer_setup({
    surrounds = {
        ['"'] = {
            add = { "``", "''" },
            find = "``.-''",
            delete = "^(``)().-('')()$",
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
    },
}) ]]
local config = require("nvim-surround.config")

require("nvim-surround").buffer_setup({
  surrounds = {
    ["e"] = {
      add = function()
        local env = require("nvim-surround.config").get_input("Environment: ")
        return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
      end,
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
    ["b"] = {
      add = function()
        if vim.fn["vimtex#syntax#in_mathzone"]() == 1 then
          return { { "\\mathbf{" }, { "}" } }
        end
        return { { "\\textbf{" }, { "}" } }
      end,
      find = "\\%a-bf%b{}",
      delete = "^(\\%a-bf{)().-(})()$",
    },
    ["i"] = {
      add = function()
        if vim.fn["vimtex#syntax#in_mathzone"]() == 1 then
          return { { "\\mathit{" }, { "}" } }
        end
        return { { "\\textit{" }, { "}" } }
      end,
      find = "\\%a-it%b{}",
      delete = "^(\\%a-it{)().-(})()$",
    },
    ["s"] = {
      add = { "\\textsc{", "}" },
      find = "\\textsc%b{}",
      delete = "^(\\textsc{)().-(})()$",
    },
    ["t"] = {
      add = function()
        if vim.fn["vimtex#syntax#in_mathzone"]() == 1 then
          return { { "\\mathtt{" }, { "}" } }
        end
        return { { "\\texttt{" }, { "}" } }
      end,
      find = "\\%a-tt%b{}",
      delete = "^(\\%a-tt{)().-(})()$",
    },
    ["$"] = {
      add = { "$ ", " $" },
      find = function()
        return config.get_selection({ motion = "a$" })
      end,
      delete = "^($)().-($)()$",
    },
  },
})
