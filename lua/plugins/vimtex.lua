return {
    "lervag/vimtex",
    version = "^2.13.0",
    config = function()
        vim.g.tex_flavor = "latex"
        vim.g.tex_comment_nospell = 1
        vim.g.vimtex_compiler_latexmk = {
            ["options"] = {
                "-file-line-error",
                "-interaction=nonstopmode",
                "-shell-escape",
                "-synctex=1",
                "-verbose",
            },
        }
    end,
}
