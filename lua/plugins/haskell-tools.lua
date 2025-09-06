return {
    [1] = "mrcjkb/haskell-tools.nvim",
    ft = "haskell",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    init = function()
        vim.g.haskell_tools = {
            hls = {
                on_attach = function(client)
                    require("lsp").setup_lsp_keymaps(client)
                    require("lsp").create_codelens_autocmd(client)
                end,
                default_settings = {
                    haskell = {
                        formattingProvider = "stylish-haskell",
                    },
                },
            },
        }
    end,
    branch = "2.x.x",
}
