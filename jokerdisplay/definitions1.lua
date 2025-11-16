local jd_def = JokerDisplay.Definitions


jd_def["j_Gem_cubone"] = {
    text = {
        { text = "+",colour = G.C.MULT },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult",colour = G.C.MULT }
    },
    calc_function = function(card)
        local mult = 0
        local consumables = 0
        if G.consumeables then
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.name == "thickclub" then
                    consumables = consumables + 2
                elseif G.consumeables.cards[i].ability.name ~= "thickclub" then
                    consumables = consumables + 1
                end
            end
        end
        mult = card.ability.extra.mult * consumables
        card.joker_display_values.mult = mult
    end
}

jd_def["j_Gem_marowak"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
    text_config = { colour = G.C.WHITE },
    calc_function = function(card)
        local Xmult = 1
        local clubs = 0
        local consumables = 0
        if G.consumeables then
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.name == "thickclub" then
                    clubs = clubs + 1
                elseif G.consumeables.cards[i].ability.name ~= "thickclub" then
                    consumables = consumables + 1
                end
            end
        end
        Xmult = 1 + (card.ability.extra.Xmult_mod*consumables) + (card.ability.extra.Xmult_mod*2*clubs)
        card.joker_display_values.x_mult = Xmult
    end
}