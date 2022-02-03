require('lspconfig').clangd.setup {
    on_attach = function()
        vim.api.nvim_command([[
            autocmd BufWritePost <buffer> FormatWrite
        ]])
        vim.keymap.set('n', '<Leader>dj', vim.diagnostic.goto_next, { buffer = 0 })
        vim.keymap.set('n', '<Leader>dk', vim.diagnostic.goto_prev, { buffer = 0 })
        vim.keymap.set('n', '<Leader>dl', '<Cmd>Telescope diagnostics<CR>', { buffer = 0 })
        vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set('n', '<Leader>c', vim.lsp.buf.code_action, { buffer = 0 })
    end
}
