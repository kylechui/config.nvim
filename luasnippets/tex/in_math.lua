local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep
local c = ls.choice_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local s = ls.s
local sn = ls.sn
local t = ls.text_node

local in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local in_align = function()
    return vim.fn["vimtex#env#is_inside"]("align")[1] ~= 0
end

local greek_vars = {}
greek_vars["a"] = "alpha"
greek_vars["b"] = "beta"
greek_vars["d"] = "delta"
greek_vars["e"] = "eps"
greek_vars["g"] = "gamma"
greek_vars["l"] = "lam"
greek_vars["o"] = "omega"
greek_vars["s"] = "sigma"
greek_vars["t"] = "tau"


return nil, {
    -- LaTeX: Greek variables
    s({ trig = ";(%l)", regTrig = true },
        d(1, function(_, snip)
            if greek_vars[snip.captures[1]] ~= nil then
                return sn(nil, {
                    c(1, {
                        t("\\" .. greek_vars[snip.captures[1]]),
                        t("\\" .. greek_vars[snip.captures[1]]:gsub("^%l", string.upper)),
                    })
                })
            end
            return sn(nil, {})
        end, {}), { condition = in_mathzone }
    ),
    -- LaTeX: Single-digit subscripts
    s({ trig = "(%a)(%d)", regTrig = true },
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
    s("tt", fmt([[\text{{{}}}]], i(1)), { condition = in_mathzone }),
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
    -- LaTeX: Binary operator dots
    s(".b", t("\\dotsb"), { condition = in_mathzone }),
    -- LaTeX: Comma-separating dots
    s(".c", t("\\dotsc"), { condition = in_mathzone }),
    -- LaTeX: Set notation
    s("set", {
        t("\\set{"),
        i(1),
        t("}"),
    }, { condition = in_mathzone }),
    -- LaTeX: Auto-aligned equals
    s({ trig = "([^&])=", regTrig = true, wordTrig = false },
        f(function(_, snip)
            return snip.captures[1] .. "&="
        end),
        { condition = in_align }
    ),
}
