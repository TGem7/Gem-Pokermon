function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Great Tusk 984
local great_tusk={
  name = "great_tusk", 
  pos = {x = 16, y = 65}, 
  soul_pos = {x = 17, y = 65}, 
  config = {extra = {Xmult = 1, Xmult_mod = 0.25}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod,}}
  end,
  rarity = "Gem_paradox", 
  cost = 15, 
  stage = "Paradox", 
  ptype = "Earth",
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
              G.hand.cards[i]:set_ability(G.P_CENTERS.m_stone, nil, true)
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
  name = "Gem's Great Tusk",
  enabled = Gem_config.Great_Tusk or false,
  list = { great_tusk }
}




