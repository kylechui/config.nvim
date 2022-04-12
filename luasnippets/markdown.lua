---@diagnostic disable: undefined-global

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
