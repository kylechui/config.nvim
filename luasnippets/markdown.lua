---@diagnostic disable: undefined-global

local ts_utils = require("nvim-treesitter.ts_utils")

-- TODO: Fix jank
-- There probably is a better way to get the root node of the node at the cursor
local in_html = function()
    local cur = ts_utils.get_node_at_cursor()
    while cur:parent() ~= nil do
        cur = cur:parent()
    end
    return cur and cur:type() == "fragment"
end

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
    -- Markdown: Less than or equal to
    s("<=", t("&leq;")),
    -- Markdown: Greater than or equal to
    s(">=", t("&geq;")),
    -- Markdown: Bold
    s("", {
        t("<b>"),
        i(1),
        t("</b>"),
    }, { condition = in_html }),
    s("", {
        t("**"),
        i(1),
        t("**"),
    }, { condition = not in_html }),
    -- TODO: Markdown: Italics
    s("<C-i>", {
        t("<i>"),
        i(1),
        t("</i>"),
    }, { condition = in_html }),
    s("<C-i>", {
        t("*"),
        i(1),
        t("*"),
    }, { condition = not in_html }),
    -- Markdown: Code
    s("`", {
        t("<code>"),
        i(1),
        t("</code>"),
    }, { condition = in_html }),
    -- Markdown: Headers
    s({ trig = "^%s*h(%d)", regTrig = true }, {
        f(function(_, snip)
            return string.rep("#", snip.captures[1])
        end),
    }),
}
