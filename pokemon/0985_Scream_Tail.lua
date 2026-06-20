

-- Scream Tail 985
local scream_tail={
  name = "scream_tail", 
  pos = {x = 18, y = 65}, 
  soul_pos = {x = 19, y = 65}, 
  config = {extra = {chips = 10, mult = 2, suit = "Spades"}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.chips, center.ability.extra.mult, localize(center.ability.extra.suit, 'suits_singular')}}
  end,
  rarity = "Gem_paradox", 
  cost = 15, 
  stage = "Paradox", 
  ptype = "Fairy",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
  calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
          context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.chips
		  context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
		end	
	end,
}

return {
  config_key = "Scream_Tail",
  list = { scream_tail }
}
