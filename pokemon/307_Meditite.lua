function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Meditite
local meditite={
  name = "meditite", 
  
  pos = PokemonSprites["meditite"].base.pos,
  config = {extra = {mult = 0, mult_mod = .5, rounds = 4,}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local mult_total = center.ability.extra.mult
    if G.deck and G.deck.cards then
      for k, v in pairs(G.deck.cards) do
        if v:is_face() then mult_total = mult_total + center.ability.extra.mult_mod end
      end
    end
    if G.deck and G.deck.cards then
      for k, v in pairs(G.deck.cards) do
        if v:get_id() == 14 then mult_total = mult_total + center.ability.extra.mult_mod end
      end
    end
    return {vars = {center.ability.extra.mult, center.ability.extra.rounds, center.ability.extra.mult_mod, math.max(0, mult_total)}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Fighting",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local Mult = card.ability.extra.mult
        for k, v in pairs(G.deck.cards) do
          if v:is_face() then Mult = Mult + card.ability.extra.mult_mod end
        end
        for k, v in pairs(G.deck.cards) do
          if v:get_id() == 14 then Mult = Mult + card.ability.extra.mult_mod end
        end
        if Mult > 0 then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {Mult}}, 
            colour = G.C.MULT,
            mult_mod = Mult
          }
        end
      end
    end
    return level_evo(self, card, context, "j_Gem_medicham")
  end,
}
-- Medicham
local medicham={
  name = "medicham", 
  
  pos = PokemonSprites["medicham"].base.pos,
  config = {extra = {mult = 0, mult_mod = 1, Xchips_multi = 2}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local mult_total = center.ability.extra.mult
    if G.deck and G.deck.cards then
      for k, v in pairs(G.deck.cards) do
        if v:is_face() then mult_total = mult_total + center.ability.extra.mult_mod end
      end
    end
    if G.deck and G.deck.cards then
      for k, v in pairs(G.deck.cards) do
        if v:get_id() == 14 then mult_total = mult_total + center.ability.extra.mult_mod end
      end
    end
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.Xchips_multi, math.max(0, mult_total)}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fighting",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 then
          if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
            local total_chips = poke_total_chips(context.other_card)
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
            return {
              message = localize('poke_pure_power_ex'),
              colour = G.C.CHIPS,
              chips = total_chips,
              card = card
            }
          end
        end
      end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local Mult = card.ability.extra.mult
        for k, v in pairs(G.deck.cards) do
          if v:is_face() then Mult = Mult + card.ability.extra.mult_mod end
        end
        for k, v in pairs(G.deck.cards) do
          if v:get_id() == 14 then Mult = Mult + card.ability.extra.mult_mod end
        end
        if Mult > 0 then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {Mult}}, 
            colour = G.C.MULT,
            mult_mod = Mult
          }
        end
      end
    end
  end,
  megas = { "mega_medicham" },
}
-- Mega Medicham
local mega_medicham={
  name = "mega_medicham", 
  
  pos = {x = 2, y = 5},
  soul_pos = {x = 3, y = 5},
  config = {extra = {xmult = 1, Xmult_mod = 0.25, Xchips_multi = 3, blackhole_amount = 2}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local xmult_total = center.ability.extra.xmult
    if G.deck and G.deck.cards then
      for k, v in pairs(G.deck.cards) do
        if v:get_id() == 14 then xmult_total = xmult_total + center.ability.extra.Xmult_mod end
      end
    end
    info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Strength"}}
    return {vars = {center.ability.extra.xmult, center.ability.extra.Xmult_mod, center.ability.extra.Xchips_multi, math.max(0, xmult_total), center.ability.extra.blackhole_amount}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Fighting",
  atlas = "AtlasJokersBasicGen03",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 then
          if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
            local total_chips = poke_total_chips(context.other_card)
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
            return {
              message = localize('poke_pure_power_ex'),
              colour = G.C.CHIPS,
              chips = total_chips + total_chips,
              card = card
            }
          end
        end
      end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local xMult = card.ability.extra.xmult
        for k, v in pairs(G.deck.cards) do
          if v:get_id() == 14 then xMult = xMult + card.ability.extra.Xmult_mod end
        end
        if xMult > 0 then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {xMult}}, 
            colour = G.C.MULT,
            Xmult_mod = xMult
          }
        end
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then
      for _ = 1,card.ability.extra.blackhole_amount do
        local _card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_strength")
        local edition = {negative = true}
        _card:set_edition(edition, true)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
      end
    end
  end,
}

return {
  name = "Gem's Meditite",
  enabled = Gem_config.Meditite or false,
  list = { meditite, medicham, mega_medicham }
}


