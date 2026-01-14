function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Espurrr 677
local espurr={
  name = "espurr",
  pos = PokemonSprites["espurr"].base.pos,
  config = {extra = {scry = 2, mult = 2, money_threshold = 25, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'scry_cards'}
    return {vars = {card.ability.extra.scry, card.ability.extra.mult, card.ability.extra.rounds, card.ability.extra.money_threshold}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  gen = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if not context.end_of_round and context.scoring_hand then
      if context.individual and context.cardarea == G.scry_view and not context.other_card.debuff then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}},
          message_card = context.other_card,
          mult_mod = card.ability.extra.mult,
          card = card,
        }
      end
    end
    if context.end_of_round then
      local dollars = G.GAME.dollars
      if (SMODS.Mods["Talisman"] or {}).can_load then
        dollars = to_number(dollars)
      end
      if dollars > card.ability.extra.money_threshold then
      return level_evo(self, card, context, "j_Gem_meowstic_f")
      end
    end
    return level_evo(self, card, context, "j_Gem_meowstic")
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = (G.GAME.scry_amount or 0) + card.ability.extra.scry
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = math.max(0,(G.GAME.scry_amount or 0) - card.ability.extra.scry)
  end,
}

-- Meowstic 678
local meowstic={
  name = "meowstic",
  pos = {x = 2, y = 8},
  config = {extra = { scry = 4, mult = 3, money_mod = 1, earned = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'scry_cards'}
		return {vars = {card.ability.extra.scry, card.ability.extra.mult, card.ability.extra.money_mod, card.ability.extra.earned}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen06",
  gen = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if not context.end_of_round and context.scoring_hand then
      if context.individual and context.cardarea == G.scry_view and not context.other_card.debuff then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}},
          message_card = context.other_card,
          mult_mod = card.ability.extra.mult,
          card = card,
        }
      end
    end
    if context.end_of_round then
      if context.individual and context.cardarea == G.scry_view and not context.other_card.debuff then
        if context.other_card.debuff then
          return {
            message = localize("k_debuffed"),
            colour = G.C.RED,
            card = card,
          }
        else
          local earned = 0
          if not context.blueprint then
            card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money_mod
          end
          
          earned = earned + card.ability.extra.money_mod
          earned = ease_poke_dollars(card, "hands", earned)
          return {
              message = localize('$')..earned,
              colour = G.C.MONEY,
              card = card
          }
        end
      end
    end
  end,
   megas = { "mega_meowstic" },
  add_to_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = (G.GAME.scry_amount or 0) + card.ability.extra.scry
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = math.max(0,(G.GAME.scry_amount or 0) - card.ability.extra.scry)
  end,
}

-- Meowstic-F 678-A
local meowstic_f={
  name = "meowstic_f",
  pos = {x = 4, y = 8},
  config = {extra = {scry = 4, Xmult_multi = 1.25}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'scry_cards'}
		return {vars = {card.ability.extra.scry, card.ability.extra.Xmult_multi}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen06",
  no_collection = true,
  gen = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if not context.end_of_round and context.scoring_hand then
      if context.individual and context.cardarea == G.scry_view and not context.other_card.debuff then
        return {
          xmult = card.ability.extra.Xmult_multi,
          card = card,
        }
      end
    end
  end,
   megas = { "mega_meowstic" },
  add_to_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = (G.GAME.scry_amount or 0) + card.ability.extra.scry
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = math.max(0,(G.GAME.scry_amount or 0) - card.ability.extra.scry)
  end,
}

-- Mega Meowstic 
local mega_meowstic={
  name = "mega_meowstic",
  pos = {x = 2, y = 8},
  config = {extra = { scry = 6, Xmult_multi = 1.3, money_mod = 1, earned = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'scry_cards'}
		return {vars = {card.ability.extra.scry, card.ability.extra.Xmult_multi, card.ability.extra.money_mod, card.ability.extra.earned}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen06",
  gen = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if not context.end_of_round and context.scoring_hand then
      if context.individual and context.cardarea == G.scry_view and not context.other_card.debuff then
        return {
          xmult = card.ability.extra.Xmult_multi,
          card = card,
        }
      end
    end
    if context.end_of_round then
      if context.individual and context.cardarea == G.scry_view and not context.other_card.debuff then
        if context.other_card.debuff then
          return {
            message = localize("k_debuffed"),
            colour = G.C.RED,
            card = card,
          }
        else
          local earned = 0
          if not context.blueprint then
            card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money_mod
          end
          
          earned = earned + card.ability.extra.money_mod
          earned = ease_poke_dollars(card, "hands", earned)
          return {
              message = localize('$')..earned,
              colour = G.C.MONEY,
              card = card
          }
        end
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = (G.GAME.scry_amount or 0) + card.ability.extra.scry
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = math.max(0,(G.GAME.scry_amount or 0) - card.ability.extra.scry)
  end,
}


return {
  name = "Gem's Espurr",
  enabled = Gem_config.Espurr or false,
  list = {espurr, meowstic, meowstic_f, mega_meowstic}
}

