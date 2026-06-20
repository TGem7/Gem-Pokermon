-- Indeedee M
local indeedee_m={
  name = "indeedee_m", 
  
  pos = {x = 12, y = 8}, 
  config = {extra = {Xmult = 1, Xmult_mod = .5}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    local card = center
    local Xmult = 1 + (card.ability.extra.Xmult_mod * (#pokermon.find_pokemon_type("Psychic") + (#SMODS.find_card('c_poke_psychic_energy'))))
    return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod, Xmult}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local Xmult = 1 + (card.ability.extra.Xmult_mod * (#pokermon.find_pokemon_type("Psychic") + (#SMODS.find_card('c_poke_psychic_energy'))))
        return {
          message = localize('poke_expanding_force_ex'), 
          colour = G.C.MULT,
          Xmult_mod = Xmult,
        }
      end
    end
  end
}

return {
  config_key = "Indeedee_M",
  list = { indeedee_m }
}

