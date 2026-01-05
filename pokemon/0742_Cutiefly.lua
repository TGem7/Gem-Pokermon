function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
-- Cutiefly 742
local cutiefly={
  name = "cutiefly", 
  pos = PokemonSprites["cutiefly"].base.pos,
  config = {extra = {money_mod = 3, money_earned = 0, seeds_scoring = 15, seeds_scored = 0}, evo_rqmt = 15},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.money_mod, center.ability.extra.seeds_scoring}}
  end,
  rarity = 1, 
  cost = 4, 
  enhancement_gate = 'm_poke_seed',
  stage = "Basic", 
  ptype = "Fairy",
  atlas = "AtlasJokersBasicNatdex",
  gen = 7,
  blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_poke_seed') then
            card.ability.extra.seeds_scoring = card.ability.extra.seeds_scoring - 1
            card.ability.extra.seeds_scored = card.ability.extra.seeds_scored + 1
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money_mod
            local earned = ease_poke_dollars(card, "cutiefly", math.min(14, card.ability.extra.money_mod), true) 
            card.ability.extra.money_earned = card.ability.extra.money_earned + earned
            return {
              dollars = earned,
              card = card
            }
        end
    return scaling_evo(self, card, context, "j_Gem_ribombee", card.ability.extra.seeds_scored, self.config.evo_rqmt)
    end,
}

-- Ribombee 743
local ribombee={
  name = "ribombee", 
  pos = PokemonSprites["ribombee"].base.pos,
  config = {extra = {money_mod = 5, money_earned = 0, retriggers = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.money_mod}}
  end,
  rarity = 'poke_safari', 
  cost = 8, 
  enhancement_gate = 'm_poke_seed',
  stage = "One", 
  ptype = "Fairy",
  atlas = "AtlasJokersBasicNatdex",
  gen = 7,
  blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_poke_seed') then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money_mod
            local earned = ease_poke_dollars(card, "cutiefly", math.min(14, card.ability.extra.money_mod), true) 
            card.ability.extra.money_earned = card.ability.extra.money_earned + earned
            return {
              dollars = earned,
              card = card
            }
        end
    if context.before then
      for _, scored_card in ipairs(context.scoring_hand) do
        if SMODS.has_enhancement(scored_card,"m_poke_flower") then
          scored_card:set_ability("m_poke_seed",nil,true)
          G.E_MANAGER:add_event(Event({
            func = function()
              scored_card:juice_up()
              return true
            end
          }))
        end
      end
    end
  end
}


return {
  name = "Gem's Cutiefly",
  enabled = Gem_config.Cutiefly or false,
  list = { cutiefly, ribombee }
}

