function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
--  Minccino 572
local minccino = {
  name = "minccino",
  pos = PokemonSprites["minccino"].base.pos,
  config = {extra = {mult = 0, mult_mod = 2}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.c_poke_shinystone
    end
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}}
  end,
  rarity = 1,
  cost = 4,
  item_req = "shinystone",
  stage = "Basic",
  ptype = "Colorless",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  blueprint_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.before and #context.scoring_hand == 5 then
        local enhanced = 0
        for k, v in pairs(context.scoring_hand) do
          if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then 
           enhanced = enhanced + 1
           v.vampired = true
           v:set_ability(G.P_CENTERS.c_base, nil, true)
           G.E_MANAGER:add_event(Event({
              func = function()
                  v:juice_up()
                  v.vampired = nil
                  return true
              end
          })) 
          end
        end
        
        if enhanced > 0 and not context.blueprint then
          card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_mod * enhanced)
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult_mod * enhanced}},
            colour = G.C.MULT
          }
        end
      end
      if context.joker_main and card.ability.extra.mult > 0 then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult 
        }
      end
    end
    return item_evo(self, card, context, "j_Gem_cinccino")
  end
}

--  Cinccino 715
local cinccino = {
  name = "cinccino",
  pos = PokemonSprites["cinccino"].base.pos,
  config = {extra = {mult = 0, mult_mod = 3}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}}
  end,
  rarity = 'poke_safari',
  cost = 8,
  stage = "One",
  ptype = "Colorless",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  blueprint_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.before and #context.scoring_hand == 5 then
        local enhanced = 0
        for k, v in pairs(context.scoring_hand) do
          if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then 
            local edition = poll_edition('aura', nil, true, true)
            v:set_edition(edition, true, true)
            enhanced = enhanced + 1
            v.vampired = true
            v:set_ability(G.P_CENTERS.c_base, nil, true)
            G.E_MANAGER:add_event(Event({
                func = function()
                    v:juice_up()
                    v.vampired = nil
                    return true
                end
            })) 
          end
        end
        
        if enhanced > 0 and not context.blueprint then
          card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_mod * enhanced)
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult_mod * enhanced}},
            colour = G.C.MULT
          }
        end
      end
      if context.joker_main and card.ability.extra.mult > 0 then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult 
        }
      end
    end
    return item_evo(self, card, context, "j_Gem_cinccino")
  end
}

return {
  name = "Gem's Minccino",
  enabled = Gem_config.Minccino or false,
  list = {minccino, cinccino}
}

