local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local f = ls.function_node
local i = ls.insert_node
local s = ls.s
-- local sn = ls.sn
local t = ls.text_node

return {
    -- Markdown: Definition comment tag
    s("defn", fmt(
        [[
            <!-- Definition: {} -->

            > **{}:** {}
        ]],
        {
            i(1),
            rep(1),
            i(0),
        }
    )),
}, {
    -- Markdown: Left arrow
    s("<-", t("&larr;")),
    -- Markdown: Right arrow
    s("->", t("&rarr;")),
    -- Markdown: Bold
    s("", {
        t("**"),
        i(1),
        t("**"),
    }),
    -- TODO: Markdown: Italics
    s("<C-I>", {
        t("*"),
        i(1),
        t("*"),
    }),
}
