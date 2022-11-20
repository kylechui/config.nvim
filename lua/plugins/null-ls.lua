local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.clang_format.with({
            extra_args = { "--style", "{BasedOnStyle: Google, IndentWidth: 4}" },
        }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.latexindent.with({
            extra_args = { "-y", "noAdditionalIndent:document:0,defaultIndent:'  '" },
        }),
        null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces" },
        }),
    },
})
