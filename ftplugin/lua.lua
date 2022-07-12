local map = vim.keymap.set

map("n", "<Leader>t", function()
    local cur_path = vim.fn.expand("%:p:h")
    while cur_path and vim.fn.finddir("tests", cur_path) == "" do
        cur_path = cur_path:match("(.*)/.*")
    end

    if cur_path then
        cur_path = cur_path .. "/tests"
        local ls = vim.fn.systemlist("ls " .. cur_path)
        if #ls == 0 then
            print("No test file found.")
            return
        end
        require("plenary.test_harness").test_directory(
            cur_path .. "/" .. ls[1]
        )
    end
end, {
    silent = true,
    buffer = true,
})
