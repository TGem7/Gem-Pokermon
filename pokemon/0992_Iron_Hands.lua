function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Iron Hands 992
local iron_hands={
  name = "iron_hands", 
  pos = {x = 2, y = 66}, 
  soul_pos = {x = 3, y = 66}, 
  config = {extra = {money_mod = 1, earned = 0, h_size = 2, orig_h_size = 2, money_threshold = 100}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.money_mod, center.ability.extra.earned, center.ability.extra.h_size, center.ability.extra.money_threshold}}
  end,
  rarity = "Gem_future_paradox", 
  cost = 15, 
  stage = "Paradox", 
  ptype = "Fighting",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      local dollars = G.GAME.dollars
      if (SMODS.Mods["Talisman"] or {}).can_load then
        dollars = to_number(dollars)
      end
      if dollars > card.ability.extra.money_threshold then
          local changed_size = 2
          card.ability.extra.h_size = card.ability.extra.h_size + changed_size
          G.hand:change_size(changed_size)
      end
    end

    if context.individual and context.cardarea == G.hand then
      if not context.end_of_round and not context.before and not context.after then
        if context.other_card.debuff then
          return {
            message = localize("k_debuffed"),
            colour = G.C.RED,
            card = card,
          }
        else
          local earned = 0
          if not context.blueprint then
            card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money_mod
          end
          
          earned = earned + card.ability.extra.money_mod
          earned = ease_poke_dollars(card, "hands", earned)
          return {
              message = localize('$')..earned,
              colour = G.C.MONEY,
              card = card
          }
        end
      end
    end
        -- reset to original size when finished
        if context.end_of_round and context.cardarea == G.jokers then
            G.hand:change_size(-(card.ability.extra.h_size-card.ability.extra.orig_h_size))
            card.ability.extra.h_size = card.ability.extra.orig_h_size
        end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
}

return {
  name = "Gem's Iron Hands",
  enabled = Gem_config.Iron_Hands or false,
  list = { iron_hands }
}




