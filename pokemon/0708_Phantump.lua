function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
-- Phantump 708
local phantump={
  name = "phantump", 
  pos = PokemonSprites["phantump"].base.pos,
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {}}
  end,
  rarity = 2, 
  cost = 6, 
  item_req = "linkcable",
  stage = "Basic", 
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  gen = 6,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers and not context.blueprint then
      local _card = context.scoring_hand[1]
      if _card.config.center == G.P_CENTERS.c_base and _card:get_id() == 4 then
        _card:set_ability("m_poke_seed",nil,true)
      end
    end
    return item_evo(self, card, context, "j_Gem_trevenant")
  end
}

-- Trevenant 743
local trevenant={
  name = "trevenant", 
  pos = PokemonSprites["trevenant"].base.pos,
  config = {extra = {fours_remaining = 10}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.fours_remaining}}
  end,
  rarity = 'poke_safari', 
  cost = 8, 
  stage = "One", 
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  gen = 7,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      local fours = 0
      for _, scored_card in ipairs(context.scoring_hand) do
        if scored_card:get_id() == 4 then
          if scored_card.config.center == G.P_CENTERS.c_base then
              fours = fours + 1
              scored_card:set_ability('m_poke_seed', nil, true)
              G.E_MANAGER:add_event(Event({
                  func = function()
                      scored_card:juice_up()
                      return true
                  end
              }))
          else
            fours = fours + 1
          end
        end
      end
      if fours > 0 then
          return {
              message = localize('Gem_leech_seed'),
              colour = G.C.MONEY
          }
     end
    end
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
        if context.other_card:get_id() == 4 then
            card.ability.extra.fours_remaining = card.ability.extra.fours_remaining - 1
            if card.ability.extra.fours_remaining <= 0 then
              card.ability.extra.fours_remaining = 10
              apply_type_sticker(G.jokers.cards[1], "Grass")
              card:juice_up()
              card_eval_status_text(G.jokers.cards[1], 'extra', nil, nil, nil, {message = localize("Gem_forest_curse"), colour = G.C.SECONDARY_SET.Spectral})
            end
        end
    end
  end
}


return {
  name = "Gem's Phantump",
  enabled = Gem_config.Phantump or false,
  list = { phantump, trevenant }
}

