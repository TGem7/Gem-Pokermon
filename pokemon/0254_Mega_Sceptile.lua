function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Mega Sceptile 254
local mega_sceptile={
  name = "mega_sceptile",
  Gem_inject_prefix = "poke",
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
  name = "Gem's Mega Sceptile",
  enabled = true,
  list = { mega_sceptile }
}








