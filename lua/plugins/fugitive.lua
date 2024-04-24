return {
    [1] = "tpope/vim-fugitive",
    version = "^3.7.0",
    keys = {
        { "<Leader>g", "<Cmd>Git<CR>" },
        { "<Leader>h", "<Cmd>diffget LOCAL<CR>" },
        { "<Leader>l", "<Cmd>diffget REMOTE<CR>" },
    },
}
