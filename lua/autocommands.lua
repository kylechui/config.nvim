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
        "*.c",
        "*.cc",
        "*.cpp",
        "*.css",
        "*.gleam",
        "*.h",
        "*.hpp",
        "*.hs",
        "*.java",
        "*.js",
        "*.lua",
        "*.md",
        "*.ml",
        "*.mli",
        "*.nix",
        "*.py",
        "*.rs",
        "*.tex",
        "*.ts",
        "*.tsx",
    },
    callback = function()
        vim.lsp.buf.format()
    end,
    group = formatCode,
})
-- Opens non-text files in the default program instead of in Neovim
local openFile = augroup("openFile", {})
autocmd("BufReadPost", {
    pattern = {
        "*.epub",
        "*.jpeg",
        "*.jpg",
        "*.pdf",
        "*.png",
    },
    callback = function()
        vim.fn.jobstart('xdg-open "' .. vim.fn.expand("%") .. '"', {
            detach = true,
        })
        vim.api.nvim_buf_delete(0, {})
    end,
    group = openFile,
})
