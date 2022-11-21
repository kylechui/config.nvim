---@diagnostic disable: undefined-global

local in_comment = function()
    return vim.fn["vimtex#syntax#in_comment"]() == 1
end

local in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local in_text = function()
    return not in_mathzone() and not in_comment()
end

return {
    -- LaTeX: Section
    s("sec", {
        c(1, {
            t("\\section{"),
            t("\\section*{"),
        }),
        i(0),
        t("}"),
    }, { condition = in_text }),
    -- LaTeX: Subsection
    s("ssec", {
        c(1, {
            t("\\subsection{"),
            t("\\subsection*{"),
        }),
        i(0),
        t("}"),
    }, { condition = in_text }),
    -- LaTeX: Subsubsection
    s("sssec", {
        c(1, {
            t("\\subsubsection{"),
            t("\\subsubsection*{"),
        }),
        i(0),
        t("}"),
    }, { condition = in_text }),
},
    {
        -- LaTeX: Inline math mode
        s("mm", fmt("${}$", i(1)), { condition = in_text }),
        -- LaTeX: Display math mode
        s("dm", {
            t({ "\\[", "\t" }),
            i(0),
            t({ "", "\\]" }),
        }, { condition = in_text }),
        -- LaTeX: Single-letter variables
        s(
            { trig = " ([b-zB-Z])([%p%s])", regTrig = true, wordTrig = false },
            f(function(_, snip)
                return " $" .. snip.captures[1] .. "$" .. snip.captures[2]
            end),
            { condition = in_text }
        ),
        -- LaTeX: Quotations
        s('"', fmt([[``{}'']], i(1)), { condition = in_text }),
        -- LaTeX: Emphasis
        s("emph", fmt([[\emph{{{}}}]], i(1)), { condition = in_text }),
        -- LaTeX: Boldface
        s("bf", fmt([[\textbf{{{}}}]], i(1)), { condition = in_text }),
        -- LaTeX: Teletype
        s("tt", fmt([[\texttt{{{}}}]], i(1)), { condition = in_text }),
        -- LaTeX: Ordinal nth
        s({ trig = "([%d$])th", regTrig = true, wordTrig = false }, {
            f(function(_, snip)
                return snip.captures[1] .. "\\tsup{th}"
            end),
        }, { condition = in_text }),
        -- LaTeX: Image
        s("img", {
            t({ "\\begin{center}", "\t\\resizebox{" }),
            i(1, "5"),
            t("in}{!}{\\includegraphics{./"),
            i(2),
            t({ "}}", "\\end{center}" }),
        }, { condition = in_text }),
    }
