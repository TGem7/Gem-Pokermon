-- Rufflet 672
local rufflet={
  name = "rufflet",
  pos = PokemonSprites["rufflet"].base.pos,
  config = {extra = {mult = 2, rounds = 4, suit = "Spades", drawn = 0}, evo_rqmt = 25},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult, center.ability.extra.rounds, localize(center.ability.extra.suit, 'suits_singular'),
    math.max(0, self.config.evo_rqmt - center.ability.extra.drawn)}}
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Colorless",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand and context.other_card:is_suit(card.ability.extra.suit) and not context.end_of_round then
      if context.other_card.debuff then
          return {
              message = localize('k_debuffed'),
              colour = G.C.RED,
              card = card,
          }
      else
          return {
              mult = card.ability.extra.mult,
              card = card
          }
      end
    end
  if context.hand_drawn and SMODS.drawn_cards then
    for i, drawnCard in ipairs(SMODS.drawn_cards) do
      if drawnCard:is_suit(card.ability.extra.suit) then
        if not context.blueprint then
          card.ability.extra.drawn = card.ability.extra.drawn + 1
        end
      end
    end
  end
  if card.ability.extra.drawn >= self.config.evo_rqmt then
    return pokermon.scaling_evo(self, card, context, "j_Gem_hisuian_braviary", card.ability.extra.drawn, self.config.evo_rqmt)
  else
   return pokermon.level_evo(self, card, context, "j_Gem_braviary")
  end
  end,
   
  attributes = {"suit", "spades", "mult", "round_evo"},
}

-- Braviary 673
local braviary={
  name = "braviary",
  pos = PokemonSprites["braviary"].base.pos,
  config = {extra = {Xmult_multi = 1.25, suit = "Spades"}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult_multi, localize(center.ability.extra.suit, 'suits_singular')}}
  end,
  rarity = "poke_safari",
  cost = 6,
  stage = "One",
  ptype = "Colorless",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand and context.other_card:is_suit(card.ability.extra.suit) and not context.end_of_round then
      if context.other_card.debuff then
          return {
              message = localize('k_debuffed'),
              colour = G.C.RED,
              card = card,
          }
      else
          return {
              x_mult = card.ability.extra.Xmult_multi,
              card = card
          }
      end
    end
  end,
  attributes = {"suit", "spades", "xmult"},
}

-- Hisuian Braviary 673
local hisuian_braviary={
  name = "hisuian_braviary",
  pos = {x = 4, y = 9},
  config = {extra = {scry = 4, Xmult_multi = 1.35, suit = "Spades"}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = { center.ability.extra.scry, center.ability.extra.Xmult_multi, localize(center.ability.extra.suit, 'suits_singular')}}
  end,
  rarity = "poke_safari",
  cost = 6,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen05",
  gen = 5,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if not context.end_of_round and context.scoring_hand then
      if context.individual and context.cardarea == G.poke_scry_view and context.other_card:is_suit(card.ability.extra.suit) and not context.other_card.debuff then
        return { xmult = card.ability.extra.Xmult_multi, card = context.other_card }
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = (G.GAME.poke_scry_amount or 0) + card.ability.extra.scry
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = math.max(0,(G.GAME.poke_scry_amount or 0) - card.ability.extra.scry)
  end,
  attributes = {"suit", "spades", "xmult"},
}

return {
  config_key = 'Rufflet',
  list = { rufflet, braviary, hisuian_braviary },
}


