local map = vim.keymap.set

vim.wo.colorcolumn = "120"

map("n", "<C-'>", "<Cmd>source %<CR>", { silent = true, buffer = true })
map("n", "<Leader>t", function()
    local cur_path = vim.fn.expand("%:p:h")
    while cur_path and vim.fn.finddir("tests", cur_path) == "" do
        cur_path = cur_path:match("(.*)/.*")
    end

    if cur_path then
        require("plenary.test_harness").test_directory(cur_path .. "/tests", {
            minimal_init = cur_path .. "/tests/minimal_init.lua",
        })
    end
end, {
    silent = true,
    buffer = true,
})

require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { "vim.pretty_print(", ")" },
            find = "vim%.pretty_print%b()",
            delete = "^(vim%.pretty_print%()().-(%))()$",
        },
        ["F"] = {
            add = { "function() ", " end" },
            find = function()
                return require("nvim-surround.config").get_selection({ node = "function_definition" })
            end,
            delete = "^(function%b())().-(end)()$",
        },
    },
})
