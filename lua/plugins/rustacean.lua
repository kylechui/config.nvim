return {
    [1] = "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    config = function()
        vim.g.rustaceanvim = {
            server = {
                on_attach = function(client)
                    if client.supports_method("textDocument/inlayHints") then
                        vim.lsp.inlay_hint.enable()
                        vim.keymap.set("n", "<Leader>ih", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                        end, { buffer = true })
                    end
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = true })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = true })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, buffer = true })
                    vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next, { buffer = true })
                    vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev, { buffer = true })
                    vim.keymap.set("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
                    vim.keymap.set("n", "<Leader>r", require("utils").rename_var, { buffer = true })
                    vim.keymap.set("n", "<leader>c", function()
                        vim.cmd.RustLsp("codeAction")
                    end, { silent = true, buffer = true })
                end,
            },
        }
    end,
}
