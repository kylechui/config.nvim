return {
    [1] = "mrcjkb/rustaceanvim",
    version = "^3",
    ft = { "rust" },
    config = function()
        vim.g.rustaceanvim = {
            server = {
                on_attach = function()
                    vim.lsp.inlay_hint.enable()
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = true })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = true })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, buffer = true })
                    vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = true })
                    vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = true })
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
