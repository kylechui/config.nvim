---@type vim.lsp.Config
return {
    on_attach = require("lsp").setup_lsp_keymaps,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
            diagnostics = {
                enable = true,
                -- Some functions used for writing unit tests
                globals = {
                    "describe",
                    "before_each",
                    "it",
                },
            },
            -- Disable luals formatting since it is handled by stylua
            format = {
                enable = false,
            },
            hint = {
                enable = true,
            },
        },
    },
}
