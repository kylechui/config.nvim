local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.clang_format.with({
            extra_args = { "--style", "{BasedOnStyle: Google, IndentWidth: 4}" },
        }),
        null_ls.builtins.formatting.remark.with({
            extra_args = { "-s", "'listItemIndent': 'one'" },
        }),
        null_ls.builtins.formatting.stylua.with({
            extra_args = {
                "--indent-type",
                "Spaces",
            },
        }),
    },
})
