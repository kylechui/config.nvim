---@diagnostic disable: undefined-global

local in_text = function()
    return not in_mathzone() and not in_comment()
end

local begins_line = function()
    local cur_line = vim.api.nvim_get_current_line()
    -- Checks if the current line consists of whitespace and then the snippet
    -- TODO: Fix limitation that the snippet cannot contain whitespace itself
    return #cur_line == #string.match(cur_line, "%s*[^%s]+")
end

return {
    -- LaTeX: Assignment preamble
    s(
        "setup",
        fmt(
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
              {}
            \end{{document}}
        ]],
            {
                i(1, "Class Name"),
                i(2, "Assignment Name"),
                f(function()
                    return os.date("%Y-%m-%d")
                end),
                rep(2),
                i(0),
            }
        ),
        { condition = in_text and begins_line }
    ),
    -- LaTeX: Table of contents
    s("toc", {
        t({ "\\tableofcontents", "\\newpage", "" }),
    }, { condition = in_text and begins_line }),
    -- LaTeX: Notes preamble
    s(
        "notes",
        fmt(
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
        ),
        { condition = in_text and begins_line }
    ),
},
    nil
