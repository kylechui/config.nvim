---@diagnostic disable: undefined-global

local GREEK_LETTERS = {}
GREEK_LETTERS["a"] = "alpha"
GREEK_LETTERS["b"] = "beta"
GREEK_LETTERS["d"] = "delta"
GREEK_LETTERS["e"] = "eps"
GREEK_LETTERS["g"] = "gamma"
GREEK_LETTERS["l"] = "lam"
GREEK_LETTERS["o"] = "omega"
GREEK_LETTERS["s"] = "sigma"
GREEK_LETTERS["t"] = "tau"

--[[ local MATH_MODES = {
    displayed_equation = true,
    inline_formula = true,
    math_environment = true,
}

-- TS isn't updating the syntax tree on edit
local ts_utils = require("nvim-treesitter.ts_utils")
local in_math = function()
    local cur = ts_utils.get_node_at_cursor()
    while cur do
        if MATH_MODES[cur:type()] then
            return true
        end
        cur = cur:parent()
    end
    return false
end ]]

local in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local in_align = function()
    return vim.fn["vimtex#env#is_inside"]("align")[1] ~= 0
end

return nil, {
    -- LaTeX: Lowercase greek letters
    s({ trig = ";(%l)", regTrig = true }, {
        f(function(_, snip)
            if GREEK_LETTERS[snip.captures[1]] then
                return "\\" .. GREEK_LETTERS[snip.captures[1]]
            end
            return ""
        end)
    }, { condition = in_mathzone }),
    -- LaTeX: Uppercase greek letters
    s({ trig = ";(%u)", regTrig = true }, {
        f(function(_, snip)
            local greek_letter = GREEK_LETTERS[string.lower(snip.captures[1])]
            if greek_letter then
                return "\\" .. greek_letter:gsub("^%l", string.upper)
            end
            return ""
        end)
    }, { condition = in_mathzone }),
    -- LaTeX: Single-digit subscripts
    s({ trig = "(%a)(%d)", regTrig = true, wordTrig = false },
        f(function(_, snip)
            return snip.captures[1] .. "_" .. snip.captures[2]
        end), { condition = in_mathzone }
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
    s({ trig = "<=", wordTrig = false },
        t("\\leq"),
        { condition = in_mathzone }
    ),
    -- LaTeX: Greater than or equal to
    s({ trig = ">=", wordTrig = false },
        t("\\geq"), { condition = in_mathzone }
    ),
    -- LaTeX: Times
    s({ trig = "xx", wordTrig = false },
        t("\\times "), { condition = in_mathzone }
    ),
    -- LaTeX: Center dot
    s({ trig = "**", wordTrig = false },
        t("\\cdot "), { condition = in_mathzone }
    ),
    -- LaTeX: Math boldface
    s("bf", fmt([[\mathbf{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Romanized math
    s("rm", fmt([[\mathrm{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Math calligraphy
    s("mcal", fmt([[\mathcal{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Math script
    s("mscr", fmt([[\mathscr{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Math text
    s({ trig = "tt", wordTrig = false },
        fmt([[\text{{{}}}]], i(1)), { condition = in_mathzone }
    ),
    -- LaTeX: Parenthesis-delimited fractions
    s({ trig = "(%b())/", regTrig = true, wordTrig = false }, {
        d(1, function(_, snip)
            return sn(1, fmt(
                [[
                    \frac{{{}}}{{{}}}
                ]],
                {
                    t(string.sub(snip.captures[1], 2, #snip.captures[1] - 1)),
                    i(1),
                }
            ))
        end, {})
    }, { condition = in_mathzone }),
    -- TODO: Make more generalized
    -- LaTeX: Brace-delimited fractions pt. 1
    s({ trig = "(\\frac%b{}%b{})/", regTrig = true, wordTrig = false }, {
        d(1, function(_, snip)
            return sn(1, fmt(
                [[
                    \frac{{{}}}{{{}}}
                ]],
                {
                    t(snip.captures[1]),
                    i(1),
                }
            ))
        end, {})
    }, { condition = in_mathzone }),
    -- LaTeX: Brace-delimited fractions pt. 2
    s({ trig = "(\\%a+%b{})/", regTrig = true, wordTrig = false }, {
        d(1, function(_, snip)
            return sn(1, fmt(
                [[
                    \frac{{{}}}{{{}}}
                ]],
                {
                    t(snip.captures[1]),
                    i(1),
                }
            ))
        end, {})
    }, { condition = in_mathzone }),
    -- LaTeX: Regexp fractions
    s({ trig = "([%a%d^_\\!']+)/", regTrig = true, wordTrig = false }, {
        d(1, function(_, snip)
            return sn(1, {
                t("\\frac{"),
                t(snip.captures[1]),
                t("}{"),
                i(1),
                t("}"),
            })
        end, {})
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
        end)
    }, { condition = in_mathzone }),
    -- LaTeX: Binary operator dots
    s(".b", t("\\dotsb"), { condition = in_mathzone }),
    -- LaTeX: Comma-separating dots
    s(".c", t("\\dotsc"), { condition = in_mathzone }),
    -- LaTeX: Square root
    s("sqrt", {
        t("\\sqrt{"),
        i(1),
        t("}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Parentheses
    s("paren", {
        t("\\paren{"),
        i(1),
        t("}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Vector
    s("vec", {
        t("\\vec{"),
        i(1),
        t("}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Set notation
    s("set", {
        t("\\set{"),
        i(1),
        t("}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Vector norm
    s("norm", {
        t("\\norm{"),
        i(1),
        t("}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Absolute Value
    s("abs", {
        t("\\abs{"),
        i(1),
        t("}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Auto-aligned equals
    s({ trig = "([^&])=", regTrig = true, wordTrig = false },
        f(function(_, snip)
            return snip.captures[1] .. "&="
        end), { condition = in_align }
    ),
    -- LaTeX: Summations
    s({ trig = "([^\\])sum", regTrig = true },
        d(1, function(_, snip)
            return sn(1, fmt(
                [[
                    {}\sum_{{{}={}}}^{{{}}}
                ]],
                {
                    t(snip.captures[1]),
                    i(1, "i"),
                    i(2, "1"),
                    i(3, "\\infty"),
                }
            ))
        end), { condition = in_mathzone }
    ),
    -- LaTeX: Limits
    s({ trig = "([^\\])lim", regTrig = true },
        d(1, function(_, snip)
            return sn(1, fmt(
                [[
                    {}\lim_{{{}\to {}}}
                ]],
                {
                    t(snip.captures[1]),
                    i(1, "n"),
                    i(2, "\\infty"),
                }
            ))
        end), { condition = in_mathzone }
    ),
    -- LaTeX: Functions
    s({ trig = "(%a):", regTrig = true, wordTrig = false }, {
        d(1, function(_, snip)
            return sn(1, {
                t(snip.captures[1] .. "\\colon "),
                i(1, "\\R"),
                t("\\to "),
                i(2, "\\R"),
            })
        end)
    }, { condition = in_mathzone }),
}
