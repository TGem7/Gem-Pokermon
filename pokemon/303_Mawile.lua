function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Mawile 303
local mawile={
  name = "mawile", 
  
  pos = PokemonSprites["mawile"].base.pos,
  config = {extra = {Xmult = 1, Xmult_mod = .25, eaten = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'mega_poke'}
    return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_mod, card.ability.extra.eaten } }
  end,
  rarity = 3, 
  cost = 8, 
  enhancement_gate = 'm_steel',
  stage = "Basic", 
  ptype = "Metal",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      local x_count = 0 
      local enhanced = {}
      for k, v in ipairs(context.scoring_hand) do
          if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then 
              enhanced[#enhanced+1] = v
              v.vampired = true
              if v.config.center == G.P_CENTERS.m_steel then
                x_count = x_count + 1
              end

              v:set_ability(G.P_CENTERS.c_base, nil, true)
              G.E_MANAGER:add_event(Event({
                  func = function()
                      v:juice_up()
                      v.vampired = nil
                      return true
                  end
              })) 
              card.ability.extra.eaten = card.ability.extra.eaten + 1
          end
      end

      if #enhanced > 0 then 
          if x_count > 0 then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod * x_count
          end
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
         message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        colour = G.C.XMULT,
        Xmult_mod = card.ability.extra.Xmult
        }
      end
    end
  end,
  megas = { "mega_mawile" },
}
-- Mega Mawile 303
local mega_mawile = {
  name = "mega_mawile",
  
  pos = { x = 10, y = 4 },
  soul_pos =  {x = 11, y = 4 },
  config = {extra = {Xmult = 1, Xmult_mod = .5}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'mega_poke'}
    return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_mod } }
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Metal",
  atlas = "AtlasJokersBasicGen03",
  gen = 3,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      for k, v in ipairs(context.scoring_hand) do
        if v.config.center == G.P_CENTERS.m_steel and not v.debuff then
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        end
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
         message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        colour = G.C.XMULT,
        Xmult_mod = card.ability.extra.Xmult
        }
      end
    end
  end
}

if Gem_config.Mawile then
  list = {mawile, mega_mawile}
else list = {}
end


return {name = "Mawile",
list = list
}
