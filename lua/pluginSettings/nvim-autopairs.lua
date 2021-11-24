local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

npairs.setup({
  map_cr = true,
})

-- Don't autopair " when in a .tex file
npairs.remove_rule('"')
npairs.add_rules({
  Rule("\"", "\"", "-tex")
    :with_move()
})
