local ht = require("haskell-tools")
ht.start_or_attach({
    hls = {
        on_attach = function(client)
            local map = vim.keymap.set
            map("n", "gD", vim.lsp.buf.declaration, { silent = true })
            map("n", "gd", vim.lsp.buf.definition, { silent = true })
            map("n", "K", vim.lsp.buf.hover, { silent = true })
            map("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = true })
            map("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = true })
            map("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
            map("n", "<Leader>r", require("utils").rename_var, { buffer = true })
            map("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })

            -- Refreshes code lenses
            if client.supports_method("textDocument/codeLens") then
                vim.lsp.codelens.refresh()
                local refreshCodelens = vim.api.nvim_create_augroup("refreshCodelens", {})
                vim.api.nvim_create_autocmd({
                    "BufEnter",
                    "InsertLeave",
                    "TextChanged",
                }, {
                    buffer = 0,
                    callback = vim.lsp.codelens.refresh,
                    group = refreshCodelens,
                })
            end
        end,
    },
})
