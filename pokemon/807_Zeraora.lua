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
  config = {extra = {Xmult_multi = 1.75}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult_multi, }}
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
    if context.other_joker and is_type(context.other_joker, "Lightning") then
      G.E_MANAGER:add_event(Event({
        func = function()
            context.other_joker:juice_up(0.5, 0.5)
            return true
        end
      })) 
      return {
        message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult_multi}}, 
        colour = G.C.XMULT,
        Xmult_mod = card.ability.extra.Xmult_multi
      }
    end
    local lights = 0
    for k, v in pairs(G.jokers.cards) do
        if is_type(v, "Lightning") then lights = lights + 1 end
    end
    if lights == #G.jokers.cards then
      if context.final_scoring_step then
        return {
          balance = true
        }
      end
    end
  end
}

return {
  name = "Gem's Zeraora",
  enabled = Gem_config.Zeraora or false,
  list = { zeraora }
}





