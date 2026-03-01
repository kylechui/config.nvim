---@type vim.lsp.Config
return {
    on_attach = function()
        require("lsp").setup_lsp_keymaps()
    end,
    single_file_support = true,
}
