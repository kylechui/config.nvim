require('formatter').setup({
    logging = false,
    filetype = {
        --[[ lua = {
        -- luafmt
        function()
        return {
        exe = 'luafmt',
        args = {'--indent-count', 2, '--stdin'},
        stdin = true
        }
        end
        }, ]]
        cpp = {
            -- clang-format
            function()
                return {
                    exe = 'clang-format',
                    args = {'--assume-filename', vim.api.nvim_buf_get_name(0)},
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
                }
            end
        },
    }
})
