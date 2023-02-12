require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "ocamllsp",
        "pyright",
        "sumneko_lua",
        "texlab",
    },
    automatic_installation = true,
})
