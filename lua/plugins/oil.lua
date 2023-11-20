return {
    "stevearc/oil.nvim",
    version = "^2.4.0",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
        {
            "<C-Bslash>",
            function()
                require("oil").toggle_float()
            end,
        },
    },
    opts = {
        view_options = {
            show_hidden = true,
        },
    },
}
