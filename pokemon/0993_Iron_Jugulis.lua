function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Iron Jugulis 993
local iron_jugulis={
  name = "iron_jugulis", 
  pos = {x = 4, y = 66}, 
  soul_pos = {x = 5, y = 66}, 
  config = {extra = {Xmult = 1, Xmult_mod = 0.5, destroyed_count = 5}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod, center.ability.extra.destroyed_count}}
  end,
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
      -- Destroy unscored cards in a 3oak
      if context.after and context.scoring_name == "Three of a Kind" and not context.blueprint then
        for k, v in pairs(context.full_hand) do
          if not SMODS.in_scoring(v, context.scoring_hand) then
            poke_remove_card(v, card)
          end
        end
      end
      -- Destroy unscored cards in first hand of round
      if context.after and not context.blueprint then
        if G.GAME.current_round.hands_played == 0 then
          for k, v in pairs(context.full_hand) do
            if not SMODS.in_scoring(v, context.scoring_hand) then
              poke_remove_card(v, card)
            end
          end
        end
      end
    end
    -- Count destroyed cards
    if context.remove_playing_cards and not context.blueprint then
      for _, removed_card in ipairs(context.removed) do
        card.ability.extra.destroyed_count = card.ability.extra.destroyed_count - 1
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
  name = "Gem's Iron Jugulis",
  enabled = Gem_config.Iron_Jugulis or false,
  list = { iron_jugulis }
}




