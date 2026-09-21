-- Alolan Geodude 074
local alolan_geodude = { 
  name = "alolan_geodude",
  pos = {x = 8, y = 3},
  config = {extra = {money_mod = 1,  earned = 0, h_size = 1, rounds = 4}},
  loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.money_mod,
                    center.ability.extra.h_size, center.ability.extra.rounds}}
  end,
  rarity = 1, 
  cost = 4, 
  stage = "Basic",
  ptype = "Lightning",
  atlas = "AtlasJokersBasicGen01",
  gen = 1,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand and not context.end_of_round and G.GAME.current_round.hands_played == 0 then
      if context.other_card.debuff then
        return {
          message = localize("k_debuffed"),
          colour = G.C.RED,
        }
      else
        if not context.blueprint then
          card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money_mod
        end

        local earned = pokermon.ease_poke_dollars(card, "dude", card.ability.extra.money_mod, true)
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + earned
        return {
          dollars = earned,
          func = function()
            G.E_MANAGER:add_event(Event({
              func = function()
                G.GAME.dollar_buffer = 0
                return true
              end
            }))
          end
        }
      end
    end
      return pokermon.level_evo(self, card, context, "j_Gem_alolan_graveler")
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  attributes = {"hand_size", "passive", "economy"},
}

-- Alolan Graveler 075
local alolan_graveler = { 
  name = "alolan_graveler",
  pos = {x = 10, y = 3},
  config = {extra = {money_mod = 1,  earned = 0, h_size = 2}},
  loc_vars = function(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.c_poke_thunderstone
    end
    return {vars = {center.ability.extra.money_mod,
                    center.ability.extra.h_size}}
  end,
  rarity = "poke_safari", 
  cost = 6, 
  item_req = "thunderstone",
  stage = "One",
  ptype = "Lightning",
  atlas = "AtlasJokersBasicGen01",
  gen = 1,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand and not context.end_of_round then
      if context.other_card.debuff then
        return {
          message = localize("k_debuffed"),
          colour = G.C.RED,
        }
      else
        if not context.blueprint then
          card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money_mod
        end

        local earned = pokermon.ease_poke_dollars(card, "dude", card.ability.extra.money_mod, true)
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + earned
        return {
          dollars = earned,
          func = function()
            G.E_MANAGER:add_event(Event({
              func = function()
                G.GAME.dollar_buffer = 0
                return true
              end
            }))
          end
        }
      end
    end
    return pokermon.item_evo(self, card, context, "j_Gem_alolan_golem")
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  attributes = {"hand_size", "passive", "economy"},
}

-- Alolan Golem 076
local alolan_golem = { 
  name = "alolan_golem",
  pos = {x = 12, y = 3},
  config = {extra = {money_mod = 2,  earned = 0, h_size = 3}},
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.money_mod,
                    center.ability.extra.h_size}}
  end,
  rarity = "poke_safari", 
  cost = 8, 
  stage = "Two",
  ptype = "Lightning",
  atlas = "AtlasJokersBasicGen01",
  gen = 1,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.check_enhancement then
      if context.other_card.config.center.key == "c_base" then
        return {m_gold = true}
      end
    end
    if context.individual and context.cardarea == G.hand and not context.end_of_round then
      if context.other_card.debuff then
        return {
          message = localize("k_debuffed"),
          colour = G.C.RED,
        }
      else
        if not context.blueprint then
          card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money_mod
        end

        local earned = pokermon.ease_poke_dollars(card, "dude", card.ability.extra.money_mod, true)
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + earned
        return {
          dollars = earned,
          func = function()
            G.E_MANAGER:add_event(Event({
              func = function()
                G.GAME.dollar_buffer = 0
                return true
              end
            }))
          end
        }
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  attributes = {"hand_size", "passive", "economy"},
}

return {
  config_key = 'A_Geodude',
  list = {alolan_geodude, alolan_graveler, alolan_golem}
}



