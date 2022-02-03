require('formatter').setup({
    filetype = {
        cpp = {
            function()
                return {
                    exe = "clang-format",
                    args = {"-style=\"{BasedOnStyle: Google, IndentWidth: 4}\"", vim.api.nvim_buf_get_name(0)},
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
                }
            end
        },
    }
})
