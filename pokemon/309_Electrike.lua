function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

--  Zeraora 807
local zeraora = {
  name = "zeraora",
  pos = PokemonSprites["zeraora"].base.pos,
  config = {extra = {Xmult_multi = 1.2, Xmult_multi_mod = 0.1, money_mod = 3, money_increase = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    end
    local card_vars = {center.ability.extra.money_mod, center.ability.extra.money_increase}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    info_queue[#info_queue+1] = {set = 'Other', key = 'mega_poke'}
    return {vars = card_vars}
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Lightning",
  atlas = "AtlasJokersBasicNatdex",
  gen = 7,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
            local plasma = (card, "zeraora", card.ability.extra.Xmult_multi + (find_other_poke_or_energy_type(card, "Lightning") * card.ability.extra.Xmult_multi_mod), true)
            local earned = ease_poke_dollars(card, "zeraora", card.ability.extra.money_mod + (find_other_poke_or_energy_type(card, "Lightning") * card.ability.extra.money_increase), true)
            return {
               Xmult = card.ability.extra.Xmult_multi
              dollars = earned,
              card = card
            }
    end
  end,
}

return {
  name = "Gem's Zeraora",
  enabled = Gem_config.Zeraora or false,
  list = { zeraora }
}



