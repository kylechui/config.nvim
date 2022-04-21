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
-- Save/restore code folds
local saveFolds = augroup("saveFolds", {})
autocmd("BufWritePost", {
    command = "silent mkview",
    group = saveFolds,
})
autocmd("BufReadPost", {
    command = "silent! loadview",
    group = saveFolds,
})
-- Format code on save for certain file types
local formatCode = augroup("formatCode", {})
autocmd("BufWritePre", {
    pattern = {
        "*.cpp",
        "*.js",
        "*.lua",
        "*.md",
        "*.ts",
    },
    callback = vim.lsp.buf.formatting_sync,
    group = formatCode,
})
-- Opens PDF files in Zathura instead of viewing the binary in Neovim
local openPDF = augroup("openPDF", {})
autocmd("BufReadPost", {
    pattern = {
        "*.pdf",
    },
    callback = function()
        vim.fn.jobstart("zathura '" .. vim.fn.expand("%") .. "'", {
            detach = true,
        })
        vim.api.nvim_buf_delete(0, {})
    end,
    group = openPDF,
})
