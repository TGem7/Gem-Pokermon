-- Basculin 550
local basculin={
  name = "basculin",
  
  pos = {x = 4, y = 0},
  config = { extra = { mult = 0, mult_mod = 8, rounds = 5, count = 0}, evo_rqmt = 40 },
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return { vars = { center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.rounds, center.ability.extra.count } }
  end,
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Water",
  atlas = "AtlasJokersBasicGen05",
  gen = 5,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
    if context.hand_drawn and SMODS.drawn_cards then 
     if G.deck and G.deck.cards then
			for i, drawnCard in ipairs(SMODS.drawn_cards) do 
        local findFunc = function(v) return drawnCard:get_id() == v:get_id() end
				if not SMODS.has_no_rank(drawnCard) and not next(pokermon.find_playing_card(findFunc)) then 
            if not context.blueprint then
              SMODS.scale_card(card, {
                ref_value = 'mult',
                scalar_value = 'mult_mod',
                message_colour = G.C.MULT,
              })
            end
        end
			end
     end
   end
   if card.ability.extra.mult >= 40 then
    card.ability.extra.count = 40
   end
	 if context.joker_main and card.ability.extra.mult > 0 then
		return {
			mult = card.ability.extra.mult
		}
	 end
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      card.ability.extra.mult = 0
      return {
        message = localize('k_reset'),
        colour = G.C.CHIPS
      }
    end
    if card.ability.extra.count >= self.config.evo_rqmt then
        return pokermon.scaling_evo(self, card, context, "j_Gem_basculegion", card.ability.extra.count, self.config.evo_rqmt)
    else
        return pokermon.level_evo(self, card, context, "j_Gem_basculegion_f")
    end
    end,
  attributes = {"reset"},
}

-- Basculegion 550
local basculegion={
  name = "basculegion",
  pos = {x = 2, y = 11},
  config = { extra = { Xmult = 1, Xmult_mod = 0.5 } },
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return { vars = { center.ability.extra.Xmult, center.ability.extra.Xmult_mod } }
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
    if context.hand_drawn and SMODS.drawn_cards then 
     if G.deck and G.deck.cards then
			for i, drawnCard in ipairs(SMODS.drawn_cards) do 
        local findFunc = function(v) return drawnCard:get_id() == v:get_id() end
				if not SMODS.has_no_rank(drawnCard) and not next(pokermon.find_playing_card(findFunc)) then 
            if not context.blueprint then
              SMODS.scale_card(card, {
                ref_value = 'Xmult',
                scalar_value = 'Xmult_mod',
                message_colour = G.C.MULT,
              })
            end
        end
			end
     end
   end
	 if context.joker_main and card.ability.extra.Xmult > 0 then
		return {
			Xmult_mod = card.ability.extra.Xmult
		}
	 end
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      card.ability.extra.Xmult = 1
      return {
        message = localize('k_reset'),
        colour = G.C.CHIPS
      }
    end
    end,
  attributes = {"reset"},
}

-- Basculegion-F 550
local basculegion_f={
  name = "basculegion_f",
  
  pos = {x = 4, y = 11},
  config = { extra = { mult = 0, mult_mod = 10, money_mod = 1} },
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return { vars = { center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.money_mod } }
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
    if context.hand_drawn and SMODS.drawn_cards then 
     if G.deck and G.deck.cards then
			for i, drawnCard in ipairs(SMODS.drawn_cards) do 
        local findFunc = function(v) return drawnCard:get_id() == v:get_id() end
				if not SMODS.has_no_rank(drawnCard) and not next(pokermon.find_playing_card(findFunc)) then 
            if not context.blueprint then
              SMODS.scale_card(card, {
                ref_value = 'mult',
                scalar_value = 'mult_mod',
                message_colour = G.C.MULT,
              })
            end
            local earned = pokermon.ease_poke_dollars(card, "basculegion_f", card.ability.extra.money_mod)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + earned
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.dollar_buffer = 0
                    return true
                end
            }))
        end
			end
     end
   end
	 if context.joker_main and card.ability.extra.mult > 0 then
		return {
			mult = card.ability.extra.mult
		}
	 end
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      card.ability.extra.mult = 0
      return {
        message = localize('k_reset'),
        colour = G.C.CHIPS
      }
    end
    end,
  attributes = {"reset"},
}

return {
  config_key = "Basculin",
  list = { basculin, basculegion, basculegion_f },
}

