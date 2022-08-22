local map = vim.keymap.set

map("n", "<C-'>", function()
    -- Get the file path (without extension)
    local file = vim.api.nvim_buf_get_name(0):match("^(.*)%.cpp")
    local cmd = {
        "g++",
        "-Wall",
        "-std=c++17",
        "-o",
        file .. ".out",
        file .. ".cpp",
        "&&",
        "time",
        file .. ".out",
    }
    return require("utils").compile_and_run({
        name = "CPP_OUTPUT",
        cmd = cmd,
    })
end, { silent = true, buffer = true })
map("n", "<C-CR>", function()
    -- Get the file path (without extension)
    local file = vim.api.nvim_buf_get_name(0):match("^(.*)%.cpp")
    local cmd = {
        "g++",
        "-Wall",
        "-std=c++17",
        "-o",
        file .. ".out",
        file .. ".cpp",
        "&&",
        "time",
        file .. ".out",
    }
    table.insert(cmd, "<input.txt")
    return require("utils").compile_and_run({
        name = "CPP_OUTPUT",
        cmd = cmd,
    })
end, { silent = true, buffer = true })

require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { "cout << ", " << endl;" },
            find = "cout << .- << endl;",
            delete = "^(std::cout << )().-( << std::endl;)()$",
        },
    },
})
