function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Cubone 104
local cubone={
  name = "cubone", 
  pos = PokemonSprites["cubone"].base.pos, 
  config = {extra = {mult = 6, consumables_used = 0}, evo_rqmt = 28},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Thick Club"}}
    info_queue[#info_queue+1] = G.P_CENTERS.c_poke_thickclub
    info_queue[#info_queue+1] = G.P_CENTERS.c_poke_firestone
    local consumables_left = math.max(0, self.config.evo_rqmt - card.ability.extra.consumables_used)
    return {vars = {card.ability.extra.mult, card.ability.extra.mult * ((G.consumeables and #G.consumeables.cards or 0) + #find_joker('thickclub')), consumables_left}}
  end,
  rarity = 1, 
  cost = 5, 
  item_req = "firestone",
  stage = "Basic", 
  ptype = "Earth",
  joblacklist = true,
  atlas = "AtlasJokersBasicNatdex",
  gen = 1,
  blueprint_compat = true,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_poke_thickclub')
      _card:add_to_deck()
      G.consumeables:emplace(_card)
      card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.C.FILTER})
    end
  end,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local count = #G.consumeables.cards + #find_joker('thickclub')
        if count > 0 then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult * count}}, 
            colour = G.C.MULT,
            mult_mod = card.ability.extra.mult * count
          }
        end
      end
    end
    if context.using_consumeable then
      card.ability.extra.consumables_used = card.ability.extra.consumables_used + 1
    end
        local evolve = item_evo(self, card, context, "j_Gem_alolan_marowak")
    if evolve then
      return evolve
    else 
      return scaling_evo(self, card, context, "j_Gem_marowak", card.ability.extra.consumables_used, self.config.evo_rqmt)
    end
  end,
}
-- Marowak 105
local marowak={
  name = "marowak", 
  pos = PokemonSprites["marowak"].base.pos, 
  config = {extra = {Xmult_mod = 0.4, card_limit = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.c_poke_thickclub
    local count = (G.consumeables and #G.consumeables.cards) or 0 
    count = count + #find_joker('thickclub')
    return {vars = {center.ability.extra.Xmult_mod, center.ability.extra.card_limit, 
                    1 + (center.ability.extra.Xmult_mod * count)}}
  end,
  rarity = "poke_safari", 
  cost = 8, 
  stage = "One", 
  ptype = "Earth",
  joblacklist = true,
  atlas = "AtlasJokersBasicNatdex",
  gen = 1,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local count = #G.consumeables.cards + #find_joker('thickclub')
        if count > 0 then
          return {
            message = localize{type = 'variable', key = 'a_xmult', vars = {1 + (card.ability.extra.Xmult_mod * count)}}, 
            colour = G.C.XMULT,
            Xmult_mod = 1 + (card.ability.extra.Xmult_mod * count)
          }
        end
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.card_limit
      return true end }))
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.card_limit
      return true end }))
  end, 
}
-- Alolan Marowak
local alolan_marowak={
  name = "alolan_marowak", 
  pos = {x = 6, y = 4},
  config = {extra = {xmult = 1, Xmult_mod = 0.4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.c_poke_thickclub
    local count = #find_joker('thickclub')
    local xmult = center.ability.extra.xmult + center.ability.extra.Xmult_mod * count
    return { vars = {center.ability.extra.xmult, center.ability.extra.Xmult_mod, 
                     xmult}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fire",
  atlas = "AtlasJokersBasicGen01",
  gen = 1,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
        if context.selling_card and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.Xmult_mod
            return {
                message = localize('k_upgrade_ex')
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.GAME.blind.boss and card.ability.extra.xmult > 1 then
                card.ability.extra.xmult = 1
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
         if context.cardarea == G.jokers and context.scoring_hand then
          local count = #find_joker('thickclub')
            return {
              colour = G.C.XMULT,
              xmult = card.ability.extra.xmult + card.ability.extra.Xmult_mod * count
            }
        end
     end
  end,
}

if Gem_config.Cubone then
  list = {cubone, marowak, alolan_marowak}
else list = {}
end


return {name = "Cubone",
list = list
}
