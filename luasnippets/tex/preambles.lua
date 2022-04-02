local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local c = ls.choice_node
-- local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local s = ls.s
-- local sn = ls.sn
local t = ls.text_node

return {
    -- LaTeX: Assignment preamble
    s("setup", fmt(
        [[
            \documentclass{{article}}
            \input{{../../Preamble}}

            \fancyhf{{}}
            \setlength{{\headheight}}{{24pt}}
            \lhead{{{} \\{}}}
            \rhead{{Kyle Chui \\Page \thepage}}
            \pagestyle{{fancy}}
            \pagenumbering{{gobble}}

            \date{{{}}}
            \title{{{}}}

            \begin{{document}}
              \maketitle
              \newpage
              \pagenumbering{{arabic}}
              {}{}
            \end{{document}}
        ]],
        {
            i(1, "Class Name"),
            i(2, "Assignment Name"),
            f(function()
                return os.date("%Y-%m-%d")
            end),
            rep(2),
            -- TODO: Fix indentation nonsense
            c(3, {
                i(0),
                t({ "\\tableofcontents", "\t\\newpage", "\t" })
            }),
            i(0),
        }
    )),
    -- LaTeX: Notes preamble
    s("notes", fmt(
        [[
            \documentclass[class=article, crop=false]{{standalone}}
            \input{{../../Preamble}}

            \fancyhf{{}}
            \lhead{{Kyle Chui}}
            \rhead{{Page \thepage}}
            \pagestyle{{fancy}}

            \begin{{document}}
              {}
            \end{{document}}
        ]],
        {
            i(0),
        }
    ))
}, nil
