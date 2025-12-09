function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Indeedee M
local indeedee_m={
  name = "indeedee_m", 
  
  pos = {x = 12, y = 8}, 
  config = {extra = {Xmult = 1, Xmult_mod = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local card = center
    local Xmult = 1 + (card.ability.extra.Xmult_mod * (find_other_poke_or_energy_type(card, "Psychic", true)))
    return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod, Xmult}}
  end,
  rarity = 3,
  cost = 8,
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
        local Xmult = 1 + (card.ability.extra.Xmult_mod * (find_other_poke_or_energy_type(card, "Psychic", true)))
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
  name = "Gem's Indeedee_M",
  enabled = Gem_config.Indeedee_M or false,
  list = { indeedee_m }
}





