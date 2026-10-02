-- Fomantis 753
local fomantis={
  name = "fomantis", 
  pos = PokemonSprites["fomantis"].base.pos,
  config = {extra = {mult = 3, destroyed = 0, suit = "Hearts"}, evo_rqmt = 3},
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.mult, localize(center.ability.extra.suit, 'suits_singular'),
     math.max(0, center.ability.extra.mult + center.ability.extra.mult * center.ability.extra.destroyed), math.max(0, self.config.evo_rqmt - center.ability.extra.destroyed)}}
  end,
  rarity = 3, 
  cost = 6, 
  stage = "Basic",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  gen = 7,
  perishable_compat = false,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.ending_shop then
      card.ability.extra.selected = false
      local eval = function() return not card.ability.extra.selected end
      juice_card_until(card, eval, true)
    end
    if context.setting_blind and not context.blueprint then
      card.ability.extra.selected = true
      local my_pos = nil
        for i = 1, #G.jokers.cards do
          if G.jokers.cards[i] == card then my_pos = i; break end
        end
      local sliced_card = G.jokers.cards[my_pos + 1]
      if pokermon.is_type(sliced_card, "Grass") and not card.getting_sliced then
        

        if my_pos and G.jokers.cards[my_pos+1] and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced then
          sliced_card.getting_sliced = true

        G.GAME.joker_buffer = G.GAME.joker_buffer - 1
        G.E_MANAGER:add_event(Event({
          func = function()
            G.GAME.joker_buffer = 0
            card.ability.extra.destroyed = card.ability.extra.destroyed + 1
            card:juice_up(0.8, 0.8)
            sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
            play_sound('slice1', 0.96 + math.random() * 0.08)
            return true
          end
        }))

        return {
          message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
          colour = G.C.RED,
          no_juice = true
        }
        end
      end
    end
    if context.individual and context.cardarea == G.hand and context.other_card:is_suit(card.ability.extra.suit) and not context.end_of_round then
      if context.other_card.debuff then
          return {
              message = localize('k_debuffed'),
              colour = G.C.RED,
              card = card,
          }
      else
          return {
              mult = card.ability.extra.mult + (card.ability.extra.mult * card.ability.extra.destroyed),
              card = card
          }
      end
    end
  if card.ability.extra.destroyed >= self.config.evo_rqmt then
    return pokermon.scaling_evo(self, card, context, "j_Gem_lurantis", card.ability.extra.destroyed, self.config.evo_rqmt)
  end
end,
  attributes = {"destroy_card", "mult", "editions", "scaling"},
}

-- Lurantis 754
local lurantis={
  name = "lurantis", 
  pos = PokemonSprites["lurantis"].base.pos,
  config = {extra = {Xmult_multi = 0.05, destroyed = 3, suit = "Hearts"}},
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult_multi, localize(center.ability.extra.suit, 'suits_singular'),
     math.max(0, 1 + center.ability.extra.Xmult_multi * center.ability.extra.destroyed)}}
  end,
  rarity = "poke_safari", 
  cost = 10, 
  stage = "One",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  gen = 7,
  perishable_compat = false,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.ending_shop then
      card.ability.extra.selected = false
      local eval = function() return not card.ability.extra.selected end
      juice_card_until(card, eval, true)
    end
    if context.setting_blind and not context.blueprint then
      card.ability.extra.selected = true
      local my_pos = nil
        for i = 1, #G.jokers.cards do
          if G.jokers.cards[i] == card then my_pos = i; break end
        end
      local sliced_card = G.jokers.cards[my_pos + 1]
      if pokermon.is_type(sliced_card, "Grass") and not card.getting_sliced then
        

        if my_pos and G.jokers.cards[my_pos+1] and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced then
          sliced_card.getting_sliced = true

        G.GAME.joker_buffer = G.GAME.joker_buffer - 1
        G.E_MANAGER:add_event(Event({
          func = function()
            G.GAME.joker_buffer = 0
            card.ability.extra.destroyed = card.ability.extra.destroyed + 1
            card:juice_up(0.8, 0.8)
            sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
            play_sound('slice1', 0.96 + math.random() * 0.08)
            return true
          end
        }))

        return {
          message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.Xmult_multi } },
          colour = G.C.RED,
          no_juice = true
        }
        end
      end
    end
    if context.individual and context.cardarea == G.hand and context.other_card:is_suit(card.ability.extra.suit) and not context.end_of_round then
      if context.other_card.debuff then
          return {
              message = localize('k_debuffed'),
              colour = G.C.RED,
              card = card,
          }
      else
          return {
              x_mult = 1 + card.ability.extra.Xmult_multi * card.ability.extra.destroyed,
              card = card
          }
      end
    end
  end,
  attributes = {"destroy_card", "mult", "editions", "scaling"},
}


return {
  config_key = "Fomantis",
  list = {fomantis, lurantis}
}