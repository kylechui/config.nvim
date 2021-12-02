local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

npairs.setup({
  map_cr = true,
})

-- Don't autopair " when in a .tex file
npairs.get_rule('"')[2]
    :with_pair(function()
        if vim.bo.filetype == 'tex' then
            return false
        end
    end)

-- Don't autopair ' when in a .tex file
npairs.get_rule('\'')[1]
    :with_pair(function()
        if vim.bo.filetype == 'tex' then
            return false
        end
    end)
