local map = vim.keymap.set

map("n", "<C-'>", function()
    local name = "__CPP_OUTPUT__"
    local cur_bufnr, bufnr = vim.fn.bufnr()
    if vim.fn.bufwinnr(name) == -1 then
        vim.cmd("botright vsplit")
        local win = vim.api.nvim_get_current_win()
        vim.cmd("vertical resize 86")

        bufnr = vim.fn.bufnr(name)
        if bufnr == -1 then
            bufnr = vim.api.nvim_create_buf(true, true)
            vim.api.nvim_buf_set_name(bufnr, name)
        end
        vim.api.nvim_win_set_buf(win, bufnr)
    else
        vim.cmd(vim.fn.bufwinnr(name) .. "wincmd w")
    end

    local prefix = vim.api.nvim_buf_get_name(cur_bufnr):match("^(.*)%.cpp$")
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Compiling and running " .. prefix .. ".out:" })
    -- Compile the project
    vim.fn.jobstart({ "g++", "-Wall", "-std=c++17", "-o", prefix .. ".out", prefix .. ".cpp" }, {
        stderr_buffered = true,
        on_stderr = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
            end
        end,
    })
    -- Actually run the executable
    vim.fn.jobstart({ "time", prefix .. ".out" }, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
            end
        end,
        on_stderr = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
            end
        end,
        on_exit = function()
            vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { ("="):rep(35) .. " COMPLETE " .. ("="):rep(35) })
        end,
    })
end, { silent = true, buffer = true })
map(
    "n",
    "<C-CR>",
    "<Cmd>!g++ -Wall -std=c++17 -o '%:r.out' '%'<CR><Cmd>term time './%:r.out'<'%:h/input.txt'<CR>",
    { silent = true, buffer = true }
)

require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = function()
                for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
                    if line == "using namespace std;" then
                        return { { "cout << " }, { " << endl;" } }
                    end
                end
                return { { "std::cout << " }, { " << std::endl;" } }
            end,
            find = "cout << .- << endl;",
            delete = "^(cout << )().-( << endl;)()$",
        },
    },
})
