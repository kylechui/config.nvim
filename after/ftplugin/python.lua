local map = vim.keymap.set

map("n", "<C-'>", function()
    vim.cmd.term("python3 '%'")
end, {
    silent = true,
    buffer = true,
})

map("n", "<C-CR>", "<Cmd>term time python3 %<input.txt<CR><Cmd>term time ./%:r.out<input.txt<CR>", {
    silent = true,
    buffer = true,
})

require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { "print(", ")" },
            find = "print%b()",
            delete = "^(print%()().-(%))()$",
            change = {
                target = "^(print)().-()()$",
                replacement = function()
                    return { { "print" }, { "" } }
                end,
            },
        },
        --[[ ["F"] = {
            add = { "function() ", " end" },
            find = function()
                return require("nvim-surround.config").get_selection({ node = "function_definition" })
            end,
            delete = "^(function%b())().-(end)()$",
        }, ]]
    },
})
