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

return {
  name = "Gem's Mega Blaziken",
  enabled = true,
  list = { mega_blaziken }
}



