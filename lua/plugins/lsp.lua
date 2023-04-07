return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            {
                "folke/neodev.nvim",
                ft = "lua",
            },
        },
        config = function()
            -- Setup mason.nvim before LSP servers
            require("mason").setup()
            require("mason-lspconfig").setup({
                automatic_installation = true,
            })

            local map = vim.keymap.set
            -- Whenever our LSP server attaches to a buffer, load these keybinds
            local setup_lsp_keybinds = function()
                map("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = true })
                map("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = true })
                map("n", "K", vim.lsp.buf.hover, { silent = true, buffer = true })
                map("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = true })
                map("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = true })
                map("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
                map("n", "<Leader>r", require("utils").rename_var, { buffer = true })
                map("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })
            end

            -- Refreshes code lenses
            local create_codelens_autocmd = function(client)
                if client.supports_method("textDocument/codeLens") then
                    vim.lsp.codelens.refresh()
                    local refreshCodelens = vim.api.nvim_create_augroup("refreshCodelens", {})
                    vim.api.nvim_create_autocmd({
                        "BufEnter",
                        "InsertLeave",
                        "TextChanged",
                    }, {
                        buffer = 0,
                        callback = vim.lsp.codelens.refresh,
                        group = refreshCodelens,
                    })
                end
            end

            -- IMPORTANT: make sure to setup neodev BEFORE require("lspconfig")
            require("neodev").setup({})
            local lspconfig = require("lspconfig")

            lspconfig.clangd.setup({
                on_attach = function()
                    setup_lsp_keybinds()
                end,
            })

            lspconfig.jdtls.setup({
                on_attach = function()
                    setup_lsp_keybinds()
                end,
            })

            lspconfig.ocamllsp.setup({
                on_attach = function(client)
                    create_codelens_autocmd(client)
                    setup_lsp_keybinds()
                end,
                single_file_support = true,
            })

            lspconfig.pyright.setup({
                on_attach = function()
                    setup_lsp_keybinds()
                end,
            })

            lspconfig.lua_ls.setup({
                on_attach = function()
                    setup_lsp_keybinds()
                end,
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        diagnostics = {
                            globals = { "it", "describe", "before_each" }, -- Plenary test suite variables
                        },
                    },
                },
            })

            lspconfig.rust_analyzer.setup({
                on_attach = function(client)
                    create_codelens_autocmd(client)
                    setup_lsp_keybinds()
                end,
                single_file_support = true,
            })

            lspconfig.texlab.setup({
                on_attach = function()
                    setup_lsp_keybinds()
                end,
            })

            lspconfig.tsserver.setup({
                on_attach = function()
                    setup_lsp_keybinds()
                end,
            })
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "LspAttach",
        opts = {
            hint_enable = false,
        },
    },
    {
        "onsails/lspkind.nvim",
        event = "LspAttach",
    },
}
