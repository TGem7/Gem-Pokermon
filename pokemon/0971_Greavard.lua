function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

--  Greavard 971
local greavard = {
  name = "greavard",
  pos = PokemonSprites["greavard"].base.pos,
  config = { extra = { Xmult_mod = 0.25, greavard_tally = 0, rank_count = 13, rounds = 4 } },
  loc_vars = function(self, info_queue, center)
      return { vars = { center.ability.extra.Xmult_mod, 1 + (center.ability.extra.Xmult_mod * (center.ability.extra.rank_count - center.ability.extra.greavard_tally)), center.ability.extra.rounds } }
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  designer = "princessroxie",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
            return {
              message = localize('poke_last_respects_ex'), 
              colour = G.C.XMULT,
              Xmult_mod = 1 + (card.ability.extra.Xmult_mod * (card.ability.extra.rank_count - card.ability.extra.greavard_tally))
            }
      end
    end 
    return level_evo(self, card, context, "j_Gem_houndstone")
  end,
  update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN then
      card.ability.extra.greavard_tally = 0
      local ranks = {}
      for i = 2, 14 do
        for _, v in pairs(G.deck.cards) do
          if v:get_id() == i and not GEM.utils.contains(ranks, i) then 
            ranks[#ranks-1] = i
            card.ability.extra.greavard_tally = card.ability.extra.greavard_tally + 1
          end
        end
      end
    end
  end
}

--  Houndstone 972
local houndstone = {
  name = "houndstone",
  pos = PokemonSprites["houndstone"].base.pos,
  config = { extra = { Xmult_mod = 0.5, greavard_tally = 0, rank_count = 13 } },
  loc_vars = function(self, info_queue, center)
      return { vars = { center.ability.extra.Xmult_mod, 1 + (center.ability.extra.Xmult_mod * (center.ability.extra.rank_count - center.ability.extra.greavard_tally)) } }
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  designer = "princessroxie",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then     
          return {
            message = localize('poke_last_respects_ex'), 
            colour = G.C.XMULT,
            Xmult_mod = 1 + (card.ability.extra.Xmult_mod * (card.ability.extra.rank_count - card.ability.extra.greavard_tally))
          }
      end
    end 
  end,
  update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN then
      card.ability.extra.greavard_tally = 0
      local ranks = {}
      for i = 2, 14 do
        for _, v in pairs(G.deck.cards) do
          if v:get_id() == i and not GEM.utils.contains(ranks, i) then 
            ranks[#ranks-1] = i
            card.ability.extra.greavard_tally = card.ability.extra.greavard_tally + 1
          end
        end
      end
      if card.ability.extra.greavard_tally <= 0 then
        if card.ability.extra.rank_count < 26 then
          card.ability.extra.rank_count = card.ability.extra.rank_count * 2
        end
      end
      if card.ability.extra.rank_count >= 26 then
        if card.ability.extra.greavard_tally > 0 then
          card.ability.extra.rank_count = 13
        end
      end
    end
  end
}

return {
  name = "Gem's Greavard",
  enabled = Gem_config.Greavard or false,
  list = {greavard, houndstone}
}

