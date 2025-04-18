return {
    {
        [1] = "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                [1] = "folke/lazydev.nvim",
                version = "^1.0.0",
                ft = "lua",
                opts = true,
            },
        },
        config = function()
            local map = vim.keymap.set
            -- Whenever our LSP server attaches to a buffer, load these keybinds
            local setup_lsp_keybinds = function(client)
                if client.supports_method("textDocument/hover") then
                    map("n", "K", vim.lsp.buf.hover, { silent = true, buffer = true })
                end
                if client.supports_method("textDocument/inlayHints") then
                    map("n", "<Leader>ih", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, { buffer = true })
                end
                map("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = true })
                map("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = true })
                map("n", "<Leader>dn", vim.diagnostic.goto_next, { buffer = true })
                map("n", "<Leader>dp", vim.diagnostic.goto_prev, { buffer = true })
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
                        "LspAttach",
                        "InsertLeave",
                        "TextChanged",
                    }, {
                        buffer = 0,
                        callback = vim.lsp.codelens.refresh,
                        group = refreshCodelens,
                    })
                end
            end

            local lspconfig = require("lspconfig")

            lspconfig.bashls.setup({
                on_attach = function(client)
                    setup_lsp_keybinds(client)
                end,
            })

            lspconfig.clangd.setup({
                on_attach = function(client)
                    setup_lsp_keybinds(client)
                end,
                single_file_support = true,
            })

            lspconfig.gleam.setup({
                on_attach = function(client)
                    setup_lsp_keybinds(client)
                end,
            })

            lspconfig.jsonls.setup({
                on_attach = function(client)
                    setup_lsp_keybinds(client)
                end,
            })

            lspconfig.lua_ls.setup({
                on_attach = function(client)
                    setup_lsp_keybinds(client)
                end,
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        diagnostics = {
                            enable = true,
                            globals = {
                                "describe",
                                "before_each",
                                "it",
                            },
                        },
                        -- Handled by stylua
                        format = {
                            enable = false,
                        },
                        hint = {
                            enable = true,
                        },
                    },
                },
            })

            lspconfig.markdown_oxide.setup({
                root_dir = require("lspconfig.util").root_pattern(".obsidian"),
                single_file_support = false,
                on_attach = function(client)
                    create_codelens_autocmd(client)
                    setup_lsp_keybinds(client)
                end,
            })

            lspconfig.ocamllsp.setup({
                on_attach = function(client)
                    create_codelens_autocmd(client)
                    setup_lsp_keybinds(client)
                end,
                settings = {
                    codelens = {
                        enable = true,
                    },
                },
                single_file_support = true,
            })

            lspconfig.pyright.setup({
                on_attach = function(client)
                    setup_lsp_keybinds(client)
                end,
            })
            -- Only used for formatting
            lspconfig.ruff.setup({})

            lspconfig.nixd.setup({
                on_attach = function(client)
                    setup_lsp_keybinds(client)
                end,
            })

            lspconfig.texlab.setup({
                on_attach = function(client)
                    setup_lsp_keybinds(client)
                end,
            })
        end,
    },
    {
        [1] = "onsails/lspkind.nvim",
        event = "LspAttach",
    },
    {
        [1] = "j-hui/fidget.nvim",
        event = "LspAttach",
        version = "^1.2.0",
        opts = {
            progress = {
                ignore = {
                    "null-ls",
                    "markdown_oxide",
                },
            },
        },
    },
}
