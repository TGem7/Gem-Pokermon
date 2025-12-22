
-- Hisuian Qwilfish 211-1
local hisuian_qwilfish={
  name = "hisuian_qwilfish",
  pos = {x = 2, y = 5},
  config = {extra = {chips = 0, chip_mod = 10}, evo_rqmt = 120},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
    return {vars = {card.ability.extra.chips, card.ability.extra.chip_mod}}
  end,
  rarity = 3,
  cost = 8,
  stage = "Basic",
  ptype = "Dark",
  atlas = "AtlasJokersBasicGen02",
  gen = 2,
  toxic = true,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn and not context.blueprint then
      local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

  -- If scored card is toxic, gain chips
      if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_stall_toxic') and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
      end
  -- Return the chips
      if context.joker_main then
          return {
              chips = card.ability.extra.chips
          }
      end
      -- If first hand of round, turn one card held in hand to toxic
      if context.individual and context.cardarea == G.play and not card.ability.extra.triggered and not context.blueprint then
        if G.GAME.current_round.hands_played == 0 then
          card.ability.extra.triggered = true
      local cards_held = {}
      for k, v in ipairs(G.hand.cards) do
          table.insert(cards_held, v)
      end
          pseudoshuffle(cards_held, pseudoseed('blacksludge'))
          local limit = math.min(#cards_held, 1)
          for i = 1, limit do
            poke_convert_cards_to(cards_held[i], {mod_conv = 'm_stall_toxic'}, true, true)
            cards_held[i]:juice_up()
            toxic_scaling()
            SMODS.calculate_effect({x_mult = G.GAME.current_round.toxic.toxicXMult}, cards_held[i])
            cards_held[i]:juice_up()
          end
        end
      end
    if context.joker_main then card.ability.extra.triggered = false end
    return scaling_evo(self, card, context, "j_Gem_overqwil", card.ability.extra.chips, self.config.evo_rqmt)
  end,
}

-- Overqwil 903
local overqwil={
  name = "overqwil",
  pos = PokemonSprites["overqwil"].base.pos,
  config = {extra = {chips = 120, chip_mod = 10}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
    return {vars = {card.ability.extra.chips, card.ability.extra.chip_mod}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "One",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
  gen = 8,
  toxic = true,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn and not context.blueprint then
      local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end
  -- If scored card is toxic, gain chips. If scored hand is 5 toxic cards, double chip gain
      if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_stall_toxic') and not context.blueprint then
        local all_toxic = true
        for k, v in pairs(context.full_hand) do
          if not SMODS.has_enhancement(v, "m_poke_hazard") then
            all_toxic = false
          end
        end
        if all_toxic then
            card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chip_mod * 2)
              return {
                  message = localize('k_upgrade_ex'),
                  colour = G.C.CHIPS,
                  message_card = card
              }
        else
            card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chip_mod * 2)
              return {
                  message = localize('k_upgrade_ex'),
                  colour = G.C.CHIPS,
                  message_card = card
              }
        end
      end
  -- Return the chips
      if context.joker_main then
          return {
              chips = card.ability.extra.chips
          }
      end
      -- If first hand of round, turn two cards held in hand to toxic
      if context.individual and context.cardarea == G.play and not card.ability.extra.triggered and not context.blueprint then
        if G.GAME.current_round.hands_played == 0 then
          card.ability.extra.triggered = true
      local cards_held = {}
      for k, v in ipairs(G.hand.cards) do
          table.insert(cards_held, v)
      end
          pseudoshuffle(cards_held, pseudoseed('blacksludge'))
          local limit = math.min(#cards_held, 2)
          for i = 1, limit do
            poke_convert_cards_to(cards_held[i], {mod_conv = 'm_stall_toxic'}, true, true)
            cards_held[i]:juice_up()
            toxic_scaling()
            SMODS.calculate_effect({x_mult = G.GAME.current_round.toxic.toxicXMult}, cards_held[i])
            cards_held[i]:juice_up()
          end
        end
      end
    if context.joker_main then card.ability.extra.triggered = false end
  end
}

return {
  name = "Gem's Hisuian Qwilfish",
  enabled = (SMODS.Mods["ToxicStall"] or {}).can_load or false,
  list = {hisuian_qwilfish, overqwil}
}
