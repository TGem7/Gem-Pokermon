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
  config = {extra = {chips = 80, chip_mod = 20, num = 1, dem = 5,
  targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local Chips = center.ability.extra.chips + center.ability.extra.chip_mod * (find_other_poke_or_energy_type(center, "Water") + find_other_poke_or_energy_type(center, "Earth"))
    local num, dem = SMODS.get_probability_vars(center, center.ability.extra.num + (find_other_poke_or_energy_type(center, "Water") + find_other_poke_or_energy_type(center, "Earth")), center.ability.extra.dem, 'alcremie')
    local card_vars = {center.ability.extra.chips, center.ability.extra.chip_mod, center.ability.extra.chip_mod * (find_other_poke_or_energy_type(center, "Water") + find_other_poke_or_energy_type(center, "Earth")), num, dem, Chips}
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
          if (not context.other_card.debuff) and SMODS.pseudorandom_probability(card, 'mega_swampert', card.ability.extra.num + (find_other_poke_or_energy_type(card, "Water") + find_other_poke_or_energy_type(card, "Earth")), card.ability.extra.dem, 'mega_swampert') then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
              local Chips = card.ability.extra.chips + card.ability.extra.chip_mod * (find_other_poke_or_energy_type(card, "Water") + find_other_poke_or_energy_type(card, "Earth"))
              return {
            extra = {focus = card, message = localize('k_plus_tarot'), colour = G.C.PURPLE, func = function()
              G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                  local card_type = 'Tarot'
                  local _card = create_card(card_type,G.consumeables, nil, nil, nil, nil, nil, 'sup')
                  _card:add_to_deck()
                  G.consumeables:emplace(_card)
                  G.GAME.consumeable_buffer = 0
                  return true
                end
              }))
            end},
                 chips = Chips,
                 colour = G.C.CHIPS,
                 card = card
                }
             else
              local Chips = card.ability.extra.chips + card.ability.extra.chip_mod * (find_other_poke_or_energy_type(card, "Water") + find_other_poke_or_energy_type(card, "Earth"))
              return {
                 chips = Chips,
                 colour = G.C.CHIPS,
                 card = card
                }
             end
          else
              local Chips = card.ability.extra.chips + card.ability.extra.chip_mod * (find_other_poke_or_energy_type(card, "Water") + find_other_poke_or_energy_type(card, "Earth"))
              return {
                 chips = Chips,
                 colour = G.C.CHIPS,
                 card = card
                }
          end
        end
      end
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      self:set_nature(card)
    end
  end,
  set_nature = function(self,card)
    card.ability.extra.targets = get_poke_target_card_ranks("mega_swampert", 3, card.ability.extra.targets)
  end,
}

return {
  name = "Gem's Mega Swampert",
  enabled = true,
  list = { mega_swampert }
}



