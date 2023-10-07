return {
    "jose-elias-alvarez/null-ls.nvim",
    event = "LspAttach",
    ft = { "markdown", "css" }, -- Other filetypes are handled by LspAttach
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
        require("null-ls").setup({
            sources = {
                require("null-ls").builtins.formatting.black,
                require("null-ls").builtins.formatting.clang_format.with({
                    extra_args = {
                        "--style",
                        "{BasedOnStyle: Google, IndentWidth: 4, BreakBeforeBinaryOperators: NonAssignment, AllowShortFunctionsOnASingleLine: None}",
                    },
                }),
                require("null-ls").builtins.formatting.latexindent.with({
                    extra_args = {
                        "-y",
                        "noAdditionalIndent:document:0;problem:0,defaultIndent:'  ',verbatimEnvironments:cpp:1;python:1",
                    },
                }),
                require("null-ls").builtins.formatting.nixfmt,
                require("null-ls").builtins.formatting.ocamlformat,
                require("null-ls").builtins.formatting.prettierd.with({
                    extra_args = { "--prose-wrap=always" },
                }),
                require("null-ls").builtins.formatting.stylish_haskell,
                require("null-ls").builtins.formatting.stylua.with({
                    extra_args = { "--indent-type", "Spaces" },
                }),
                require("null-ls").builtins.diagnostics.selene,
                require("null-ls").builtins.diagnostics.mypy,
            },
        })
    end,
}
