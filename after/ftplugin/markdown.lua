vim.opt_local.spell = true
vim.opt_local.conceallevel = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.textwidth = 80

vim.keymap.set("n", "<C-CR>", "<Cmd>MarkdownPreview<CR>", { buffer = true })
vim.keymap.set("n", "<Leader>u", function()
    require("cmp_dictionary").update()
end, { buffer = true })

require("nvim-surround").buffer_setup({
    surrounds = {
        ["l"] = {
            add = function()
                local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                return {
                    { "[" },
                    { "](" .. clipboard .. ")" },
                }
            end,
            find = "%b[]%b()",
            delete = "^(%[)().-(%]%b())()$",
            change = {
                target = "^()()%b[]%((.-)()%)$",
                replacement = function()
                    local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                    return {
                        { "" },
                        { clipboard },
                    }
                end,
            },
        },
        ["n"] = {
            add = function()
                local title = vim.fn.input("Note title: ")
                return {
                    { "[[" .. title .. "|" },
                    { "]]" },
                }
            end,
            find = "%[%b[]%]",
            delete = "^([^|]+|)().-(%]%])()$",
            change = {
                target = "^%[%[([^|]+)().-()()$",
                replacement = function()
                    local title = vim.fn.input("Note title: ")
                    return {
                        { title },
                        { "" },
                    }
                end,
            },
        },
    },
})
