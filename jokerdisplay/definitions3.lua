local jd_def = JokerDisplay.Definitions

--	Treecko
jd_def["j_Gem_treecko"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
    { text = "x", scale = 0.35 },
    { text = "$", colour = G.C.GOLD},
    { ref_table = "card.ability.extra", ref_value = "money_mod", colour = G.C.GOLD },
  },
  reminder_text = {
    {text = "["},
    { ref_table = "card.joker_display_values", ref_value = "nature1",},
    { text = ", " },
    { ref_table = "card.joker_display_values", ref_value = "nature2",},
    { text = ", " },
    { ref_table = "card.joker_display_values", ref_value = "nature3",},
    {text = "]"},
  },
  extra = {
    {
      { text = "(", colour = G.C.GREEN, scale = 0.3 },
      { ref_table = "card.joker_display_values", ref_value = "odds", colour = G.C.GREEN, scale = 0.3 },
      { text = ")", colour = G.C.GREEN, scale = 0.3 },
    },
  },
  calc_function = function(card)
    local count = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, scoring_card in pairs(scoring_hand) do
        if scoring_card:get_id() == card.ability.extra.targets[1].id or
          scoring_card:get_id() == card.ability.extra.targets[2].id or
          scoring_card:get_id() == card.ability.extra.targets[3].id then
          count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
        end
      end
    end
    card.joker_display_values.count = count
    card.joker_display_values.nature1 = localize(card.ability.extra.targets[1].value, 'ranks')
    card.joker_display_values.nature2 = localize(card.ability.extra.targets[2].value, 'ranks')
    card.joker_display_values.nature3 = localize(card.ability.extra.targets[3].value, 'ranks')
    local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, 'treecko')
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { num, dem } }
  end
}

--	Grovyle
jd_def["j_Gem_grovyle"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
    { text = "x", scale = 0.35 },
    { text = "$", colour = G.C.GOLD},
    { ref_table = "card.ability.extra", ref_value = "money_mod", colour = G.C.GOLD },
  },
  reminder_text = {
    {text = "["},
    { ref_table = "card.joker_display_values", ref_value = "nature1",},
    { text = ", " },
    { ref_table = "card.joker_display_values", ref_value = "nature2",},
    { text = ", " },
    { ref_table = "card.joker_display_values", ref_value = "nature3",},
    {text = "]"},
  },
  extra = {
    {
      { text = "(", colour = G.C.GREEN, scale = 0.3 },
      { ref_table = "card.joker_display_values", ref_value = "odds", colour = G.C.GREEN, scale = 0.3 },
      { text = ")", colour = G.C.GREEN, scale = 0.3 },
    },
  },
  calc_function = function(card)
    local count = 0
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, scoring_card in pairs(scoring_hand) do
        if scoring_card:get_id() == card.ability.extra.targets[1].id or
          scoring_card:get_id() == card.ability.extra.targets[2].id or
          scoring_card:get_id() == card.ability.extra.targets[3].id then
          count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
        end
      end
    end
    card.joker_display_values.count = count
    card.joker_display_values.nature1 = localize(card.ability.extra.targets[1].value, 'ranks')
    card.joker_display_values.nature2 = localize(card.ability.extra.targets[2].value, 'ranks')
    card.joker_display_values.nature3 = localize(card.ability.extra.targets[3].value, 'ranks')
    local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, 'grovyle')
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { num, dem } }
  end
}

--	Sceptile
jd_def["j_Gem_sceptile"] = {
  text = {
    { text = "+$", colour = G.C.GOLD },
    { ref_table = "card.joker_display_values", ref_value = "money", colour = G.C.GOLD },
  },
  reminder_text = {
    { text = "[" },
    { ref_table = "card.joker_display_values", ref_value = "nature1" },
    { text = ", " },
    { ref_table = "card.joker_display_values", ref_value = "nature2" },
    { text = ", "},
    { ref_table = "card.joker_display_values", ref_value = "nature3" },
    { text = "]" },
  },
  calc_function = function(card)
    local count = 0
    local grass_count = find_other_poke_or_energy_type(card, "Grass", true)
    if is_type(card, "Grass") then
      grass_count = grass_count - 1
    end
    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
    if text ~= 'Unknown' then
      for _, scoring_card in pairs(scoring_hand) do
        if scoring_card:get_id() == card.ability.extra.targets[1].id or
          scoring_card:get_id() == card.ability.extra.targets[2].id or
          scoring_card:get_id() == card.ability.extra.targets[3].id then
          count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
        end
      end
    end
    card.joker_display_values.money = count * (card.ability.extra.money_mod + (card.ability.extra.money_increase * grass_count))
    card.joker_display_values.nature1 = localize(card.ability.extra.targets[1].value, 'ranks')
    card.joker_display_values.nature2 = localize(card.ability.extra.targets[2].value, 'ranks')
    card.joker_display_values.nature3 = localize(card.ability.extra.targets[3].value, 'ranks')
  end
}

