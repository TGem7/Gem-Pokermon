function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Sandy Shocks 989
local sandy_shocks={
  name = "sandy_shocks", 
  pos = {x = 26, y = 65}, 
  soul_pos = {x = 27, y = 65}, 
  config = {extra = {Xmult = 1.5, count = 10}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult, center.ability.extra.count}}
  end,
  rarity = "Gem_paradox", 
  cost = 15, 
  stage = "Paradox", 
  ptype = "Lightning",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
  calculate = function(self, card, context)
      if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff and SMODS.has_enhancement(context.other_card, 'm_gold') then
        if not context.blueprint then
         card.ability.extra.count = card.ability.extra.count - 1
        end
        return {
          Xmult = card.ability.extra.Xmult,
          card = card
        }
      end
      if context.after and not context.blueprint then
        if card.ability.extra.count <= 0 then
          if G.hand.cards and #G.hand.cards > 0 then
            card.ability.extra.count = 10
            juice_flip_hand(card)
            for i = 1, #G.hand.cards do
              G.hand.cards[i]:set_ability(G.P_CENTERS.m_gold, nil, true)
            end
            juice_flip_hand(card, true)
          end
        end
      end
  end
}

return {
  name = "Gem's Sandy Shocks",
  enabled = Gem_config.Sandy_Shocks or false,
  list = { sandy_shocks }
}