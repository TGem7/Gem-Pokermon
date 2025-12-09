function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Kubfu 891
local kubfu={
  name = "kubfu", 
  pos = {x = 10, y = 59}, 
  soul_pos = {x = 11, y = 59}, 
  config = {extra = {mult = 0, mult_mod = 10, mult_original = 0, hands_needed = 8, hands_needed_original = 8, discards_needed = 8, discards_needed_original = 8}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.mult_original, center.ability.extra.hands_needed, center.ability.extra.hands_needed_original, center.ability.extra.discards_needed, center.ability.extra.discards_needed_original}}
  end,
  rarity = 4, 
  cost = 15, 
  stage = "Legendary",
  ptype = "Fighting",
  atlas = "AtlasJokersBasicNatdex",
  gen = 8,
  perishable_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
  -- Count played hands
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.before and not context.blueprint then
        if card.ability.extra.hands_needed > 0 then
            card.ability.extra.hands_needed = card.ability.extra.hands_needed - 1
        end
      end
    end
  -- Count used discards
    if context.pre_discard and not context.blueprint then
      if card.ability.extra.discards_needed > 0 then
          card.ability.extra.discards_needed = card.ability.extra.discards_needed - 1
      end
    end
  -- +10 mult whenever a discard is used
    if context.pre_discard and not context.blueprint then
      card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.RED,
          delay = 0.45, 
          card = card
        }
    end
  -- +10 mult whenever a hand is played
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.before and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
              message = localize('k_upgrade_ex'),
              colour = G.C.MULT
            }
      elseif context.joker_main then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
            colour = G.C.MULT,
            mult_mod = card.ability.extra.mult
          }
      end
    end
  -- Reset mult
    if not context.repetition and not context.individual and context.end_of_round and not context.blueprint then
      card.ability.extra.mult = card.ability.extra.mult_original
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset'), colour = G.C.RED})
    end
  -- Give Negative Scroll of Waters if 8 hands have been played(currently water stone for simplicity)
    if context.end_of_round and not context.individual and not context.repetition and not card.debuff then
      if card.ability.extra.hands_needed <= 0 then
        local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_Gem_scrollofwaters')
        local edition = {negative = true}
        _card:set_edition(edition, true)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
      end
    end
  -- Give Negative Scroll of Darkness if 8 discards have been used(currently fire stone for simplicity)
    if context.end_of_round and not context.individual and not context.repetition and not card.debuff then
      if card.ability.extra.discards_needed <= 0 then
        local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_Gem_scrollofdarkness')
        local edition = {negative = true}
        _card:set_edition(edition, true)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
      end
    end
-- Reset hands played 
    if not context.repetition and not context.individual and context.end_of_round and not context.blueprint then
      if card.ability.extra.hands_needed <= 0 then
        card.ability.extra.hands_needed = card.ability.extra.hands_needed_original
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset'), colour = G.C.RED})
      end
    end
-- Reset discards used
    if not context.repetition and not context.individual and context.end_of_round and not context.blueprint then
      if card.ability.extra.discards_needed <= 0 then
        card.ability.extra.discards_needed = card.ability.extra.discards_needed_original
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset'), colour = G.C.RED})
      end
    end
  end,
}

--Urshifu Single Strike 892
local urshifu_single_strike={
  name = "urshifu_single_strike",
  pos = {x = 2, y = 10}, 
  soul_pos = {x = 3, y = 10}, 
  config = {extra = {Xmult = 1, Xmult_mod = .2, Xmult_original = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod, center.ability.extra.Xmult_original}}
  end,
  rarity = 4, 
  cost = 20, 
  stage = "Legendary",
  aux_poke = true,
  ptype = "Dark",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  custom_pool_func = true,
  aux_poke = true,
  in_pool = function(self)
    return false
  end,
  perishable_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
  -- .15 Xmult whenever a card is discarded
    if context.discard and not context.blueprint then
      card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.RED,
          delay = 0.45, 
          card = card
        }
    end
 -- Setting to check for first hand of round
    if context.first_hand_drawn and not context.blueprint then
      local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end
-- Give Xmult, doubled on first hand of round
    if context.cardarea == G.jokers then
      if context.before and not context.blueprint and G.GAME.current_round.hands_played == 0 then
            Xmult = card.ability.extra.Xmult * 2
      elseif context.joker_main then
          return {
              Xmult = Xmult
          }
      end
    end
-- Undouble the Xmult
    if context.after and not context.blueprint and G.GAME.current_round.hands_played == 0 then
          Xmult = Xmult/2
    end

-- Reset xmult 
    if not context.repetition and not context.individual and context.end_of_round and not context.blueprint then
      card.ability.extra.Xmult = card.ability.extra.Xmult_original
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset'), colour = G.C.RED})
    end
  end,
}

--Urshifu Rapid Strike 892
local urshifu_rapid_strike={
  name = "urshifu_rapid_strike", 
  pos = {x = 4, y = 10}, 
  soul_pos = {x = 5, y = 10}, 
  config = {extra = {chips = 0, chip_mod = 20, chips_original = 0}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.chips, center.ability.extra.chip_mod, center.ability.extra.chips_original}}
  end,
  rarity = 4, 
  cost = 20, 
  stage = "Legendary",
  ptype = "Water",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  custom_pool_func = true,
  aux_poke = true,
  in_pool = function(self)
    return false
  end,
  perishable_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
  -- Count played hands
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.before and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
      end
    end

  -- If last hand of round, gain half of those chips instead
        if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff and G.GAME.current_round.hands_left == 0 then
          context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
          context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + (card.ability.extra.chips / 2)
          return {
              extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
              colour = G.C.CHIPS,
              card = card
          }
  -- Scored cards give chips per hand played
        elseif context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
          return {
            chips = card.ability.extra.chips,
            card = card
          }
        end

  -- Reset Chips
     if not context.repetition and not context.individual and context.end_of_round and not context.blueprint then
       card.ability.extra.chips = card.ability.extra.chips_original
       card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset'), colour = G.C.RED})
     end
  end,
}

return {
  name = "Gem's Kubfu",
  enabled = Gem_config.Kubfu or false,
  list = { kubfu, urshifu_single_strike, urshifu_rapid_strike }
}