--	Torchic
jd_def["j_Gem_torchic"] = {
    text = {
        { text = "+",                              colour = G.C.MULT },
        { ref_table = "card.joker_display_values",        ref_value = "mult", colour = G.C.MULT },
    },
    reminder_text = {
            {text = "["},
            { ref_table = "card.joker_display_values", ref_value = "nature1",},
            { text = ", "},
            { ref_table = "card.joker_display_values", ref_value = "nature2",},
            { text = ", " },
            { ref_table = "card.joker_display_values", ref_value = "nature3",},
            {text = "]"},
    },
    calc_function = function(card)
        local mult = card.ability.extra.mult * card.ability.extra.cards_discarded
        card.joker_display_values.mult = mult
        card.joker_display_values.nature1 = localize(card.ability.extra.targets[1].value, 'ranks')
        card.joker_display_values.nature2 = localize(card.ability.extra.targets[2].value, 'ranks')
        card.joker_display_values.nature3 = localize(card.ability.extra.targets[3].value, 'ranks')
    end
}

--	Combusken
jd_def["j_Gem_combusken"] = {
    text = {
        { text = "+",                              colour = G.C.MULT },
        { ref_table = "card.joker_display_values",        ref_value = "mult", colour = G.C.MULT },
    },
    reminder_text = {
            {text = "["},
            { ref_table = "card.joker_display_values", ref_value = "nature1",},
            { text = ", "},
            { ref_table = "card.joker_display_values", ref_value = "nature2",},
            { text = ", "},
            { ref_table = "card.joker_display_values", ref_value = "nature3",},
            {text = "]"},
    },
    calc_function = function(card)
        local mult = card.ability.extra.mult * card.ability.extra.cards_discarded
        card.joker_display_values.mult = mult
        card.joker_display_values.nature1 = localize(card.ability.extra.targets[1].value, 'ranks')
        card.joker_display_values.nature2 = localize(card.ability.extra.targets[2].value, 'ranks')
        card.joker_display_values.nature3 = localize(card.ability.extra.targets[3].value, 'ranks')
    end
}

--	Blaziken
jd_def["j_Gem_blaziken"] = {
    text = {
        { text = "+" ,
        colour = G.C.MULT},
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult", 
        colour = G.C.MULT},
        {text = " "},
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult" }
            },
            border_colour = G.C.MULT
        }
    },
    reminder_text = {
            {text = "["},
            { ref_table = "card.joker_display_values", ref_value = "nature1",},
            { text = ", "},
            { ref_table = "card.joker_display_values", ref_value = "nature2",},
            { text = ", "},
            { ref_table = "card.joker_display_values", ref_value = "nature3",},
            {text = "]"},
    },
    text_config = { colour = G.C.WHITE },
    calc_function = function(card)
        local mult = card.ability.extra.mult * card.ability.extra.cards_discarded * (find_other_poke_or_energy_type(card, "Fire", true) + find_other_poke_or_energy_type(card, "Fighting", true))
        local Xmult = 1 + card.ability.extra.Xmult * card.ability.extra.cards_discarded * (find_other_poke_or_energy_type(card, "Fire", true) + find_other_poke_or_energy_type(card, "Fighting", true))
        card.joker_display_values.mult = mult
        card.joker_display_values.Xmult = Xmult
        card.joker_display_values.nature1 = localize(card.ability.extra.targets[1].value, 'ranks')
        card.joker_display_values.nature2 = localize(card.ability.extra.targets[2].value, 'ranks')
        card.joker_display_values.nature3 = localize(card.ability.extra.targets[3].value, 'ranks')
    end
}

