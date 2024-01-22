local map = vim.keymap.set

local open_term = function(command)
    vim.cmd("belowright 15split +term | startinsert")
    local cr = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    vim.api.nvim_feedkeys(command .. cr, "n", true)
end

map("n", "<C-'>", function()
    -- Get the file path (without extension)
    local file = vim.api.nvim_buf_get_name(0):match("^(.*)%.rs")
    local cmd = {
        "rustc",
        "'" .. file .. ".rs'",
        "&&",
        "time",
        "'" .. file .. "'",
    }
    open_term(table.concat(cmd, " "))
end, { silent = true, buffer = true })

require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { "println!(", ")" },
            find = "println!%b()",
            delete = "^(println!%()().-(%))()$",
            change = {
                target = "^(println!)()%(.-%)()()$",
                replacement = function()
                    return { { "println!" }, { "" } }
                end,
            },
        },
    },
})
