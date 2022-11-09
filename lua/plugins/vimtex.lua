--[[ vim.g.vimtex_imaps_enabled = 0 ]]
vim.g.tex_flavor = "latex"
vim.g.tex_comment_nospell = 1
vim.g.vimtex_compiler_latexmk = {
    ["options"] = {
        --[[ "-aux-directory=/tmp/latexout",
        "-emulate-aux-dir", ]]
        "-file-line-error",
        "-interaction=nonstopmode",
        "-shell-escape",
        "-synctex=1",
        "-verbose",
    },
}

-- Selects the default PDF viewer when compiling LaTeX files
-- SumatraPDF for Windows, Zathura for Linux
if vim.fn.has("win32") == true then
    vim.g.vimtex_view_method = "SumatraPDF"
else
    vim.g.vimtex_view_method = "zathura"
end
