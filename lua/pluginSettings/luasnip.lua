local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local types = require("luasnip.util.types")
local c = ls.choice_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local s = ls.s
local sn = ls.sn
local t = ls.text_node

-- Returns a node with the same contents as the given node
local dupe = function(index)
    return f(function(arg)
        return arg[1]
    end, { index })
end

local in_comment = function()
    return vim.fn['vimtex#syntax#in_comment']() == 1
end

local in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local in_text = function()
    return not in_mathzone() and not in_comment()
end

local greek_vars = {}
greek_vars["a"] = "alpha"
greek_vars["b"] = "beta"
greek_vars["d"] = "delta"
greek_vars["e"] = "eps"
greek_vars["g"] = "gamma"
greek_vars["l"] = "lam"
greek_vars["o"] = "omega"
greek_vars["t"] = "tau"

ls.config.set_config({
    update_events = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "<- Choice" } },
            },
        },
    },
})

ls.add_snippets("all", {
    -- All: Prints the current date in Y-m-d format
    s(
        "date",
        f(function()
            return os.date("%Y-%m-%d")
        end)
    ),
})

ls.add_snippets("cpp", {
    -- C++: Basic coding environment template
    s(
        "setup",
        fmt(
            [[
                #include <bits/stdc++.h>
                using namespace std;

                int main() {{
                    {}{}
                }}
            ]],
            {
                c(1, {
                    t(""),
                    -- TODO: Figure out indentation nonsense
                    t({
                        "int N;",
                        "\tcin >> N;",
                        "\tvector<int> arr(N);",
                        "\tfor (size_t i = 0; i < N; i++) {",
                        "\t\tcin >> arr[i];",
                        "\t}",
                        "\t",
                    }),
                }),
                i(0),
            }
        )
    ),
    -- C++: Auto-documenting functions
    s(
        "fn",
        fmt(
            [[
                /**
                * {}
                */
                {} {}({}) {{
                    {}
                }}
            ]],
            {
                d(4, function(args)
                    local pos = 1
                    local nodes = {}
                    local returnValue = args[1][1]
                    local params = string.gmatch(args[2][1] .. ",", "%a+,")
                    -- Add a node for the function description
                    table.insert(nodes, i(pos, "Function description."))
                    pos = pos + 1
                    -- Add lines for each parameter in the function
                    for param in params do
                        param = param:sub(1, -2)
                        table.insert(nodes, t({ "", "" }))
                        table.insert(
                            nodes,
                            sn(
                                pos,
                                fmt(
                                    [[
                                        * @param {} {}
                                    ]],
                                    {
                                        t({ param }),
                                        i(1),
                                    }
                                )
                            )
                        )
                        pos = pos + 1
                    end
                    -- Add a node if there is a return type
                    if returnValue ~= "void" then
                        table.insert(nodes, t({ "", "" }))
                        table.insert(
                            nodes,
                            sn(
                                pos,
                                fmt(
                                    [[
                                        * @return {}
                                    ]],
                                    {
                                        i(1),
                                    }
                                )
                            )
                        )
                        pos = pos + 1
                    end
                    return sn(nil, nodes)
                end, { 1, 3 }),
                c(1, {
                    i(nil, "void"),
                    i(nil, "int"),
                    i(nil, "string"),
                    i(nil, "bool"),
                }),
                i(2, "functionName"),
                i(3),
                i(0),
            }
        )
    ),
    -- C++: Include header
    s(
        "include",
        fmt(
            [[
                #include {}
            ]],
            {
                c(1, {
                    fmt(
                        [[
                            <{}>
                        ]],
                        {
                            i(1, "bits/stdc++.h"),
                        }
                    ),
                    fmt(
                        [[
                            "{}.h"
                        ]],
                        {
                            i(1, "HeaderFile"),
                        }
                    ),
                }),
            }
        )
    ),
    -- C++: Choice for loops
    s(
        "for",
        fmt(
            [[
                for ({}) {{
                    {}
                }}
            ]],
            {
                c(1, {
                    fmt(
                        [[
                            size_t {} = {}; {} < {}; {}++
                        ]],
                        {
                            i(1, "i"),
                            i(2, "0"),
                            dupe(1),
                            i(3, "arr.size()"),
                            dupe(1),
                        }
                    ),
                    fmt(
                        [[
                            {}& {} : {}
                        ]],
                        {
                            i(1, "auto"),
                            i(2, "e"),
                            i(3, "arr"),
                        }
                    ),
                }),
                i(0),
            }
        )
    ),
})

