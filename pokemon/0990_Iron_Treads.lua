function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Iron Treads 990
local iron_treads={
  name = "iron_treads", 
  pos = {x = 28, y = 65}, 
  soul_pos = {x = 29, y = 65}, 
  config = {extra = {Xmult = 1, Xmult_mod = 0.25}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod,}}
  end,
  rarity = "Gem_future_paradox", 
  cost = 15, 
  stage = "Paradox", 
  ptype = "Metal",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.before and not context.blueprint then
        if #context.scoring_hand >= 5 then
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
          return {
            message = localize('k_upgrade_ex'),
            colour = G.C.RED,
            card = card
          }
        end
      end
      if context.joker_main and card.ability.extra.Xmult > 1 then
        if #context.scoring_hand >= 5 and not context.blueprint then
          if G.hand.cards and #G.hand.cards > 0 then
            juice_flip_hand(card)
            for i = 1, #G.hand.cards do
              G.hand.cards[i]:set_ability(G.P_CENTERS.m_steel, nil, true)
            end
            juice_flip_hand(card, true)
          end
        end
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}, 
          colour = G.C.XMULT,
          Xmult_mod = card.ability.extra.Xmult
        }
      end
    end
  end
}

return {
  name = "Gem's Iron Treads",
  enabled = Gem_config.Iron_Treads or false,
  list = { iron_treads }
}




