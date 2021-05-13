-- Don't spawn a matching delimiter if cursor precedes alphanumeric character
require('nvim-autopairs').setup({ ignored_next_char = "[%w]"})
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

-- I already have an UltiSnips macro for this
npairs.remove_rule('"', {"tex", "latex"})

-- skip it, if you use another global object
_G.MUtils = {}

MUtils.smart_cr=function()
  if vim.fn.pumvisible() ~= 0  then
      return npairs.esc('<CR>')
  else
    return npairs.autopairs_cr()
  end
end
