local in_mathzone = function()
    local current_node = vim.treesitter.get_node({ ignore_injections = false })
    while current_node do
        vim.print(current_node:type())
        if current_node:type() == "source_file" then
            return true
        end
        current_node = current_node:parent()
    end
    return false
end

local in_codeblock = function()
    local current_node = vim.treesitter.get_node({ ignore_injections = false })
    while current_node do
        if current_node:type() == "fenced_code_block" or current_node:type() == "code_span" then
            return true
        end
        current_node = current_node:parent()
    end
    return false
end

local in_text = function()
    return not in_mathzone() and not in_codeblock()
end

local GREEK_LETTERS = {}
GREEK_LETTERS["a"] = "alpha"
GREEK_LETTERS["b"] = "beta"
GREEK_LETTERS["d"] = "delta"
GREEK_LETTERS["e"] = "varepsilon"
GREEK_LETTERS["g"] = "gamma"
GREEK_LETTERS["l"] = "lambda"
GREEK_LETTERS["o"] = "omega"
GREEK_LETTERS["s"] = "sigma"
GREEK_LETTERS["t"] = "tau"

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
}, {
    -- Markdown: Headers
    s({ trig = "^%s*h(%d)", regTrig = true }, {
        f(function(_, snip)
            return string.rep("#", snip.captures[1])
        end),
    }, { condition = in_text }),
    -- LaTeX: Inline math mode
    s("mm", fmt("${}$", i(1)), { condition = in_text }),
    -- LaTeX: Display math mode
    s("dm", {
        t({ "$$", "" }),
        i(0),
        t({ "", "$$" }),
    }, { condition = in_text }),
    -- LaTeX: Single-letter variables
    s(
        { trig = " ([b-hj-zB-HJ-Z])([%p%s])", regTrig = true, wordTrig = false },
        f(function(_, snip)
            return " $" .. snip.captures[1] .. "$" .. snip.captures[2]
        end),
        { condition = in_text }
    ),
    -- LaTeX: Math blackboard font
    s({ trig = "\\(%u)", regTrig = true, wordTrig = false }, {
        f(function(_, snip)
            return "\\mathbb{" .. snip.captures[1] .. "}"
        end),
    }, { condition = in_mathzone }),
    -- LaTeX: Lowercase greek letters
    s({ trig = ";(%l)", regTrig = true, wordTrig = false }, {
        f(function(_, snip)
            if GREEK_LETTERS[snip.captures[1]] then
                return "\\" .. GREEK_LETTERS[snip.captures[1]]
            end
            return ""
        end),
    }, { condition = in_mathzone }),
    -- LaTeX: Uppercase greek letters
    s({ trig = ";(%u)", regTrig = true, wordTrig = false }, {
        f(function(_, snip)
            local greek_letter = GREEK_LETTERS[string.lower(snip.captures[1])]
            if greek_letter then
                return "\\" .. greek_letter:gsub("^%l", string.upper)
            end
            return ""
        end),
    }, { condition = in_mathzone }),
    -- LaTeX: Single-digit subscripts
    s(
        { trig = "(%a)(%d)", regTrig = true, wordTrig = false },
        f(function(_, snip)
            return snip.captures[1] .. "_" .. snip.captures[2]
        end),
        { condition = in_mathzone }
    ),
    -- LaTeX: Math subscripts
    s({ trig = "__", wordTrig = false }, {
        t("_{"),
        i(1),
        t("}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Math superscripts
    s({ trig = "^^", wordTrig = false }, {
        t("^{"),
        i(1),
        t("}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Math exponents
    s({ trig = "^-", wordTrig = false }, {
        t("^{-"),
        i(1),
        t("}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Less than or equal to
    s({ trig = "<=", wordTrig = false }, t("\\leq"), { condition = in_mathzone }),
    -- LaTeX: Greater than or equal to
    s({ trig = ">=", wordTrig = false }, t("\\geq"), { condition = in_mathzone }),
    -- LaTeX: Times
    s({ trig = "xx", wordTrig = false }, t("\\times "), { condition = in_mathzone }),
    -- LaTeX: Otimes
    s({ trig = "ox", wordTrig = false }, t("\\otimes "), { condition = in_mathzone }),
    -- LaTeX: Oplus
    s({ trig = "o+", wordTrig = false }, t("\\oplus "), { condition = in_mathzone }),
    -- LaTeX: Center dot
    s({ trig = "**", wordTrig = false }, t("\\cdot "), { condition = in_mathzone }),
    -- LaTeX: Math boldface
    s("bf", fmt([[\mathbf{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Romanized math
    s("rm", fmt([[\mathrm{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Math calligraphy
    s("mcal", fmt([[\mathcal{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Math script
    s("mscr", fmt([[\mathscr{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Math text
    s({ trig = "tt", wordTrig = false }, fmt([[\text{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Teletype text
    s({ trig = "TT", wordTrig = false }, fmt([[\texttt{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Binomial Coefficient
    s({ trig = "binom", wordTrig = false }, fmt([[\binom{{{}}}{{{}}}]], { i(1), i(2) }), { condition = in_mathzone }),
    -- LaTeX: Parenthesis-delimited fractions
    s({ trig = "(%b())/", regTrig = true, wordTrig = false }, {
        d(1, function(_, snip)
            return sn(
                1,
                fmt(
                    [[
                    \frac{{{}}}{{{}}}
                ]],
                    {
                        t(string.sub(snip.captures[1], 2, #snip.captures[1] - 1)),
                        i(1),
                    }
                )
            )
        end, {}),
    }, { condition = in_mathzone }),
    -- TODO: Make more generalized
    -- LaTeX: Brace-delimited fractions pt. 1
    s({ trig = "(\\frac%b{}%b{})/", regTrig = true, wordTrig = false }, {
        d(1, function(_, snip)
            return sn(
                1,
                fmt(
                    [[
                    \frac{{{}}}{{{}}}
                ]],
                    {
                        t(snip.captures[1]),
                        i(1),
                    }
                )
            )
        end, {}),
    }, { condition = in_mathzone }),
    -- LaTeX: Brace-delimited fractions pt. 2
    s({ trig = "(\\%a+%b{})/", regTrig = true, wordTrig = false }, {
        d(1, function(_, snip)
            return sn(
                1,
                fmt(
                    [[
                    \frac{{{}}}{{{}}}
                ]],
                    {
                        t(snip.captures[1]),
                        i(1),
                    }
                )
            )
        end, {}),
    }, { condition = in_mathzone }),
    -- LaTeX: Regexp fractions
    s({ trig = "([%a%d^_\\!'.]+)/", regTrig = true, wordTrig = false }, {
        d(1, function(_, snip)
            return sn(1, {
                t("\\frac{"),
                t(snip.captures[1]),
                t("}{"),
                i(1),
                t("}"),
            })
        end, {}),
    }, { condition = in_mathzone }),
    -- LaTeX: Visual fractions
    s("/", {
        d(1, function(_, snip)
            if snip.env.TM_SELECTED_TEXT[1] then
                return sn(1, {
                    t("\\frac{" .. snip.env.TM_SELECTED_TEXT[1] .. "}{"),
                    i(1),
                    t("}"),
                })
            end
            return sn(nil, t("/"))
        end),
    }, { condition = in_mathzone }),
    -- LaTeX: Binary operator dots
    s(".b", t("\\dotsb"), { condition = in_mathzone }),
    -- LaTeX: Comma-separating dots
    s(".c", t("\\dotsc"), { condition = in_mathzone }),
    -- LaTeX: Square root
    s({ trig = "sqrt", wordTrig = false }, {
        t("\\sqrt{"),
        i(1),
        t("}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Parentheses
    s({ trig = "paren", wordTrig = false }, {
        t("\\left("),
        i(1),
        t("\\right)"),
    }, { condition = in_mathzone }),
    -- LaTeX: Vector
    s({ trig = "vec", wordTrig = false }, {
        t("\\vec{"),
        i(1),
        t("}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Postfix hat
    s({ trig = "(\\?[%a%d^_]+)hat", regTrig = true, wordTrig = false }, {
        f(function(_, snip)
            return "\\hat{" .. snip.captures[1] .. "}"
        end),
    }, { condition = in_mathzone }),
    -- LaTeX: Set notation
    s({ trig = "([^\\])set", regTrig = true }, {
        f(function(_, snip)
            return snip.captures[1]
        end),
        t("\\left\\{"),
        i(1),
        t("\\right\\}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Tuple
    s({ trig = "tup", wordTrig = false }, {
        t("\\left\\langle"),
        i(1),
        t("\\right\\rangle"),
    }, { condition = in_mathzone }),
    -- LaTeX: Vector norm
    s({ trig = "norm", wordTrig = false }, {
        t("\\left\\lVert"),
        i(1),
        t("\\right\\rVert"),
    }, { condition = in_mathzone }),
    -- LaTeX: Absolute Value
    s({ trig = "abs", wordTrig = false }, {
        t("|"),
        i(1),
        t("|"),
    }, { condition = in_mathzone }),
    -- LaTeX: General environment
    s(
        { trig = "^(%s*)beg", regTrig = true },
        fmt(
            [[
            {}\begin{{{}}}
            {}  {}
            {}\end{{{}}}
        ]],
            {
                f(function(_, snip)
                    return snip.captures[1]
                end),
                i(1),
                f(function(_, snip)
                    return snip.captures[1]
                end),
                i(0),
                f(function(_, snip)
                    return snip.captures[1]
                end),
                rep(1),
            }
        ),
        { condition = in_mathzone }
    ),
    -- LaTeX: Align environment
    s(
        { trig = "^(%s*)ali", regTrig = true },
        fmt(
            [[
            {}\begin{{align*}}
            {}  {}
            {}\end{{align*}}
    ]],
            {
                f(function(_, snip)
                    return snip.captures[1]
                end),
                f(function(_, snip)
                    return snip.captures[1]
                end),
                i(0),
                f(function(_, snip)
                    return snip.captures[1]
                end),
            }
        )
    ),
}
