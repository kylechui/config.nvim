return nil,
    {
        s({ trig = "ket", wordTrig = true }, {
            t("∣"),
            i(1),
            t("⟩"),
        }),
        s({ trig = "bra", wordTrig = true }, {
            t("⟨"),
            i(1),
            t("∣"),
        }),
        s({ trig = "xx", wordTrig = true }, {
            t("×"),
        }),
        s({ trig = "ox", wordTrig = true }, {
            t("⊗"),
        }),
        s({ trig = "++", wordTrig = true }, {
            t("†"),
        }),
    }
