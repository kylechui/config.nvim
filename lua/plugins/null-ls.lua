local nl = require("null-ls")

nl.setup({
    sources = {
        nl.builtins.formatting.clang_format.with({
            extra_args = { "--style", "{BasedOnStyle: Google, IndentWidth: 4}" },
        }),
        nl.builtins.formatting.remark.with({
            extra_args = { "-s", "'listItemIndent': 'one'" },
        }),
        nl.builtins.formatting.stylua.with({
            extra_args = {
                "--indent-type",
                "Spaces",
            },
        }),
    },
})
