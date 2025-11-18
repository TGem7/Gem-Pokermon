function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end


-- Wailmer 320
local wailmer = {
  name = "wailmer",
  pos = PokemonSprites["wailmer"].base.pos,
  config = { extra = { chips = 80, rounds = 4 } },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.chips, center.ability.extra.rounds}}
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Water",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and not context.blueprint and #context.scoring_hand == 5 then
        return {
          message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}, 
          colour = G.C.CHIPS,
          chip_mod = card.ability.extra.chips,
          level_evo(self, card, context, "j_Gem_wailord")
        }
      end
    end
    return level_evo(self, card, context, "j_Gem_wailord")
  end,
}

-- Wailord 320
local wailord = {
  name = "wailord",
  pos = {x = 10, y = 21},
  config = { extra = { chips = 120, chip_mod = 10 } },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.chips, center.ability.extra.chips_mod}}
  end,
  rarity = 2,
  cost = 6,
  stage = "One",
  ptype = "Water",
  atlas = "AtlasJokersSeriesANatdex",
  gen = 3,
  custom_art = true,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and not context.blueprint and #context.scoring_hand == 5 then
        return {
          message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}, 
          colour = G.C.CHIPS,
          chip_mod = card.ability.extra.chips
        }
      end
    end
    if context.individual and context.cardarea == G.play and not context.end_of_round then
      local total_chips = poke_total_chips(context.other_card)
      if total_chips >= 30 then
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
      end
    end
  end,
}

return {
  name = "Gem's wailmer",
  enabled = Gem_config.Wailmer or false,
  list = {wailmer, wailord}
}







