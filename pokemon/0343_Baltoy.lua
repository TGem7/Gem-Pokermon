function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
--  Baltoy 343
local baltoy = {
  name = "baltoy",
  pos = PokemonSprites["baltoy"].base.pos,
  config = {extra = {mult = 0, hazard_level = 1, mult_mod = 1}, evo_rqmt = 20},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'hazard_level', vars = poke_get_hazard_level_vars()}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.hazard_level}}
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  designer = "Rufia",
  gen = 3,
  hazard_poke = true,
  blueprint_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.discard and SMODS.has_enhancement(context.other_card, 'm_poke_hazard') and not context.blueprint then
          card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
          return {
            message = localize('k_upgrade_ex'),
            colour = G.C.MULT
          }
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and card.ability.extra.mult > 0 then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult 
        }
      end
    end
    return scaling_evo(self, card, context, "j_Gem_claydol", card.ability.extra.mult, self.config.evo_rqmt)
  end,
  add_to_deck = function(self, card, from_debuff)
    poke_change_hazard_level(card.ability.extra.hazard_level)
  end,
  remove_from_deck = function(self, card, from_debuff)
    poke_change_hazard_level(-card.ability.extra.hazard_level)
  end
}

--  Claydol 344
local claydol = {
  name = "claydol",
  pos = PokemonSprites["claydol"].base.pos,
  config = {extra = {mult = 0, hazard_level = 1, mult_mod = 1, discards_remaining = 3}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'hazard_level', vars = poke_get_hazard_level_vars()}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.hazard_level, center.ability.extra.discards_remaining}}
  end,
  rarity = 'poke_safari',
  cost = 8,
  stage = "One",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  designer = "Rufia",
  gen = 3,
  hazard_poke = true,
  blueprint_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)

    if context.discard and SMODS.has_enhancement(context.other_card, 'm_poke_hazard') and not context.blueprint then
      if card.ability.extra.discards_remaining == 1 then
        card.ability.extra.discards_remaining = 3
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.0,
            func = (function()
                    local card = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'clay')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = 0
                return true
            end)}))
          return { message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet }
        end
      elseif context.discard and SMODS.has_enhancement(context.other_card, 'm_poke_hazard') and not context.blueprint then
          card.ability.extra.discards_remaining = card.ability.extra.discards_remaining - 1
          card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
          return {
            message = localize('k_upgrade_ex'),
            colour = G.C.MULT
          }
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and card.ability.extra.mult > 0 then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult 
        }
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    poke_change_hazard_level(card.ability.extra.hazard_level)
  end,
  remove_from_deck = function(self, card, from_debuff)
    poke_change_hazard_level(-card.ability.extra.hazard_level)
  end
}

return {
  name = "Gem's Baltoy",
  enabled = Gem_config.Baltoy or false,
  list = {baltoy, claydol}
}

