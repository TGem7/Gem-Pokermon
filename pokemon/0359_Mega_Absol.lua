function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Mega Absol 359
local mega_absol={
  name = "mega_absol",
  Gem_inject_prefix = "poke",
  pos = {x = 8, y = 5},
  soul_pos = {x = 9, y = 5},
  config = {extra = {Xmult = 3, volatile = "left", volatile2 = "right"}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Dark",
  atlas = "AtlasJokersBasicGen03",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}, 
          colour = G.C.XMULT,
          Xmult_mod = card.ability.extra.Xmult
        }
      end
    end
    if context.mod_probability and not context.blueprint and volatile_active(self, card, card.ability.extra.volatile2) then
        return {
            numerator = context.numerator * 2,
        }
    end
    if context.fix_probability and not context.blueprint and volatile_active(self, card, card.ability.extra.volatile) then
      return {
        numerator = 0,
      }
    end
  end
}

return {
  name = "Gem's Mega Absol",
  enabled = true,
  list = { mega_absol }
}








