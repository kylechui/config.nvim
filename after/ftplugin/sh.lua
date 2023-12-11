local map = vim.keymap.set
map("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = true })
map("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = true })
map("n", "K", vim.lsp.buf.hover, { silent = true, buffer = true })
map("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = true })
map("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = true })
map("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
map("n", "<Leader>r", require("utils").rename_var, { buffer = true })
map("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })
