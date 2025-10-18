function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Capsakid
local capsakid = {
  name = "capsakid",
  
  pos = PokemonSprites["capsakid"].base.pos,
  config = {extra = {money = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.c_poke_firestone
    return {vars = {center.ability.extra.money}}
  end,
  rarity = 1, 
  cost = 4, 
  enhancement_gate = 'm_mult',
  item_req = "firestone",
  stage = "Basic", 
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff and SMODS.has_enhancement(context.other_card,"m_mult") then
      local earned = ease_poke_dollars(card, "capsakid", card.ability.extra.money, true)
      return {
              dollars = earned,
              card = card
      }
    end
    return item_evo(self, card, context, "j_Gem_scovillain")
  end
}

-- Scovillain
local scovillain = {
  name = "scovillain",
  
  pos = PokemonSprites["scovillain"].base.pos,
  config = {extra = {money = 2, mult = 4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.money, center.ability.extra.mult}}
  end,
  rarity = "poke_safari", 
  cost = 8, 
  stage = "One", 
  ptype = "Fire",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff and SMODS.has_enhancement(context.other_card,"m_mult") then
      local earned = ease_poke_dollars(card, "scovillain", card.ability.extra.money, true)
      return {
              message = localize('poke_spicy_ex'),
              dollars = earned,
              card = card
      }
    end
    if context.individual and not context.end_of_round and context.cardarea == G.hand then
      if SMODS.has_enhancement(context.other_card, 'm_gold') then 
          return {
            message = localize('poke_spicy_ex'),
            h_mult = card.ability.extra.mult,
            card = card,
          }
      end
    end
  end
}

if Gem_config.Capsakid then
  list = {capsakid, scovillain}
else list = {}
end


return {name = "Capsakid",
list = list
}
