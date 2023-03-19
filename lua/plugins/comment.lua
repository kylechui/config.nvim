return {
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    keys = {
        { mode = "n", "<C-/>", "<Plug>(comment_toggle_linewise_current)" },
        { mode = "x", "<C-/>", "<Cmd>norm gbgv<CR>" },
    },
    --[[ opts = {
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        }, ]]
    config = true,
}
