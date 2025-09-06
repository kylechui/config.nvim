return {
    [1] = "pmizio/typescript-tools.nvim",
    ft = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("typescript-tools").setup({
            settings = {
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = "all",
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true,
                },
            },
            on_attach = require("lsp").setup_lsp_keymaps,
        })
        vim.lsp.inlay_hint.enable()
    end,
}