--	Mudkip
jd_def["j_Gem_mudkip"] = {
    text = {
        { text = "+",                              colour = G.C.CHIPS },
        { ref_table = "card.joker_display_values",        ref_value = "chips", colour = G.C.CHIPS },
    },
    reminder_text = {
            {text = "["},
            { ref_table = "card.joker_display_values", ref_value = "nature1",},
            { text = ", " },
            { ref_table = "card.joker_display_values", ref_value = "nature2",},
            { text = ", "},
            { ref_table = "card.joker_display_values", ref_value = "nature3",},
            {text = "]"},
    },
    calc_function = function(card)
        local count = 0
        local chips = card.ability.extra.chips
        if find_other_poke_or_energy_type(card, "Water") > 0 or find_other_poke_or_energy_type(card, "Earth") > 0 then
          chips = chips * 2
        end
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() == card.ability.extra.targets[1].id or
                   scoring_card:get_id() == card.ability.extra.targets[2].id or
                   scoring_card:get_id() == card.ability.extra.targets[3].id then              
                    count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.chips = count * chips
        card.joker_display_values.nature1 = localize(card.ability.extra.targets[1].value, 'ranks')
        card.joker_display_values.nature2 = localize(card.ability.extra.targets[2].value, 'ranks')
        card.joker_display_values.nature3 = localize(card.ability.extra.targets[3].value, 'ranks')
    end
}

--	Marshtomp
jd_def["j_Gem_marshtomp"] = {
    text = {
        { text = "+",                              colour = G.C.CHIPS },
        { ref_table = "card.joker_display_values",        ref_value = "chips", colour = G.C.CHIPS },
    },
    reminder_text = {
            {text = "["},
            { ref_table = "card.joker_display_values", ref_value = "nature1",},
            { text = ", " },
            { ref_table = "card.joker_display_values", ref_value = "nature2",},
            { text = ", "},
            { ref_table = "card.joker_display_values", ref_value = "nature3",},
            {text = "]"},
    },
    calc_function = function(card)
        local count = 0
        local chips = card.ability.extra.chips
        if find_other_poke_or_energy_type(card, "Water") > 0 or find_other_poke_or_energy_type(card, "Earth") > 0 then
          chips = chips * 2
        end
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() == card.ability.extra.targets[1].id or
                   scoring_card:get_id() == card.ability.extra.targets[2].id or
                   scoring_card:get_id() == card.ability.extra.targets[3].id then              
                    count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.chips = count * chips
        card.joker_display_values.nature1 = localize(card.ability.extra.targets[1].value, 'ranks')
        card.joker_display_values.nature2 = localize(card.ability.extra.targets[2].value, 'ranks')
        card.joker_display_values.nature3 = localize(card.ability.extra.targets[3].value, 'ranks')
    end
}

--	Swampert
jd_def["j_Gem_swampert"] = {
    text = {
        { text = "+",                              colour = G.C.CHIPS },
        { ref_table = "card.joker_display_values",        ref_value = "chips", colour = G.C.CHIPS },
    },
    reminder_text = {
            {text = "["},
            { ref_table = "card.joker_display_values", ref_value = "nature1",},
            { text = ", " },
            { ref_table = "card.joker_display_values", ref_value = "nature2",},
            { text = ", "},
            { ref_table = "card.joker_display_values", ref_value = "nature3",},
            {text = "]"},
    },
    calc_function = function(card)
        local count = 0
        local chips = card.ability.extra.chips
        if find_other_poke_or_energy_type(card, "Water") or find_other_poke_or_energy_type(card, "Earth") then
          chips = chips + card.ability.extra.chip_mod * (find_other_poke_or_energy_type(card, "Water") + find_other_poke_or_energy_type(card, "Earth"))
        end
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() == card.ability.extra.targets[1].id or
                   scoring_card:get_id() == card.ability.extra.targets[2].id or
                   scoring_card:get_id() == card.ability.extra.targets[3].id then              
                    count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.chips = count * chips
        card.joker_display_values.nature1 = localize(card.ability.extra.targets[1].value, 'ranks')
        card.joker_display_values.nature2 = localize(card.ability.extra.targets[2].value, 'ranks')
        card.joker_display_values.nature3 = localize(card.ability.extra.targets[3].value, 'ranks')
    end
}
