return {
    [1] = "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            filetypes = {
                tex = false,
            },
            suggestion = {
                keymap = {
                    accept = "<C-Space>",
                },
            },
        })
    end,
}
