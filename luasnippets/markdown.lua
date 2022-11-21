---@diagnostic disable: undefined-global

return {
    -- Markdown: Definition comment tag
    s(
        "defn",
        fmt(
            [[
            <!-- Definition: {} -->

            > **{}:** {}
        ]],
            {
                i(1),
                rep(1),
                i(0),
            }
        )
    ),
    -- Markdown: Embed image
    s("img", {
        t("![](./"),
        i(0),
        t(")"),
    }),
    -- Markdown: Left arrow
    s("<-", t("←")),
    -- Markdown: Right arrow
    s("->", t("→")),
    -- Markdown: Left double arrow
    s("<=", t("⇐")),
    -- Markdown: Right double arrow
    s("=>", t("⇒")),
    -- Markdown: Less than or equal to
    s("<=", t("≤")),
    -- Markdown: Greater than or equal to
    s(">=", t("≥")),
},
    {
        -- Markdown: Headers
        s({ trig = "^%s*h(%d)", regTrig = true }, {
            f(function(_, snip)
                return string.rep("#", snip.captures[1])
            end),
        }),
    }
