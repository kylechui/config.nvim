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
        pairs = {
            ["l"] = function()
                return {
                    "[",
                    "](" .. vim.fn.getreg("*") .. ")",
                }
            end,
            ["f"] = function()
                local cur = ts_utils.get_node_at_cursor(0, true)
                while cur and cur:type() ~= "fenced_code_block" do
                    cur = cur:parent()
                end

                local language = nil
                if cur then
                    for child_node in cur:iter_children() do
                        if child_node:type() == "info_string" then
                            language = query.get_node_text(child_node:child(0), 0)
                        end
                    end
                end

                if language == "cpp" then
                    local input = surr_utils.get_input("Enter a function name: ")
                    if input then
                        return {
                            "auto " .. input .. " = [](",
                            {
                                "){",
                                "    return 0;",
                                "}",
                            }
                        }
                    end
                elseif language == "lua" then
                    local input = surr_utils.get_input("Enter a function name: ")
                    if input then
                        return {
                            "local " .. input .. " = function(",
                            {
                                ")",
                                "    return nil",
                                "end",
                            }
                        }
                    end
                elseif language == "python" then
                    local input = surr_utils.get_input("Enter a function name: ")
                    if input then
                        return {
                            input .. " = lambda ",
                            {
                                ":",
                                "    return NULL"
                            }
                        }
                    end
                end
                return { "", "" }
            end,
        },
    },
})
