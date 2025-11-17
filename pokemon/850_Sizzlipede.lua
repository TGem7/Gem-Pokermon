function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end


-- Sizzlipede 850
local sizzlipede = {
  name = "sizzlipede",
  pos = PokemonSprites["sizzlipede"].base.pos,
  config = { extra = { mult = 0, mult_mod = 1 }, evo_rqmt = 10 },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}}
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Fire",
  atlas = "AtlasJokersBasicNatdex",
  gen = 8,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.before and not context.blueprint and #context.scoring_hand == 5 then
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT
        }
      end
      if context.joker_main then
        if card.ability.extra.mult > 0 then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
            colour = G.C.MULT,
            mult_mod = card.ability.extra.mult
          }
        end
      end
    end
    return scaling_evo(self, card, context, "j_Gem_centiskorch", card.ability.extra.mult, self.config.evo_rqmt)
  end,
}

-- Centiskorch 850
local centiskorch = {
  name = "centiskorch",
  pos = PokemonSprites["centiskorch"].base.pos,
  config = { extra = { mult = 0, mult_mod = 2 } },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}}
  end,
  rarity = 2,
  cost = 6,
  stage = "One",
  ptype = "Fire",
  atlas = "AtlasJokersBasicNatdex",
  gen = 8,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.before and not context.blueprint and #context.scoring_hand == 5 then
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT
        }
      end
      if context.joker_main then
        if card.ability.extra.mult > 0 then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
            colour = G.C.MULT,
            mult_mod = card.ability.extra.mult
          }
        end
      end
    end
  end,
}

return {
  name = "Gem's sizzlipede",
  enabled = Gem_config.Sizzlipede or false,
  list = {sizzlipede, centiskorch}
}







