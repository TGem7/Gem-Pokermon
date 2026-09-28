--  Ducklett 580
local ducklett = {
  name = "ducklett",
  pos = PokemonSprites["ducklett"].base.pos,
  config = {extra = {chips = 15, rounds = 4}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.chips, center.ability.extra.rounds}}
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Water",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play
        and context.other_card == context.scoring_hand[#context.scoring_hand] then
          context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
          context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chips
          return {
              extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
              colour = G.C.CHIPS,
              card = card
          }
    end
    return pokermon.level_evo(self, card, context, "j_Gem_swanna")
  end,
}

--  Swanna 581
local swanna = {
  name = "swanna",
  pos = PokemonSprites["swanna"].base.pos,
  config = {extra = {chips = 10, retriggers = 1}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.chips}}
  end,
  rarity = 2,
  cost = 6,
  stage = "One",
  ptype = "Water",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play
        and context.other_card == context.scoring_hand[#context.scoring_hand] then
          context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
          context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chips
          return {
              extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
              colour = G.C.CHIPS,
              card = card
          }
    end
    if context.repetition and context.cardarea == G.play
        and context.other_card == context.scoring_hand[#context.scoring_hand] then
        return {
              message = localize('k_again_ex'),
              repetitions = card.ability.extra.retriggers,
              card = card
          }
    end
    return pokermon.level_evo(self, card, context, "j_Gem_Swanna")
  end,
}

return {
  config_key = "Ducklett",
  list = {ducklett, swanna}
}


