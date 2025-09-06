---@type vim.lsp.Config
return {
    on_attach = require("lsp").setup_lsp_keymaps,
    single_file_support = true,
}
