local nl = require("null-ls")

nl.setup({
    sources = {
        nl.builtins.formatting.clang_format.with({
            extra_args = { "--style", "{BasedOnStyle: Google, IndentWidth: 4}" }
        }),
        nl.builtins.formatting.remark.with({
            extra_args = { "'listItemIndent': 'one'" }
        }),
    },
})
