function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Mega Blaziken 257
local mega_blaziken={
  name = "mega_blaziken",
  Gem_inject_prefix = "poke",
  pos = {x = 2, y = 4},
  soul_pos = {x = 3, y = 4},
  config = {extra = {Xmult_multi = 1, Xmult_multi_mod = 0.1, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local card = center
    local xmult_multi = center.ability.extra.Xmult_multi + (center.ability.extra.Xmult_multi_mod * (#find_pokemon_type("Fire")+#find_pokemon_type("Fighting")))
    local card_vars = {center.ability.extra.Xmult_multi, center.ability.extra.Xmult_multi_mod, xmult_multi}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Fire",
  atlas = "AtlasJokersBasicGen03",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
            local xmult_multi = card.ability.extra.Xmult_multi + (card.ability.extra.Xmult_multi_mod * (#find_pokemon_type("Fire")+#find_pokemon_type("Fighting")))
            return {
              Xmult = xmult_multi,
              card = card
            }
        end
      end
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_ranks("mega_blaziken", 3, card.ability.extra.targets)
    end
  end
}

return {
  name = "Gem's Mega Blaziken",
  enabled = Gem_config.Starter_Megas or false,
  list = { mega_blaziken }
}


