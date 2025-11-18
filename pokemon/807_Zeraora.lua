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
  pos = {x = 22, y = 53}, 
  soul_pos = {x = 23, y = 53}, 
  config = {extra = {Xmult_multi = 1.1, Xmult_multi_mod = 0.1, money_mod = 2, money_increase = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local xmult_multi = center.ability.extra.Xmult_multi + (center.ability.extra.Xmult_multi_mod * #find_pokemon_type("Lightning"))
    local Money = center.ability.extra.money_mod + (center.ability.extra.money_increase * #find_pokemon_type("Lightning"))
    return {vars = {center.ability.extra.Xmult_multi, center.ability.extra.Xmult_multi_mod, center.ability.extra.money_mod, center.ability.extra.money_increase, xmult_multi, Money}}
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
            local Money = card.ability.extra.money_mod + (card.ability.extra.money_increase * #find_pokemon_type("Lightning"))
            local earned = ease_poke_dollars(card, "zeraora", Money, true)
            local xmult_multi = card.ability.extra.Xmult_multi + (card.ability.extra.Xmult_multi_mod * #find_pokemon_type("Lightning"))
            return {
              Xmult = xmult_multi,
              dollars = earned,
              card = card
            }
    end
    if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss then
      if G.jokers and G.jokers.cards and #G.jokers.cards > 1 then
        apply_type_sticker(G.jokers.cards[1], "Lightning")
        card:juice_up()
        card_eval_status_text(G.jokers.cards[1], 'extra', nil, nil, nil, {message = localize("poke_tera_ex"), colour = G.C.SECONDARY_SET.Spectral})
      end
    end
  end,
}

return {
  name = "Gem's Zeraora",
  enabled = Gem_config.Zeraora or false,
  list = { zeraora }
}



