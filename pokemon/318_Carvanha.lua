function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Carvanha 318
local carvanha={
  name = "carvanha",
  
  pos = PokemonSprites["carvanha"].base.pos,
  config = { extra = { Xmult = 2, rounds = 4 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult, card.ability.extra.rounds } }
  end,
  designer = "James Peach III",
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Water",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
        return level_evo(self, card, context, "j_Gem_sharpedo")
    end,
}

-- Sharpedo 318
local sharpedo={
  name = "sharpedo",
  
  pos = PokemonSprites["sharpedo"].base.pos,
  config = { extra = { Xmult = 2, Xmult_mod = 1, Xmult2 = 2 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'mega_poke'}
    return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_mod, card.ability.extra.Xmult2 } }
  end,
  designer = "James Peach III",
  rarity = 3,
  cost = 8,
  stage = "One",
  ptype = "Water",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
      if context.joker_main and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
          return {
              xmult = card.ability.extra.Xmult
          }
      end
      if context.after and not context.blueprint then
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT
        }
      end
    if not context.repetition and not context.individual and context.end_of_round and not context.blueprint then
      card.ability.extra.Xmult = card.ability.extra.Xmult2
      return {
        message = localize('k_reset'),
        colour = G.C.RED
      }
    end
  end,
   megas = { "mega_sharpedo" },
}

-- Mega Sharpedo 319
local mega_sharpedo={
  name = "mega_sharpedo",
  
  pos = {x = 10, y = 5},
  soul_pos = {x = 11, y = 5},
  config = { extra = { Xmult = 2 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult } }
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Water",
  atlas = "AtlasJokersBasicGen03",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end,
}

return {
  name = "Gem's Carvanha",
  enabled = Gem_config.Carvanha or false,
  list = { carvanha, sharpedo, mega_sharpedo}
}
