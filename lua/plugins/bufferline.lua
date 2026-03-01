return {
    [1] = "akinsho/bufferline.nvim",
    version = "^v4.4.0",
    lazy = false,
    keys = {
        { "<M-.>", vim.cmd.BufferLineCycleNext },
        { "<M-,>", vim.cmd.BufferLineCyclePrev },
    },
    opts = {
        options = {
            buffer_close_icon = "×",
        },
    },
}
