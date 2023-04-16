require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { "System.out.println(", ");" },
            find = "System%.out%.println%b()",
            delete = "^(System%.out%.println%()().-(%);)()$",
        },
    },
})
