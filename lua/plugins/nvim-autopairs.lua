local npairs = require("nvim-autopairs")

npairs.setup()

-- Don't autopair ' when in a .tex file
npairs.get_rule("'")[1]:with_pair(function()
    if vim.bo.filetype == "tex" then
        return false
    end
end)

-- Don't autopair " when in a .tex file
npairs.get_rule("\"")[1]:with_pair(function()
    if vim.bo.filetype == "tex" then
        return false
    end
end)
