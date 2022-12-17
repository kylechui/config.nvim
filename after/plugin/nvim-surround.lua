require("nvim-surround").setup({
    surrounds = {
        ["f"] = {
            change = {
                target = function()
                    local selection = require("nvim-surround.config").get_selection({
                        query = {
                            capture = "@function_name",
                            type = "nvim-surround",
                        },
                    })
                    if not selection then
                        return nil
                    end
                    local func_name = require("nvim-surround.config").get_input("Enter a function name: ")
                    return {
                        left = func_name,
                        right = {
                            first_pos = { selection.last_pos[1], selection.last_pos[2] + 1 },
                            last_pos = selection.last_pos,
                        },
                    }
                end,
            },
        },
    },
})
