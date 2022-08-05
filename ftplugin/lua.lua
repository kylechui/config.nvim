local map = vim.keymap.set

vim.wo.colorcolumn = "120"

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

local ts_utils = require("nvim-treesitter.ts_utils")
require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { "vim.pretty_print(", ")" },
            find = "vim%.pretty_print%b()",
            delete = "^(vim%.pretty_print%()().-(%))()$",
            change = {
                target = "^(vim%.pretty_print%()().-(%))()$",
            },
        },
        ["F"] = {
            add = { "function() ", " end" },
            find = function()
                local root = ts_utils.get_node_at_cursor()
                while root and root:type() ~= "function_definition" do
                    root = root:parent()
                end
                if root then
                    local first_lnum, first_col, last_lnum, last_col = root:range()
                    return {
                        first_pos = { first_lnum + 1, first_col + 1 },
                        last_pos = { last_lnum + 1, last_col },
                    }
                end
            end,
            delete = "^(function%b())().-(end)()$",
            change = {
                target = "^(function%b())().-(end)()$",
            },
        },
    },
})
