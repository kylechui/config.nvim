---@type vim.lsp.Config
return {
    on_attach = function(client)
        require("lsp").setup_lsp_keymaps(client)
        require("lsp").create_codelens_autocmd(client)
    end,
    settings = {
        codelens = {
            enable = true,
        },
    },
    single_file_support = true,
}
