local ls = require("luasnip")
-- local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep
-- local c = ls.choice_node
-- local d = ls.dynamic_node
local f = ls.function_node
-- local i = ls.insert_node
local s = ls.s
-- local sn = ls.sn
-- local t = ls.text_node

return {
    -- All: Prints the current date in Y-m-d format
    s(
        "date",
        f(function()
            return os.date("%Y-%m-%d")
        end)
    ),
}, nil
