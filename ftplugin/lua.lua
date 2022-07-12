local map = vim.keymap.set

map("n", "<Leader>t", function()
    local cur_path = vim.fn.expand("%:p:h")
    while cur_path and vim.fn.finddir("tests", cur_path) == "" do
        cur_path = cur_path:match("(.*)/.*")
    end

    if cur_path then
        cur_path = cur_path .. "/tests"
        local file_name = vim.fn.systemlist("ls " .. cur_path)[1]
        require("plenary.test_harness").test_directory(vim.fn.findfile(
            file_name,
            cur_path)
        )
    end
end, {
    silent = true,
    buffer = true,
})
