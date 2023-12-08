return {
    [1] = "akinsho/bufferline.nvim",
    version = "^v4.4.0",
    lazy = false,
    keys = {
        { "<Leader>j", vim.cmd.BufferLineCycleNext },
        { "<Leader>k", vim.cmd.BufferLineCyclePrev },
    },
    config = true,
}
