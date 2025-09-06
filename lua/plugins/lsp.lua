return {
    {
        [1] = "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        [1] = "onsails/lspkind.nvim",
        event = "LspAttach",
    },
    {
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
    },
}
