---@diagnostic disable: undefined-global

return {
    s({ trig = "fn", regTrig = true, wordTrig = true }, {
        t("function("),
        i(1),
        t({ ")", "\t" }),
        i(0),
        t({ "", "end" }),
    }),
},
    nil
