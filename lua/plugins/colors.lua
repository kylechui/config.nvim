return {
    {
        [1] = "miikanissi/modus-themes.nvim",
        priority = 1000,
        init = function()
            vim.cmd.colorscheme("modus_operandi")
        end,
    },
}
