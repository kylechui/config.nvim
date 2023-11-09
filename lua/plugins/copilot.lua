return {
    "github/copilot.vim",
    config = function()
        vim.g.copilot_no_tab_map = true

        vim.keymap.set("i", "<C-i>", "copilot#Accept('')", {
            silent = true,
            expr = true,
            script = true,
        })
    end,
}
