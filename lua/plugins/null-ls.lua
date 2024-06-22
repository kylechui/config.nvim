return {
    [1] = "nvimtools/none-ls.nvim",
    event = "LspAttach",
    ft = { "css", "markdown" }, -- Other filetypes are handled by LspAttach
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
        require("null-ls").setup({
            sources = {
                require("null-ls").builtins.formatting.clang_format,
                require("null-ls").builtins.formatting.nixfmt,
                require("null-ls").builtins.formatting.ocamlformat,
                require("null-ls").builtins.formatting.prettierd.with({
                    extra_args = { "--prose-wrap=always" },
                }),
                require("null-ls").builtins.formatting.stylua.with({
                    extra_args = { "--indent-type", "Spaces" },
                }),
                require("null-ls").builtins.diagnostics.selene,
                require("null-ls").builtins.diagnostics.mypy,
            },
        })
    end,
}
