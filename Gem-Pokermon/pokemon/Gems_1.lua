function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
-- Treecko 252
local treecko={
  name = "treecko",
  poke_custom_prefix = "Gem",
  pos = {x = 0, y = 0},
  config = {extra = {money_mod = 1, money_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, h_size = 1, odds = 2}, evo_rqmt = 16},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local money_left = math.max(0, self.config.evo_rqmt - card.ability.extra.money_earned)
    local card_vars = {card.ability.extra.money_mod, money_left, card.ability.extra.h_size, ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}
    add_target_cards_to_vars(card_vars, card.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Grass",
  atlas = "Gemdex3",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      local earn = false
      if find_other_poke_or_energy_type(card, "Grass") > 0 then
        earn = true
      end
      if (pseudorandom('treecko') < G.GAME.probabilities.normal/card.ability.extra.odds) or earn then
        for i=1, #card.ability.extra.targets do
          if context.other_card:get_id() == card.ability.extra.targets[i].id then
              local earned = ease_poke_dollars(card, "grovyle", card.ability.extra.money_mod, true)
              card.ability.extra.money_earned = card.ability.extra.money_earned + earned
              return {
                dollars = earned,
                card = card
              }
          end
        end
      end
    end
    return scaling_evo(self, card, context, "j_Gem_grovyle", card.ability.extra.money_earned, self.config.evo_rqmt)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("treecko", 3, card.ability.extra.targets)
    end
  end
}
-- Grovyle 253
local grovyle={
  name = "grovyle",
  poke_custom_prefix = "Gem",
  pos = {x = 1, y = 0},
  config = {extra = {money_mod = 2, money_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, h_size = 1, odds = 2}, evo_rqmt = 32},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local money_left = math.max(0, self.config.evo_rqmt - card.ability.extra.money_earned)
    local card_vars = {card.ability.extra.money_mod, money_left, card.ability.extra.h_size, ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}
    add_target_cards_to_vars(card_vars, card.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Grass",
  atlas = "Gemdex3",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      local earn = false
      if find_other_poke_or_energy_type(card, "Grass") > 0 then
        earn = true
      end
      if (pseudorandom('treecko') < G.GAME.probabilities.normal/card.ability.extra.odds) or earn then
        for i=1, #card.ability.extra.targets do
          if context.other_card:get_id() == card.ability.extra.targets[i].id then
              local earned = ease_poke_dollars(card, "grovyle", card.ability.extra.money_mod, true)
              card.ability.extra.money_earned = card.ability.extra.money_earned + earned
              return {
                dollars = earned,
                card = card
              }
          end
        end
      end
    end
    return scaling_evo(self, card, context, "j_Gem_sceptile", card.ability.extra.money_earned, self.config.evo_rqmt)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("grovyle", 3, card.ability.extra.targets)
    end
  end
}
-- Sceptile 254
local sceptile={
  name = "sceptile",
  poke_custom_prefix = "Gem",
  pos = {x = 2, y = 0},
  config = {extra = {money_mod = 2, money_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, h_size = 1, odds = 2}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local card_vars = {center.ability.extra.money_mod, center.ability.extra.money_earned, center.ability.extra.h_size, 
                       math.min(14, find_other_poke_or_energy_type(center, "Grass") * center.ability.extra.money_mod)}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    info_queue[#info_queue+1] = {set = 'Other', key = 'mega_poke'}
    return {vars = card_vars}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Grass",
  atlas = "Gemdex3",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
            local earned = ease_poke_dollars(card, "sceptile", card.ability.extra.money_mod, true)
            card.ability.extra.money_earned = card.ability.extra.money_earned + earned
            return {
              dollars = earned,
              card = card
            }
        end
      end
    end
  end,
  calc_dollar_bonus = function(self, card)
    return ease_poke_dollars(card, "sceptile", math.min(14, find_other_poke_or_energy_type(card, "Grass") * card.ability.extra.money_mod), true) 
	end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("sceptile", 3, card.ability.extra.targets)
    end
  end,
   megas = { "mega_sceptile" },
}
-- Mega Sceptile 254
local mega_sceptile={
  name = "mega_sceptile",
  poke_custom_prefix = "Gem",
  pos = { x = 12, y = 2 },
  soul_pos =  {x = 13, y = 2 },
  config = {extra = {money_mod = 2, money_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, h_size = 1, odds = 2}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local card_vars = {center.ability.extra.money_mod, center.ability.extra.money_earned,
                       math.min(14, find_other_poke_or_energy_type(center, "Grass") * center.ability.extra.money_mod)}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Grass",
  atlas = "GemMegas",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
            local earned = ease_poke_dollars(card, "mega_sceptile", math.min(14, find_other_poke_or_energy_type(card, "Grass") * card.ability.extra.money_mod + card.ability.extra.money_mod), true) 
            card.ability.extra.money_earned = card.ability.extra.money_earned + earned
            return {
              dollars = earned,
              card = card
            }
        end
      end
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("mega_sceptile", 3, card.ability.extra.targets)
    end
  end
}
-- Torchic 255
local torchic={
  name = "torchic",
  poke_custom_prefix = "Gem",
  pos = {x = 3, y = 0},
  config = {extra = {mult = 1, cards_discarded = 0, mult_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, d_size = 1}, evo_rqmt = 60},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local mult_left = math.max(0, self.config.evo_rqmt - card.ability.extra.mult_earned)
    local card_vars = {card.ability.extra.mult, mult_left, card.ability.extra.d_size, card.ability.extra.mult * card.ability.extra.cards_discarded}
    add_target_cards_to_vars(card_vars, card.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Fire",
  atlas = "Gemdex3",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local mult = card.ability.extra.mult * card.ability.extra.cards_discarded 
        card.ability.extra.mult_earned = card.ability.extra.mult_earned + mult
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {mult}}, 
          colour = G.C.MULT,
          mult_mod = mult
        }
      end
    end
    if context.discard and not context.other_card.debuff and not context.blueprint then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
          local discard_plus = 1
          if find_other_poke_or_energy_type(card, "Fire") > 0 or find_other_poke_or_energy_type(card, "Fighting") > 0 then
            discard_plus = 2
          end 
          card.ability.extra.cards_discarded = card.ability.extra.cards_discarded + discard_plus
          return {
            message = localize{type='variable',key='a_mult',vars={discard_plus}},
            colour = G.C.RED,
            delay = 0.45, 
            card = card
          }
        end
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.cards_discarded = 0
      card:juice_up()
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset')})
    end
    return scaling_evo(self, card, context, "j_Gem_combusken", card.ability.extra.mult_earned, self.config.evo_rqmt)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
    ease_discard(card.ability.extra.d_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    ease_discard(-card.ability.extra.d_size)
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("torchic", 3, card.ability.extra.targets)
    end
  end
}
-- Combusken 256
local combusken={
  name = "combusken",
  poke_custom_prefix = "Gem",
  pos = {x = 4, y = 0},
  config = {extra = {mult = 3, cards_discarded = 0, mult_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, d_size = 1}, evo_rqmt = 150},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local mult_left = math.max(0, self.config.evo_rqmt - card.ability.extra.mult_earned)
    local card_vars = {card.ability.extra.mult, mult_left, card.ability.extra.d_size, card.ability.extra.mult * card.ability.extra.cards_discarded}
    add_target_cards_to_vars(card_vars, card.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fire",
  atlas = "Gemdex3",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local mult = card.ability.extra.mult * card.ability.extra.cards_discarded 
        card.ability.extra.mult_earned = card.ability.extra.mult_earned + mult
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {mult}}, 
          colour = G.C.MULT,
          mult_mod = mult
        }
      end
    end
    if context.discard and not context.other_card.debuff and not context.blueprint then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
          local discard_plus = 1
          if find_other_poke_or_energy_type(card, "Fire") > 0 or find_other_poke_or_energy_type(card, "Fighting") > 0 then
            discard_plus = 2
          end 
          card.ability.extra.cards_discarded = card.ability.extra.cards_discarded + discard_plus
          return {
            message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
            colour = G.C.RED,
            delay = 0.45, 
            card = card
          }
        end
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.cards_discarded = 0
      card:juice_up()
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset')})
    end
    return scaling_evo(self, card, context, "j_Gem_blaziken", card.ability.extra.mult_earned, self.config.evo_rqmt)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
    ease_discard(card.ability.extra.d_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    ease_discard(-card.ability.extra.d_size)
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("combusken", 3, card.ability.extra.targets)
    end
  end
}
-- Blaziken 257
local blaziken={
  name = "blaziken",
  poke_custom_prefix = "Gem",
  pos = {x = 5, y = 0},
  config = {extra = {Xmult = .15, mult = 1, cards_discarded = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, d_size = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local card = center
    local mult = card.ability.extra.mult * card.ability.extra.cards_discarded * (find_other_poke_or_energy_type(card, "Fire", true) + find_other_poke_or_energy_type(card, "Fighting", true))
    local Xmult = 1 + card.ability.extra.Xmult * card.ability.extra.cards_discarded * (find_other_poke_or_energy_type(card, "Fire", true) + find_other_poke_or_energy_type(card, "Fighting", true))
    local card_vars = {center.ability.extra.Xmult, center.ability.extra.d_size, Xmult, center.ability.extra.mult, mult}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'mega_poke'}
    return {vars = card_vars}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Fire",
  atlas = "Gemdex3",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local mult = card.ability.extra.mult * card.ability.extra.cards_discarded * (find_other_poke_or_energy_type(card, "Fire", true) + find_other_poke_or_energy_type(card, "Fighting", true))
        local Xmult = 1 + card.ability.extra.Xmult * card.ability.extra.cards_discarded * (find_other_poke_or_energy_type(card, "Fire", true) + find_other_poke_or_energy_type(card, "Fighting", true))
        return {
          message = localize('poke_blazekick_ex'), 
          colour = G.C.MULT,
          Xmult_mod = Xmult,
          mult_mod = mult
        }
      end
    end
    if context.discard and not context.other_card.debuff and not context.blueprint then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
          card.ability.extra.cards_discarded = card.ability.extra.cards_discarded + 1
          return {
            message = localize('k_upgrade_ex'),
            colour = G.C.RED,
            delay = 0.45, 
            card = card
          }
        end
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.cards_discarded = 0
      card:juice_up()
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset')})
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
    ease_discard(card.ability.extra.d_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    ease_discard(-card.ability.extra.d_size)
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("blaziken", 3, card.ability.extra.targets)
    end
  end,
   megas = { "mega_blaziken" },
}
-- Mega Blaziken 257
local mega_blaziken={
  name = "mega_blaziken",
  poke_custom_prefix = "Gem",
  pos = {x = 14, y = 2},
  soul_pos = {x = 0, y = 3},
  config = {extra = {Xmult = .2, cards_discarded = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local card = center
    local Xmult = 1 + card.ability.extra.Xmult * card.ability.extra.cards_discarded * (find_other_poke_or_energy_type(card, "Fire", true) + find_other_poke_or_energy_type(card, "Fighting", true))
    local card_vars = {center.ability.extra.Xmult, Xmult}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Fire",
  atlas = "GemMegas",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local Xmult = 1 + card.ability.extra.Xmult * card.ability.extra.cards_discarded * (find_other_poke_or_energy_type(card, "Fire", true) + find_other_poke_or_energy_type(card, "Fighting", true))
        return {
          message = localize('poke_blazekick_ex'), 
          colour = G.C.MULT,
          Xmult_mod = Xmult,
        }
      end
    end
    if context.discard and not context.other_card.debuff and not context.blueprint then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
          card.ability.extra.cards_discarded = card.ability.extra.cards_discarded + 1
          return {
            message = localize('k_upgrade_ex'),
            colour = G.C.RED,
            delay = 0.45, 
            card = card
          }
        end
      end
    end
    if (context.end_of_round and G.GAME.blind.boss) and not context.individual and not context.repetition then
      card.ability.extra.cards_discarded = 0
      card:juice_up()
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset')})
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("mega_blaziken", 3, card.ability.extra.targets)
    end
  end
}
-- Mudkip 258
local mudkip={
  name = "mudkip",
  poke_custom_prefix = "Gem",
  pos = {x = 6, y = 0},
  config = {extra = {chips = 20, chips_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, hands = 1}, evo_rqmt = 400},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local chips_left = math.max(0, self.config.evo_rqmt - card.ability.extra.chips_earned)
    local card_vars = {card.ability.extra.chips, chips_left, card.ability.extra.hands}
    add_target_cards_to_vars(card_vars, card.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Water",
  atlas = "Gemdex3",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      local chips = card.ability.extra.chips
      if find_other_poke_or_energy_type(card, "Water") > 0 or find_other_poke_or_energy_type(card, "Earth") > 0 then
        chips = chips * 2
      end
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
          card.ability.extra.chips_earned = card.ability.extra.chips_earned + chips
          return {
            chips = chips,
            card = card
          }
        end
      end
    end
    return scaling_evo(self, card, context, "j_Gem_marshtomp", card.ability.extra.chips_earned, self.config.evo_rqmt)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("mudkip", 3, card.ability.extra.targets)
    end
  end
}
-- Marshtomp 259
local marshtomp={
  name = "marshtomp",
  poke_custom_prefix = "Gem",
  pos = {x = 7, y = 0},
  config = {extra = {chips = 30, chips_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, hands = 1}, evo_rqmt = 960},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local chips_left = math.max(0, self.config.evo_rqmt - card.ability.extra.chips_earned)
    local card_vars = {card.ability.extra.chips, chips_left, card.ability.extra.hands}
    add_target_cards_to_vars(card_vars, card.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Water",
  atlas = "Gemdex3",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      local chips = card.ability.extra.chips
      if find_other_poke_or_energy_type(card, "Water") > 0 or find_other_poke_or_energy_type(card, "Earth") > 0 then
        chips = chips * 2
      end
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
          card.ability.extra.chips_earned = card.ability.extra.chips_earned + chips
          return {
            chips = chips,
            card = card
          }
        end
      end
    end
    return scaling_evo(self, card, context, "j_Gem_swampert", card.ability.extra.chips_earned, self.config.evo_rqmt)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("marshtomp", 3, card.ability.extra.targets)
    end
  end
}
-- Swampert 260
local swampert={
  name = "swampert",
  poke_custom_prefix = "Gem",
  pos = {x = 8, y = 0},
  config = {extra = {chips = 40, chip_mod = 20, chips_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, hands = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local card_vars = {center.ability.extra.chips, center.ability.extra.chips_earned, center.ability.extra.hands, 
                       center.ability.extra.chips + center.ability.extra.chip_mod * (find_other_poke_or_energy_type(center, "Water") + find_other_poke_or_energy_type(center, "Earth")),                       center.ability.extra.chip_mod}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    info_queue[#info_queue+1] = {set = 'Other', key = 'mega_poke'}
    return {vars = card_vars}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Water",
  atlas = "Gemdex3",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      local chips = card.ability.extra.chips
      if find_other_poke_or_energy_type(card, "Water") or find_other_poke_or_energy_type(card, "Earth") then
        chips = chips + card.ability.extra.chip_mod * (find_other_poke_or_energy_type(card, "Water") + find_other_poke_or_energy_type(card, "Earth"))
      end
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
          card.ability.extra.chips_earned = card.ability.extra.chips_earned + chips
          return {
            chips = chips,
            card = card
          }
        end
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("swampert", 3, card.ability.extra.targets)
    end
  end,
   megas = { "mega_swampert" },
}
-- Mega Swampert 260
local mega_swampert={
  name = "mega_swampert",
  poke_custom_prefix = "Gem",
  pos = {x = 1, y = 3},
  soul_pos = {x = 2, y = 3},
  config = {extra = {chip_mod = 25, 
  targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local card_vars = {center.ability.extra.chip_mod, center.ability.extra.chip_mod * (find_other_poke_or_energy_type(center, "Water") + find_other_poke_or_energy_type(center, "Earth"))}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Water",
  atlas = "GemMegas",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and not context.other_card.debuff then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
          context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
          context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chip_mod + card.ability.extra.chip_mod * (find_other_poke_or_energy_type(card, "Water") + find_other_poke_or_energy_type(card, "Earth"))
          return {
              extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
              colour = G.C.CHIPS,
              card = card
            }
        end
      end
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("mega_swampert", 3, card.ability.extra.targets)
    end
  end
}
-- Mawile 303
local mawile={
  name = "mawile", 
  poke_custom_prefix = "Gem",
  pos = {x = 1, y = 5},
  config = {extra = {Xmult = 1, Xmult_mod = .5, eaten = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'mega_poke'}
    return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_mod, card.ability.extra.eaten } }
  end,
  rarity = 3, 
  cost = 8, 
  enhancement_gate = 'm_steel',
  stage = "Basic", 
  ptype = "Metal",
  atlas = "Gemdex3",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      local x_count = 0 
      local enhanced = {}
      for k, v in ipairs(context.scoring_hand) do
          if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then 
              enhanced[#enhanced+1] = v
              v.vampired = true
              if v.config.center == G.P_CENTERS.m_steel then
                x_count = x_count + 1
              end

              v:set_ability(G.P_CENTERS.c_base, nil, true)
              G.E_MANAGER:add_event(Event({
                  func = function()
                      v:juice_up()
                      v.vampired = nil
                      return true
                  end
              })) 
              card.ability.extra.eaten = card.ability.extra.eaten + 1
          end
      end

      if #enhanced > 0 then 
          if x_count > 0 then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod * x_count
          end
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
         message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        colour = G.C.XMULT,
        Xmult_mod = card.ability.extra.Xmult
        }
      end
    end
  end,
  megas = { "mega_mawile" },
}
-- Mega Mawile 303
local mega_mawile = {
  name = "mega_mawile",
  poke_custom_prefix = "Gem",
  pos = { x = 7, y = 3 },
  soul_pos =  {x = 8, y = 3 },
  config = {extra = {Xmult = 1, Xmult_mod = .75}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'mega_poke'}
    return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_mod } }
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Metal",
  atlas = "GemMegas",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      for k, v in ipairs(context.scoring_hand) do
        if v.config.center == G.P_CENTERS.m_steel and not v.debuff then
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        end
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
         message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        colour = G.C.XMULT,
        Xmult_mod = card.ability.extra.Xmult
        }
      end
    end
  end
}
-- Meditite
local meditite={
  name = "meditite", 
  poke_custom_prefix = "Gem",
  pos = {x = 5, y = 5}, 
  config = {extra = {mult = 0, mult_mod = .5, rounds = 4,}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local mult_total = center.ability.extra.mult
    if G.deck and G.deck.cards then
      for k, v in pairs(G.deck.cards) do
        if v:is_face() then mult_total = mult_total + center.ability.extra.mult_mod end
      end
    end
    if G.deck and G.deck.cards then
      for k, v in pairs(G.deck.cards) do
        if v:get_id() == 14 then mult_total = mult_total + center.ability.extra.mult_mod end
      end
    end
    return {vars = {center.ability.extra.mult, center.ability.extra.rounds, center.ability.extra.mult_mod, math.max(0, mult_total)}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Fighting",
  atlas = "Gemdex3",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local Mult = card.ability.extra.mult
        for k, v in pairs(G.deck.cards) do
          if v:is_face() then Mult = Mult + card.ability.extra.mult_mod end
        end
        for k, v in pairs(G.deck.cards) do
          if v:get_id() == 14 then Mult = Mult + card.ability.extra.mult_mod end
        end
        if Mult > 0 then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {Mult}}, 
            colour = G.C.MULT,
            mult_mod = Mult
          }
        end
      end
    end
    return level_evo(self, card, context, "j_Gem_medicham")
  end,
}
-- Medicham
local medicham={
  name = "medicham", 
  poke_custom_prefix = "Gem",
  pos = {x = 6, y = 5}, 
  config = {extra = {mult = 0, mult_mod = 1, Xchips_multi = 2}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local mult_total = center.ability.extra.mult
    if G.deck and G.deck.cards then
      for k, v in pairs(G.deck.cards) do
        if v:is_face() then mult_total = mult_total + center.ability.extra.mult_mod end
      end
    end
    if G.deck and G.deck.cards then
      for k, v in pairs(G.deck.cards) do
        if v:get_id() == 14 then mult_total = mult_total + center.ability.extra.mult_mod end
      end
    end
    info_queue[#info_queue + 1] = {set = 'Other', key = 'mega_poke'}
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.Xchips_multi, math.max(0, mult_total)}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fighting",
  atlas = "Gemdex3",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        for k, v in ipairs(context.scoring_hand) do
          if v:get_id() == 14 and not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
            local total_chips = poke_total_chips(context.other_card)
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
            return {
              colour = G.C.CHIPS,
              chips = total_chips,
              card = card
            }
          end
        end
      end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local Mult = card.ability.extra.mult
        for k, v in pairs(G.deck.cards) do
          if v:is_face() then Mult = Mult + card.ability.extra.mult_mod end
        end
        for k, v in pairs(G.deck.cards) do
          if v:get_id() == 14 then Mult = Mult + card.ability.extra.mult_mod end
        end
        if Mult > 0 then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {Mult}}, 
            colour = G.C.MULT,
            mult_mod = Mult
          }
        end
      end
    end
  end,
  megas = { "mega_medicham" },
}
-- Mega Medicham
local mega_medicham={
  name = "mega_medicham", 
  poke_custom_prefix = "Gem",
  pos = {x = 11, y = 3},
  soul_pos = {x = 12, y = 3},
  config = {extra = {xmult = 1, Xmult_mod = 0.25, Xchips_multi = 3, blackhole_amount = 2}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local xmult_total = center.ability.extra.xmult
    if G.deck and G.deck.cards then
      for k, v in pairs(G.deck.cards) do
        if v:get_id() == 14 then xmult_total = xmult_total + center.ability.extra.Xmult_mod end
      end
    end
    info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Strength"}}
    return {vars = {center.ability.extra.xmult, center.ability.extra.Xmult_mod, center.ability.extra.Xchips_multi, math.max(0, xmult_total), center.ability.extra.blackhole_amount}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Fighting",
  atlas = "GemMegas",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        for k, v in ipairs(context.scoring_hand) do
          if v:get_id() == 14 and not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
            local total_chips = poke_total_chips(context.other_card)
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
            return {
              colour = G.C.CHIPS,
              chips = total_chips + total_chips,
              card = card
            }
          end
        end
      end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local xMult = card.ability.extra.xmult
        for k, v in pairs(G.deck.cards) do
          if v:get_id() == 14 then xMult = xMult + card.ability.extra.Xmult_mod end
        end
        if xMult > 0 then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {xMult}}, 
            colour = G.C.MULT,
            Xmult_mod = xMult
          }
        end
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then
      for _ = 1,card.ability.extra.blackhole_amount do
        local _card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_strength")
        local edition = {negative = true}
        _card:set_edition(edition, true)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
      end
    end
  end,
}
-- Capsakid
local capsakid = {
  name = "capsakid",
  poke_custom_prefix = "Gem",
  pos = {x = 8, y = 3},
  config = {extra = {money = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.c_poke_firestone
    return {vars = {center.ability.extra.money}}
  end,
  rarity = 1, 
  cost = 4, 
  item_req = "firestone",
  stage = "Basic", 
  ptype = "Grass",
  atlas = "Gemdex9",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff and SMODS.has_enhancement(context.other_card,"m_mult") then
      local earned = ease_poke_dollars(card, "capsakid", card.ability.extra.money)
      return {
              dollars = earned,
              card = card
      }
    end
    return item_evo(self, card, context, "j_Gem_scovillain")
  end
}

-- Scovillain
local scovillain = {
  name = "scovillain",
  poke_custom_prefix = "Gem",
  pos = {x = 9, y = 3},
  config = {extra = {money = 2, mult = 4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.money, center.ability.extra.mult}}
  end,
  rarity = "poke_safari", 
  cost = 8, 
  stage = "One", 
  ptype = "Fire",
  atlas = "Gemdex9",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff and SMODS.has_enhancement(context.other_card,"m_mult") then
      local earned = ease_poke_dollars(card, "scovillain", card.ability.extra.money)
      return {
              dollars = earned,
              card = card
      }
    end
    if context.individual and not context.end_of_round and context.cardarea == G.hand then
      if SMODS.has_enhancement(context.other_card, 'm_gold') then 
          return {
            h_mult = card.ability.extra.mult,
            card = card,
          }
      end
    end
  end
}

list = {treecko, grovyle, sceptile, mega_sceptile, torchic, combusken, blaziken, mega_blaziken, mudkip, marshtomp, swampert, mega_swampert, mawile, mega_mawile, meditite, medicham, mega_medicham, capsakid, scovillain}

return {name = "Gems1",
list = list
}