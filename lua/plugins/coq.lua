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
                on_attach = require("lsp").setup_lsp_keymaps,
                single_file_support = true,
                init_options = {
                    show_stats_on_hover = true,
                },
            },
        })
    end,
}
