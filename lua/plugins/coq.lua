return {
    [1] = "tomtomjhj/coq-lsp.nvim",
    ft = "coq",
    dependencies = {
        [1] = "whonore/Coqtail",
        version = "^1.7.0",
        config = function()
            vim.g.coqtail_noimap = true
            vim.g.loaded_coqtail = true
            vim.g["coqtail#supported"] = false
            vim.keymap.set("n", "<Leader>i", function()
                vim.cmd.CoqLsp("open_info_panel")
            end, { silent = true, buffer = true })
        end,
    },
    config = function()
        require("coq-lsp").setup({
            lsp = {
                on_attach = function()
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = true })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = true })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, buffer = true })
                    vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = true })
                    vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = true })
                    vim.keymap.set("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
                    vim.keymap.set("n", "<Leader>r", require("utils").rename_var, { buffer = true })
                    vim.keymap.set("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })
                end,
                single_file_support = true,
                init_options = {
                    show_stats_on_hover = true,
                },
            },
        })
    end,
}
