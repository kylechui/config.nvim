return {
    [1] = "j-hui/fidget.nvim",
    event = "LspAttach",
    version = "^1.2.0",
    opts = {
        progress = {
            ignore = {
                "null-ls",
                "markdown_oxide",
            },
        },
    },
}
