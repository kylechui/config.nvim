return {
    [1] = "chrishrb/gx.nvim",
    version = "^0.5.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {
            "gx",
            function()
                vim.cmd.Browse()
            end,
        },
    },
    config = true,
}
