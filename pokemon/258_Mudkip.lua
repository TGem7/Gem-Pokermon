function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Mudkip 258
local mudkip={
  name = "mudkip",
  
  pos = PokemonSprites["mudkip"].base.pos,
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
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  starter = true,
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
  
  pos = PokemonSprites["marshtomp"].base.pos,
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
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
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
  
  pos = PokemonSprites["swampert"].base.pos,
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
  atlas = "AtlasJokersBasicNatdex",
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
  
  pos = {x = 4, y = 4},
  soul_pos = {x = 5, y = 4},
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
  atlas = "AtlasJokersBasicGen03",
  gen = 3,
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

return {
  name = "Gem's Mudkip",
  enabled = Gem_config.Mudkip or false,
  list = { mudkip, marshtomp, swampert, mega_swampert }
}



