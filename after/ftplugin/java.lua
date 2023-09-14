vim.opt_local.colorcolumn = "100"

require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { "System.out.println(", ");" },
            find = "System%.out%.println%b()",
            delete = "^(System%.out%.println%()().-(%);)()$",
        },
    },
})

require("jdtls").start_or_attach({
    on_attach = function()
        local map = vim.keymap.set
        map("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = true })
        map("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = true })
        map("n", "K", vim.lsp.buf.hover, { silent = true, buffer = true })
        map("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = true })
        map("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = true })
        map("n", "<Leader>dl", require("telescope.builtin").diagnostics, { buffer = true })
        map("n", "<Leader>r", require("utils").rename_var, { buffer = true })
        map("n", "<Leader>c", vim.lsp.buf.code_action, { buffer = true })
    end,
    cmd = {
        "/etc/profiles/per-user/kylec/bin/jdt-language-server",
        "-data",
        "/home/kylec/.cache/jdtls" .. vim.env.PWD,
    },
    root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
})
