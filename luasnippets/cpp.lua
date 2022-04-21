---@diagnostic disable: undefined-global

local standardize = function(type)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        if line:match("using namespace std;") then
            return type
        end
    end
    return "std::" .. type
end

return {
    -- C++: Basic coding environment template
    s(
        "setup",
        fmt(
            [[
                #include <bits/stdc++.h>
                using namespace std;
                using ll = long long;
                using ld = long double;

                int main() {{
                    {}{}
                }}
            ]],
            {
                c(1, {
                    t(""),
                    -- TODO: Figure out indentation nonsense
                    t({
                        "int N;",
                        "\tcin >> N;",
                        "\tvector<int> arr(N);",
                        "\tfor (size_t i = 0; i < N; i++) {",
                        "\t\tcin >> arr[i];",
                        "\t}",
                        "\t",
                    }),
                }),
                i(0),
            }
        )
    ),
    -- C++: Auto-documenting functions
    s(
        "fn",
        fmt(
            [[
                /**
                * {}
                */
                {} {}({}) {{
                    {}
                }}
            ]],
            {
                d(4, function(args)
                    local pos = 1
                    local nodes = {}
                    local returnValue = args[1][1]
                    local params = string.gmatch(args[2][1] .. ",", "%a+,")
                    -- Add a node for the function description
                    table.insert(nodes, i(pos, "Function description."))
                    pos = pos + 1
                    -- Add lines for each parameter in the function
                    for param in params do
                        param = param:sub(1, -2)
                        table.insert(nodes, t({ "", "" }))
                        table.insert(
                            nodes,
                            sn(
                                pos,
                                fmt(
                                    [[
                                        * @param {} {}
                                    ]],
                                    {
                                        t({ param }),
                                        i(1),
                                    }
                                )
                            )
                        )
                        pos = pos + 1
                    end
                    -- Add a node if there is a return type
                    if returnValue ~= "void" then
                        table.insert(nodes, t({ "", "" }))
                        table.insert(
                            nodes,
                            sn(
                                pos,
                                fmt(
                                    [[
                                        * @return {}
                                    ]],
                                    {
                                        i(1),
                                    }
                                )
                            )
                        )
                        pos = pos + 1
                    end
                    return sn(nil, nodes)
                end, { 1, 3 }),
                c(1, {
                    i(nil, "void"),
                    i(nil, "int"),
                    d(nil, function()
                        return sn(1, i(1, standardize("string")))
                    end),
                    i(nil, "bool"),
                }),
                i(2, "functionName"),
                i(3),
                i(0),
            }
        )
    ),
    -- C++: Include header
    s(
        "include",
        fmt(
            [[
                #include {}
            ]],
            {
                c(1, {
                    fmt(
                        [[
                            <{}>
                        ]],
                        {
                            i(1, "bits/stdc++.h"),
                        }
                    ),
                    fmt(
                        [[
                            "{}.h"
                        ]],
                        {
                            i(1, "HeaderFile"),
                        }
                    ),
                }),
            }
        )
    ),
    -- C++: Choice for loops
    s(
        "for",
        fmt(
            [[
                for ({}) {{
                    {}
                }}
            ]],
            {
                c(1, {
                    fmt(
                        [[
                            size_t {} = {}; {} < {}; {}++
                        ]],
                        {
                            i(1, "i"),
                            i(2, "0"),
                            rep(1),
                            i(3, "arr.size()"),
                            rep(1),
                        }
                    ),
                    fmt(
                        [[
                            {}& {} : {}
                        ]],
                        {
                            i(1, "auto"),
                            i(2, "e"),
                            i(3, "arr"),
                        }
                    ),
                }),
                i(0),
            }
        )
    ),
    -- C++: Printing
    s("cout", {
        f(function()
            return standardize("cout") .. " << "
        end),
        i(1),
        f(function()
            return " << " .. standardize("endl;")
        end),
    }),
    -- C++: Vector
    s("vec", {
        f(function()
            return standardize("vector<")
        end),
        c(1, {
            i(1, "int"),
            d(1, function()
                return sn(1, i(1, standardize("string")))
            end),
            i(1, "bool"),
        }),
        t(">"),
    }),
    -- C++: Unordered map
    s("umap", {
        f(function()
            return standardize("unordered_map<")
        end),
        c(1, {
            i(1, "int"),
            d(1, function()
                return sn(1, i(1, standardize("string")))
            end),
            i(1, "bool"),
        }),
        t(", "),
        c(2, {
            i(1, "int"),
            d(1, function()
                return sn(1, i(1, standardize("string")))
            end),
            i(1, "bool"),
        }),
        t(">"),
    }),
    -- C++: Priority Queue
    s("pq", {
        f(function()
            return standardize("priority_queue<int, ") .. standardize("vector<int>")
        end),
        c(1, {
            t(""),
            sn(nil, {
                t(", "),
                i(1, standardize("greater<int>"))
            }),
        }),
        t(">"),
    }),
}, nil
