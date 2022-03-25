--[=[
require("formatter").setup({
    filetype = {
        cpp = {
            function()
                return {
                    exe = "clang-format",
                    args = {"-style=\"{BasedOnStyle: Google, IndentWidth: 4}\"", vim.api.nvim_buf_get_name(0)},
                    stdin = true,
                    cwd = vim.fn.expand("%:p:h")  -- Run clang-format in cwd of the file.
                }
            end
        },
        markdown = {
            function()
                return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},
                    stdin = true,
                }
            end
        },
        javascript = {
            function()
                return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},
                    stdin = true
                }
            end
        },
        lua = {
            function()
                --[[ return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},

                    stdin = true
                } ]]
                return {
                    exe = ".cargo/bin/stylua",
                    args = {
                        "--config-path "
                        .. os.getenv("XDG_CONFIG_HOME")
                        .. "/stylua/stylua.toml",
                        "-",
                    },
                    stdin = true,
                }
            end
        },
        --[[ lua = {
            function()
                return {
                    exe = "luafmt",
                    args = {"--indent-count", 4, "--stdin"},
                    stdin = true
                }
            end
        }, ]]
    }
})
--]=]
