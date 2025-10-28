function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
-- Hisuian Growlithe 058
local hisuian_growlithe={
  name = "hisuian_growlithe", 
  pos = {x = 14, y = 5},
  config = {extra = {mult = 8}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.c_poke_firestone
    end
    return {vars = {center.ability.extra.mult}}
  end,
  rarity = 2, 
  cost = 5, 
  item_req = "firestone",
  stage = "Basic", 
  ptype = "Earth",
  atlas = "AtlasJokersBasicGen01",
  gen = 1,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and next(context.poker_hands['Flush']) then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult
        }
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        for k, v in pairs(context.scoring_hand) do
            if SMODS.has_enhancement(v, 'm_stone') then
              bonus = true
            end
        end
        if bonus then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
            colour = G.C.MULT,
            mult_mod = card.ability.extra.mult
          }
        end
      end
    end
    return item_evo(self, card, context, "j_Gem_hisuian_arcanine")
  end,
}
--Hisuian Arcanine 059
local hisuian_arcanine={
  name = "hisuian_arcanine", 
  pos = {x = 0, y = 6},
  config = {extra = {mult = 12, Xmult = 2}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_stone
      info_queue[#info_queue+1] = G.P_CENTERS.m_wild
    end
    return {vars = {center.ability.extra.mult, center.ability.extra.Xmult}}
  end,
  rarity = "poke_safari", 
  cost = 8, 
  stage = "One", 
  ptype = "Earth",
  atlas = "AtlasJokersBasicGen01",
  gen = 1,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.check_enhancement then
      if context.other_card.config.center.key == "m_stone" then
        return {m_wild = true}
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and next(context.poker_hands['Flush']) then
        for k, v in pairs(context.scoring_hand) do
            if SMODS.has_enhancement(v, 'm_stone') then
              bonus = true
            end
        end
        if bonus then
          return {
            message = localize('poke_head_smash_ex'),
            colour = G.C.MULT,
            mult_mod = card.ability.extra.mult,
            Xmult_mod = card.ability.extra.Xmult
          }
        else
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
            colour = G.C.XMULT,
            mult_mod = card.ability.extra.mult
          }
        end
      end
    end
    if context.after and not context.blueprint then
     bonus = false
    end
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
     bonus = false
    end
  end,
}

return {
  name = "Gem's Hisuian Growlithe",
  enabled = Gem_config.H_Growlithe or false,
  list = { hisuian_growlithe, hisuian_arcanine }
}

