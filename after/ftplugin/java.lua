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
    on_attach = require("lsp").setup_lsp_keymaps,
    cmd = {
        "/etc/profiles/per-user/kylec/bin/jdt-language-server",
        "-data",
        "/home/kylec/.cache/jdtls" .. vim.env.PWD,
    },
    root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
})
