return {
    {
        [1] = "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                [1] = "folke/lazydev.nvim",
                version = "^1.0.0",
                ft = "lua",
                opts = true,
            },
        },
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
