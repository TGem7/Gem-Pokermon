

-- Iron Jugulis 993
local iron_jugulis={
  name = "iron_jugulis",
  pos = {x = 4, y = 66},
  soul_pos = {x = 5, y = 66},
  config = {extra = {Xmult = 1, Xmult_mod = 0.5, destroyed_count = 5}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod, center.ability.extra.destroyed_count}}
  end,
  designer = "Eternalnacho",
  rarity = "Gem_future_paradox",
  cost = 15,
  stage = "Paradox",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
  calculate = function(self, card, context)
  -- Detect first hand of round
    if context.first_hand_drawn and not context.blueprint then
      local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

  -- Return the xmult
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}, 
          colour = G.C.XMULT,
          Xmult_mod = card.ability.extra.Xmult
        }
      end
      if context.destroy_card and context.cardarea == 'unscored' and not context.blueprint then
        -- Destroy unscored cards in a 3oak or in first hand of round
        if context.scoring_name == "Three of a Kind" or G.GAME.current_round.hands_played == 0 then
          card.ability.extra.destroyed_count = card.ability.extra.destroyed_count - 1
          return { remove = true }
        end
      end
    end
    -- Scale xmult when 5 cards are destroyed
    if context.remove_playing_cards and not context.blueprint then
      for _, removed_card in ipairs(context.removed) do
        if card.ability.extra.destroyed_count <= 0 then
          card.ability.extra.destroyed_count = 5
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("k_upgrade_ex")})
        end
      end
    end
  end
}

return {
  config_key = "Iron_Jugulis",
  list = { iron_jugulis }
}