ls.add_snippets("tex", {
    -- LaTeX: Inline math mode
    s("mm", fmt("${}$", i(1)), { condition = in_text }),
    -- LaTeX: Display math mode
    s("dm", {
        t({ "\\[", "\t" }),
        i(0),
        t({ "", "\\]" }),
    }, { condition = in_text }),
    -- LaTeX: Environments
    s("beg", fmt(
        [[
            \begin{{{}}}
              {}
            \end{{{}}}
        ]],
        {
            i(1),
            i(0),
            dupe(1),
        }
    )),
    -- LaTeX: Proof environment
    s("pf", {
        t({ "\\begin{proof}", "\t" }),
        i(0),
        t({ "", "\\end{proof}" }),
    }),
    -- LaTeX: Problem environment
    s("pb", {
        t({ "\\begin{problem}", "\t" }),
        i(0),
        t({ "", "\\end{problem}" }),
    }),
    -- LaTeX: Align environment
    s("ali", {
        t({ "\\begin{align*}", "\t" }),
        i(0),
        t({ "", "\\end{align*}" }),
    }, { condition = in_text }),
    -- LaTeX: Enumerate environment
    s("enum", {
        c(1, {
            t("\\begin{enumerate}"),
            t("\\begin{enumerate}[\\label=(\\alph*)]"),
            t("\\begin{enumerate}[\\label=(\\roman*)]"),
            t("\\begin{enumerate}[\\label=(\\arabic*)]"),
        }),
        t({ "", "\t\\item " }),
        i(0),
        t({ "", "\\end{enumerate}" }),
    }),
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
        end, {})
    ),
    -- LaTeX: Single-letter variables
    s({ trig = "([b-zB-Z])([%p%s])", regTrig = true },
        f(function(_, snip)
            return "$" .. snip.captures[1] .. "$" .. snip.captures[2]
        end), { condition = in_text }
    ),
    -- LaTeX: Single-digit subscripts
    s({ trig = "(%a)(%d)", regTrig = true },
        f(function(_, snip)
            return snip.captures[1] .. "_" .. snip.captures[2]
        end), { condition = in_mathzone }
    ),
    -- LaTeX: Math subscripts
    s({ trig = "__", wordTrig = false },
        fmt([[_{{{}}}]], i(1)), { condition = in_mathzone }
    ),
    -- LaTeX: Math superscripts
    s({ trig = "^^", wordTrig = false },
        fmt([[^{{{}}}]], i(1)), { condition = in_mathzone }
    ),
    -- LaTeX: Quotations
    s("\"", fmt([[``{}'']], i(1)), { condition = in_text }),
    -- LaTeX: Emphasis
    s("emph", fmt([[\emph{{{}}}]], i(1)), { condition = in_text }),
    -- LaTeX: Boldface
    s("bf", fmt([[\textbf{{{}}}]], i(1)), { condition = in_text }),
    -- LaTeX: Teletype
    s("tt", fmt([[\texttt{{{}}}]], i(1)), { condition = in_text }),
    -- LaTeX: Math boldface
    s("bf", fmt([[\mathbf{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Romanized math
    s("rm", fmt([[\mathrm{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Math text
    s("tt", fmt([[\text{{{}}}]], i(1)), { condition = in_mathzone }),
    -- LaTeX: Fractions
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
    -- LaTeX: Times
    s({ trig = "xx", wordTrig = false },
        t("\\times "), { condition = in_mathzone }
    ),
    -- LaTeX: Center dot
    s({ trig = "**", wordTrig = false },
        t("\\cdot "), { condition = in_mathzone }
    ),
}, { type = "autosnippets" })
