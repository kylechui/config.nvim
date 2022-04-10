---@diagnostic disable: undefined-global

return {
    -- All: Prints the current date in Y-m-d format
    s(
        "date",
        f(function()
            return os.date("%Y-%m-%d")
        end)
    ),
}, nil
