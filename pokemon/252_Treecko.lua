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
  
  pos = PokemonSprites["treecko"].base.pos,
  config = {extra = {money_mod = 1, money_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, h_size = 1, num = 1, dem = 2}, evo_rqmt = 16},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    end
    local money_left = math.max(0, self.config.evo_rqmt - card.ability.extra.money_earned)
    local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, 'treecko')
    local card_vars = {card.ability.extra.money_mod, money_left, card.ability.extra.h_size, num, dem}
    add_target_cards_to_vars(card_vars, card.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  starter = true,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      local earn = false
      if find_other_poke_or_energy_type(card, "Grass") > 0 then
        earn = true
      end
      if (SMODS.pseudorandom_probability(card, 'treecko', card.ability.extra.num, card.ability.extra.dem, 'treecko')) or earn then
        for i=1, #card.ability.extra.targets do
          if context.other_card:get_id() == card.ability.extra.targets[i].id then
              local earned = ease_poke_dollars(card, "grovyle", card.ability.extra.money_mod, true)
              if not context.blueprint then
                card.ability.extra.money_earned = card.ability.extra.money_earned + earned
              end
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
  
  pos = PokemonSprites["grovyle"].base.pos,
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
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
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
  
  pos = PokemonSprites["sceptile"].base.pos,
  config = {extra = {money_mod = 2, money_increase = 1, money_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, h_size = 1, odds = 2}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local card_vars = {center.ability.extra.money_mod, center.ability.extra.money_earned, center.ability.extra.h_size, 
                       center.ability.extra.money_mod + (find_other_poke_or_energy_type(center, "Grass") * center.ability.extra.money_increase), center.ability.extra.money_increase}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    info_queue[#info_queue+1] = {set = 'Other', key = 'mega_poke'}
    return {vars = card_vars}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
            local earned = ease_poke_dollars(card, "sceptile", card.ability.extra.money_mod + (find_other_poke_or_energy_type(card, "Grass") * card.ability.extra.money_increase), true)
            card.ability.extra.money_earned = card.ability.extra.money_earned + earned
            return {
              dollars = earned,
              card = card
            }
        end
      end
    end
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
  
  pos = {x = 0, y = 4},
  soul_pos = {x = 1, y = 4},
  config = {extra = {money_mod = 3, money_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, h_size = 1, odds = 2}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local card_vars = {center.ability.extra.money_mod, center.ability.extra.money_earned,
                       center.ability.extra.money_mod + ((find_other_poke_or_energy_type(center, "Grass") + find_other_poke_or_energy_type(center, "Dragon")) * center.ability.extra.money_mod)}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Grass",
  atlas = "AtlasJokersBasicGen03",
  gen = 3,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
            local earned = ease_poke_dollars(card, "mega_sceptile", card.ability.extra.money_mod + ((find_other_poke_or_energy_type(card, "Grass") + find_other_poke_or_energy_type(card, "Dragon")) * card.ability.extra.money_mod), true) 
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

return {
  name = "Gem's Treecko",
  enabled = Gem_config.Treecko or false,
  list = { treecko, grovyle, sceptile, mega_sceptile }
}







