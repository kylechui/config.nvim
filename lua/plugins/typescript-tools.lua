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
            on_attach = function()
                local map = vim.keymap.set
                map("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = true })
                map("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = true })
                map("n", "K", vim.lsp.buf.hover, { silent = true, buffer = true })
                map("n", "<Leader>dn", vim.diagnostic.goto_next, { buffer = true })
                map("n", "<Leader>dp", vim.diagnostic.goto_prev, { buffer = true })
                map("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
                map("n", "<Leader>r", require("utils").rename_var, { buffer = true })
                map("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })
                map("n", "<Leader>i", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end, { buffer = true })
            end,
        })
        vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
    end,
}
