require("nvim-surround").buffer_setup({
    surrounds = {
        N = {
            add = { "(", ")%nat" },
            find = "%b()%%nat",
            delete = "^(%()().-(%)%%nat)()$",
        },
        R = {
            add = { "(", ")%R" },
            find = "%b()%%R",
            delete = "^(%()().-(%)%%R)()$",
        },
    },
})

vim.keymap.set("n", "<M-r>", function()
    -- Store the current buffer ID
    local current_buf = vim.api.nvim_get_current_buf()
    -- Close all buffers except the current one
    vim.cmd("bufdo if bufnr() != " .. current_buf .. " | bd | endif")
    -- Start/restart LSP (assuming you are using 'nvim-lspconfig')
    local coq_lsp_running = #vim.lsp.get_clients({ bufnr = current_buf, name = "coq_lsp" }) == 1
    if coq_lsp_running then
        vim.cmd.LspRestart()
    else
        vim.cmd.LspStart()
    end
end)
