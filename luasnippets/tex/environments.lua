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

local begins_line = function()
    local cur_line = vim.api.nvim_get_current_line()
    -- Checks if the current line consists of whitespace and then the snippet
    -- TODO: Fix limitation that the snippet cannot contain whitespace itself
    return #cur_line == #string.match(cur_line, "%s*[^%s]+")
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
    s("pf", get_env("proof"), { condition = in_text and begins_line }),
    -- LaTeX: Align environment
    s("ali", get_env("align*"), { condition = in_text and begins_line }),
    -- LaTeX: Problem environment
    s("pb", {
        t("\\begin{problem}{"),
        i(1),
        t({ "}", "\t" }),
        i(0),
        t({ "", "\\end{problem}" }),
    }, { condition = in_text and begins_line }),
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
    }, { condition = in_text and begins_line }),
    -- LaTeX: Itemize environment
    s("iem", {
        t({ "\\begin{itemize}", "\t\\item " }),
        i(0),
        t({ "", "\\end{itemize}" }),
    }, { condition = in_text and begins_line }),
    -- LaTeX: Algorithm environment
    s("algo", {
        t({
            "\\begin{algorithm}",
            "\t\\DontPrintSemicolon",
            "\t\\caption{",
        }),
        i(1),
        t({ "}", "\t" }),
        i(0),
        t({ "", "\\end{algorithm}" }),
    }, { condition = in_text and begins_line }),
    -- LaTeX: Bracket matrix
    s({ trig = "bmat_(%d)(%d)", regTrig = true }, {
        d(1, function(_, snip)
            local rows, cols = snip.captures[1], snip.captures[2]
            local nodes = {}
            local ts = 1
            table.insert(nodes, t("\\begin{bmatrix}"))
            for _ = 1, rows, 1 do
                table.insert(nodes, t({ "", "\t" }))
                for _ = 1, cols - 1, 1 do
                    table.insert(nodes, i(ts))
                    table.insert(nodes, t(" & "))
                    ts = ts + 1
                end
                table.insert(nodes, i(ts))
                ts = ts + 1
            end
            table.insert(nodes, t({ "", "\\end{bmatrix}" }))
            return sn(1, nodes)
        end),
    }, { condition = in_mathzone and begins_line })
}
