return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdLineEnter" },
        dependencies = {
            "uga-rosa/cmp-dictionary",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            {
                "saadparwaiz1/cmp_luasnip",
                dependencies = "L3MON4D3/LuaSnip",
                config = function()
                    local ls = require("luasnip")
                    vim.keymap.set({ "i", "s" }, "<Tab>", function()
                        if ls.expand_or_jumpable() then
                            return "<Plug>luasnip-expand-or-jump"
                        else
                            return "<Tab>"
                        end
                    end, { expr = true })

                    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
                        if ls.jumpable(-1) then
                            ls.jump(-1)
                        end
                    end, { silent = true })

                    vim.keymap.set({ "i", "s" }, "<C-j>", function()
                        if ls.choice_active() then
                            ls.change_choice(1)
                        end
                    end, { silent = true })

                    vim.keymap.set({ "i", "s" }, "<C-k>", function()
                        if ls.choice_active() then
                            ls.change_choice(-1)
                        end
                    end, { silent = true })
                end,
            },
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<CR>"] = cmp.config.disable,
                }),
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "buffer", keyword_length = 4 },
                    { name = "luasnip" },
                    { name = "dictionary", keyword_length = 4 },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol", -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                        -- The function below will be called before any actual modifications from lspkind
                        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                        before = function(_, vim_item)
                            return vim_item
                        end,
                    }),
                },
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore)
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore)
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })

            vim.opt_global.dictionary = { "~/.config/nvim/spell/en.utf-8.add", "/usr/share/dict/words" }
            require("cmp_dictionary").setup({
                first_case_insensitive = true,
            })
            require("cmp_dictionary").update()
        end,
    },
}
