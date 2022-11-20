local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
-- Highlight yanked text
local highlightYank = augroup("highlightYank", {})
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
    end,
    group = highlightYank,
})
-- Format code on save for certain file types
local formatCode = augroup("formatCode", {})
autocmd("BufWritePre", {
    pattern = {
        "*.cpp",
        "*.tex",
        "*.js",
        "*.lua",
        "*.md",
        "*.py",
        "*.ts",
    },
    callback = function()
        vim.lsp.buf.format({
            filter = function(client)
                return client.name == "null-ls"
            end,
            bufnr = 0,
        })
    end,
    group = formatCode,
})
-- Opens PDF files in Zathura instead of viewing the binary in Neovim
local openPDF = augroup("openPDF", {})
autocmd("BufReadPost", {
    pattern = {
        "*.pdf",
    },
    callback = function()
        vim.fn.jobstart('zathura "' .. vim.fn.expand("%") .. '"', {
            detach = true,
        })
        vim.api.nvim_buf_delete(0, {})
    end,
    group = openPDF,
})
-- Refreshes the status line anytime the cursor has moved
local updateStatusline = augroup("updateStatusline", {})
autocmd({ "CursorMoved", "CursorMovedI" }, {
    callback = require("lualine").refresh,
    group = updateStatusline,
})
