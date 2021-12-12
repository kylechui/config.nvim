local npairs = require('nvim-autopairs')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
local Rule = require('nvim-autopairs.rule')

npairs.setup({})
-- If you want insert `(` after select function or method item
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
-- cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

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
