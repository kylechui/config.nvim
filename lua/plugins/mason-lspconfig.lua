require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "pyright",
        "sumneko_lua",
        "texlab",
    },
    automatic_installation = true,
})
