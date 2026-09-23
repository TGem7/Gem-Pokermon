-- Vullaby 629
local vullaby={
  name = "vullaby",
  pos = PokemonSprites["vullaby"].base.pos,
  config = { extra = { money_mod = 1, money_mod2 = 2, rounds = 4} },
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return { vars = { center.ability.extra.money_mod, center.ability.extra.money_mod2, center.ability.extra.rounds } }
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
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
            local earned = pokermon.ease_poke_dollars(card, "vullaby", card.ability.extra.money_mod)
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
    if context.remove_playing_cards and not context.blueprint then
      for _, removed_card in ipairs(context.removed) do
            local earned = pokermon.ease_poke_dollars(card, "vullaby", card.ability.extra.money_mod2)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + earned
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.dollar_buffer = 0
                    return true
                end
            }))
      end
    end
    return pokermon.level_evo(self, card, context, "j_Gem_mandibuzz")
  end
}

-- Mandibuzz 630
local mandibuzz={
  name = "mandibuzz",
  pos = PokemonSprites["mandibuzz"].base.pos,
  config = { extra = { money_mod = 1, money_mod2 = 2, d_size = 1} },
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return { vars = { center.ability.extra.money_mod, center.ability.extra.money_mod2, center.ability.extra.d_size } }
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
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
            local earned = pokermon.ease_poke_dollars(card, "vullaby", card.ability.extra.money_mod)
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
    if context.remove_playing_cards and not context.blueprint then
      for _, removed_card in ipairs(context.removed) do
            local earned = pokermon.ease_poke_dollars(card, "vullaby", card.ability.extra.money_mod2)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + earned
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.dollar_buffer = 0
                    return true
                end
            }))
      end
    end
    return pokermon.level_evo(self, card, context, "j_Gem_mandibuzz")
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
    ease_discard(card.ability.extra.d_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    ease_discard(-card.ability.extra.d_size)
  end,
}


return {
  config_key = "Vullaby",
  list = { vullaby, mandibuzz },
}

