local map = vim.keymap.set

vim.opt_local.colorcolumn = "120"

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
map("n", "<Leader>T", "<Plug>PlenaryTestFile")

require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { "vim.print(", ")" },
            find = function()
                return require("nvim-surround.config").get_selection({
                    query = { capture = "@pretty_print", type = "function_calls" },
                })
            end,
            delete = "^(vim%.print%()().-(%))()$",
            change = {
                target = "^(vim%.print)()%(.-%)()()$",
                replacement = function()
                    return { { "print" }, { "" } }
                end,
            },
        },
    },
})
