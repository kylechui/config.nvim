return {
    {
        [1] = "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            vim.lsp.enable({
                "bashls",
                "clangd",
                "gleam",
                "jsonls",
                "lua_ls",
                "nixd",
                "ocamllsp",
                "pyright",
                "rust_analyzer",
            })
        end,
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
