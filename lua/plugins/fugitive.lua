return {
    [1] = "tpope/vim-fugitive",
    version = "^3.7.0",
    keys = {
        { "<Leader>g", "<Cmd>Git<CR>" },
        { "<Leader>gp", "<Cmd>Git push<CR>" },
        { "<Leader>gm", "<Cmd>Gvdiffsplit!<CR>" },
        { "<Leader>h", "<Cmd>diffget //2<CR>" },
        { "<Leader>l", "<Cmd>diffget //3<CR>" },
    },
}
