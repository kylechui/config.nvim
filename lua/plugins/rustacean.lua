return {
    [1] = "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    config = function()
        vim.g.rustaceanvim = {
            server = {
                on_attach = require("lsp").setup_lsp_keymaps,
            },
        }
    end,
}
