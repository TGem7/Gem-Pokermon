function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
--  Yamask 562
local yamask = {
  name = "yamask",
  pos = PokemonSprites["yamask"].base.pos,
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    end
    local deck_data = ''
    if G.playing_cards then
      local enhance_count = 0
      for k, v in pairs(G.playing_cards) do
        if SMODS.has_enhancement(v, 'm_gold') then enhance_count = enhance_count  + 1 end
      end
      deck_data = '['..tostring(enhance_count)..'/'..tostring(math.ceil(#G.playing_cards/5))..'] '
    end
    return {vars = {deck_data}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      local faces = 0
      for _, scored_card in ipairs(context.scoring_hand) do
        if scored_card:is_face() then
              faces = faces + 1
              scored_card:set_ability('m_gold', nil, true)
              G.E_MANAGER:add_event(Event({
                  func = function()
                      scored_card:juice_up()
                      return true
                  end
              }))
        end
      end
      if faces > 0 then
          return {
              message = localize('k_gold'),
              colour = G.C.MONEY
          }
     end
    end
    return deck_enhance_evo(self, card, context, "j_Gem_cofagrigus", "Gold", .20)
  end,
}

-- Cofagrigus 563
local cofagrigus ={
  name = "cofagrigus",
  pos = PokemonSprites["cofagrigus"].base.pos,
  config = {extra = {discards = 3, discards_remaining = 3, seal = 'Purple'}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_gold
      info_queue[#info_queue+1] = {key = 'purple_seal', set = 'Other'}
    end
    return { vars = { center.ability.extra.discards, center.ability.extra.discards_remaining}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.discard and SMODS.has_enhancement(context.other_card, 'm_gold') and not context.blueprint then
        if card.ability.extra.discards_remaining <= 1 then
            bonus = true
        else
            card.ability.extra.discards_remaining = card.ability.extra.discards_remaining - 1
            return nil, true 
        end
    end
    if context.before and not context.blueprint then
      local faces = 0
      for _, scored_card in ipairs(context.scoring_hand) do
        if scored_card:is_face() then
              faces = faces + 1
                  if bonus then
                    if context.before and context.cardarea == G.jokers and not context.blueprint and context.scoring_hand then
                      local target = context.scoring_hand[1]
                      local args = {seal = card.ability.extra.seal}
                      poke_convert_cards_to(target, args, true, true)
                      bonus = false
                      card.ability.extra.discards_remaining = card.ability.extra.discards
                    end
                  end
              scored_card:set_ability('m_gold', nil, true)
              G.E_MANAGER:add_event(Event({
                  func = function()
                      scored_card:juice_up()
                      return true
                  end
              }))
          end
      end
      if faces > 0 then
          return {
              message = localize('k_gold'),
              colour = G.C.MONEY
          }
      end
    end
    if bonus then
      if context.before and context.cardarea == G.jokers and not context.blueprint and context.scoring_hand then
        local target = context.scoring_hand[1]
        local args = {seal = card.ability.extra.seal}
        poke_convert_cards_to(target, args, true, true)
        bonus = false
        card.ability.extra.discards_remaining = card.ability.extra.discards
     end
    end
  end
}

return {
  name = "Gem's Yamask",
  enabled = Gem_config.Yamask or false,
  list = {yamask, cofagrigus}
}

