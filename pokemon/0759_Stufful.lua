function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Stufful 759
local stufful={
  name = "stufful",
  pos = PokemonSprites["stufful"].base.pos,
  config = { extra = { mult = 8, rounds = 4 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.rounds } }
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Fighting",
  atlas = "AtlasJokersBasicNatdex",
  gen = 7,
  enhancement_gate = 'm_wild',
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_wild') then
            return {
                mult = card.ability.extra.mult
            }
        end
        return level_evo(self, card, context, "j_Gem_bewear")
    end,
}

-- Bewear 760
local bewear={
  name = "bewear",
  pos = PokemonSprites["bewear"].base.pos,
  config = { extra = { Xmult_multi = 1.4, rounds = 4 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult_multi } }
  end,
  rarity = 2,
  cost = 6,
  stage = "One",
  ptype = "Fighting",
  atlas = "AtlasJokersBasicNatdex",
  gen = 7,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers and context.scoring_hand and context.full_hand and #context.full_hand == 1 then
      local face = context.scoring_hand[1]
      face:set_ability(G.P_CENTERS.m_wild, nil, true)
      G.E_MANAGER:add_event(Event({
          func = function()
              face:juice_up()
              return true
          end
      })) 
      return {
        message = localize('Gem_bear_hug'),
        card = card
      }
    end
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_wild') then
            return {
                xmult = card.ability.extra.Xmult_multi
            }
        end
    end,
}

return {
  name = "Gem's Stufful",
  enabled = Gem_config.Stufful or false,
  list = { stufful, bewear }
}

