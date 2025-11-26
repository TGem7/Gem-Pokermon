function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Mega Swampert 260
local mega_swampert={
  name = "mega_swampert",
  Gem_inject_prefix = "poke",
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
  name = "Gem's Mega Swampert",
  enabled = true,
  list = { mega_swampert }
}



