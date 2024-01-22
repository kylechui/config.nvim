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
        s({ trig = "\\psi", wordTrig = true }, {
            t("ψ"),
        }),
        s({ trig = "\\phi", wordTrig = true }, {
            t("φ"),
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
