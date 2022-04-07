local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local c = ls.choice_node
-- local d = ls.dynamic_node
-- local f = ls.function_node
local i = ls.insert_node
local s = ls.s
-- local sn = ls.sn
local t = ls.text_node

local in_comment = function()
    return vim.fn["vimtex#syntax#in_comment"]() == 1
end

local in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local in_text = function()
    return not in_mathzone() and not in_comment()
end

local get_env = function(name)
    return {
        t({ "\\begin{" .. name .. "}", "\t" }),
        i(0),
        t({ "", "\\end{" .. name .. "}" }),
    }
end

return nil, {
    -- LaTeX: General environment
    s("beg", fmt(
        [[
            \begin{{{}}}
              {}
            \end{{{}}}
        ]],
        {
            i(1),
            i(0),
            rep(1),
        }
    )),
    -- LaTeX: Proof environment
    s("pf", get_env("proof"), { condition = in_text }),
    -- LaTeX: Align environment
    s("ali", get_env("align*"), { condition = in_text }),
    -- LaTeX: Problem environment
    s("pb", {
        t("\\begin{problem}{"),
        i(1),
        t({ "}", "\t" }),
        i(0),
        t({ "", "\\end{problem}" }),
    }, { condition = in_text }),
    -- LaTeX: Enumerate environment
    s("enum", {
        c(1, {
            t("\\begin{enumerate}"),
            t("\\begin{enumerate}[label=(\\alph*)]"),
            t("\\begin{enumerate}[label=(\\roman*)]"),
            t("\\begin{enumerate}[label=(\\arabic*)]"),
        }),
        t({ "", "\t\\item " }),
        i(0),
        t({ "", "\\end{enumerate}" }),
    }, { condition = in_text }),
    -- LaTeX: Itemize environment
    s("iem", {
        t({ "\\begin{itemize}", "\t\\item " }),
        i(0),
        t({ "", "\\end{itemize}" }),
    }, { condition = in_text }),
}
