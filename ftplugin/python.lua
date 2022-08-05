local map = vim.keymap.set

map("n", "<C-\">", "<Cmd>term time python3 %<CR>", {
    silent = true,
    buffer = true,
})
map("n", "<C-CR>", "<Cmd>term time python3 %<input.txt<CR><Cmd>term time ./%:r.out<input.txt<CR>", {
    silent = true,
    buffer = true,
})

require("nvim-surround").buffer_setup({
    delimiters = {
        pairs = {
            ["F"] = function()
                return {
                    "def " .. require("nvim-surround.utils").get_input(
                        "Enter the function name: "
                    ) .. "(",
                    { "):", "   return None" }
                }
            end,
        }
    }
})
