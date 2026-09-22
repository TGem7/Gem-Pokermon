-- Galarian Ponyta 077
local galarian_ponyta={
  name = "galarian_ponyta",
  pos = {x = 10, y = 4},
  config = {extra = {straights_played = 0}, evo_rqmt = 5},
  loc_vars = function(self, info_queue, center)
    local straights_remaining = math.max(0, self.config.evo_rqmt - center.ability.extra.straights_played)
    return {vars = {straights_remaining}}
  end,
  rarity = 2,
  cost = 5,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen01",
  gen = 1,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and next(context.poker_hands['Straight']) then
         card.ability.extra.straights_played = card.ability.extra.straights_played + 1
         if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          return {
            extra = {focus = card, message = localize('poke_plus_energy'), colour = pokermon.colours.pink, func = function()
              G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                  local card_type = 'poke_energy'
                  local _card = create_card(card_type, G.consumeables, nil, nil, nil, nil, nil, 'sup')
                  _card:add_to_deck()
                  G.consumeables:emplace(_card)
                  G.GAME.consumeable_buffer = 0
                  return true
                end
              }))
            end},
          }
        end
      end
    end
      return pokermon.scaling_evo(self, card, context, "j_Gem_galarian_rapidash", card.ability.extra.straights_played, self.config.evo_rqmt)
  end,
  attributes = {"hand_type", "round_evo", "energy", "generation"},
}

-- Galarian Rapidash 077
local galarian_rapidash={
  name = "galarian_rapidash",
  pos = {x = 12, y = 4},
  config = {extra = {straights_played = 0, rqmnt = 5, enrgy = 1}},
  loc_vars = function(self, info_queue, center)
    local straights_remaining = math.max(0, center.ability.extra.rqmnt - center.ability.extra.straights_played)
    return {vars = {straights_remaining, center.ability.extra.rqmnt, center.ability.extra.enrgy}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen01",
  gen = 1,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and next(context.poker_hands['Straight']) then
        card.ability.extra.straights_played = card.ability.extra.straights_played + 1
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          return {
            extra = {focus = card, message = localize('poke_plus_energy'), colour = pokermon.colours.pink, func = function()
              G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                  local card_type = 'poke_energy'
                  local _card = create_card(card_type, G.consumeables, nil, nil, nil, nil, nil, 'sup')
                  _card:add_to_deck()
                  G.consumeables:emplace(_card)
                  G.GAME.consumeable_buffer = 0
                  return true
                end
              }))
            end},
          }
        end
      end
        if card.ability.extra.straights_played >= card.ability.extra.rqmnt then
          card.ability.extra.straights_played = 0
          card.ability.extra.rqmnt = card.ability.extra.rqmnt + 1
          card.ability.extra.enrgy = card.ability.extra.enrgy + 1
          G.GAME.poke_energy_plus = G.GAME.poke_energy_plus + 1
        end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({
      func = (function()
       if not G.GAME.poke_energy_plus then
         G.GAME.poke_energy_plus = card.ability.extra.enrgy
       else
         G.GAME.poke_energy_plus = G.GAME.poke_energy_plus + card.ability.extra.enrgy
       end
        return true
      end)
    }))
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not G.GAME.poke_energy_plus then
      G.GAME.poke_energy_plus = 0
    else
      G.GAME.poke_energy_plus = G.GAME.poke_energy_plus - card.ability.extra.enrgy
    end
  end,
  attributes = {"hand_type", "round_evo", "energy", "generation"},
}


return {
  config_key = 'G_Ponyta',
  list = {galarian_ponyta, galarian_rapidash}
}



