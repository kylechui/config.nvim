return {
    "Wansmer/treesj",
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
        { "gJ", "<Cmd>TSJToggle<CR>" },
    },
    opts = {
        use_default_keymaps = false,
    },
}
