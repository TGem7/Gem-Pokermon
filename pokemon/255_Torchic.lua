function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Torchic 255
local torchic={
  name = "torchic",
  
  pos = PokemonSprites["torchic"].base.pos,
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
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
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
  
  pos = PokemonSprites["combusken"].base.pos,
  config = {extra = {mult = 2, cards_discarded = 0, mult_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, d_size = 1}, evo_rqmt = 150},
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
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
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
  
  pos = PokemonSprites["blaziken"].base.pos,
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
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
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
  
  pos = {x = 2, y = 4},
  soul_pos = {x = 3, y = 4},
  config = {extra = {Xmult = .25, cards_discarded = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}}},
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
  atlas = "AtlasJokersBasicGen03",
  gen = 3,
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

if Gem_config.Torchic then
  list = {torchic, combusken, blaziken, mega_blaziken}
else list = {}
end


return {name = "Torchic",
list = list
}
