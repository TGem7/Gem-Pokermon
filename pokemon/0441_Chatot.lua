-- Chatot 441
local chatot={
  name = "chatot",
  config = {extra = {Xmult = 1, Xmult_mod = 0.05, }},
  pos = {x = 10, y = 29},
  rarity = 3, 
  cost = 8, 
  stage = "Basic", 
  ptype = "Colorless",
  atlas = "AtlasJokersSeriesANatdex",
  gen = 4,
  designer = "Whimsy",
  custom_art = true,
  blueprint_compat = true,
  perishable_compat = false,
  loc_vars = function(self, info_queue, center)
    local abbr = center.ability.extra
		return {vars = {abbr.Xmult, abbr.Xmult_mod, G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or localize("poke_none")}}
  end,
  calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local reset = false
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
			for k, v in pairs(G.GAME.hands) do
				if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
					reset = true
				end
			end
			if reset then
        card.ability.extra.Xmult = 1
        return {
          message = localize('k_reset'),
          nil, true
        }
			else
        SMODS.scale_card(card, {
          ref_value = 'Xmult',
          scalar_value = 'Xmult_mod',
          message_colour = G.C.MULT,
        })
				return nil, true
			end
		end
		--Adding actual scoring because that is missing
		if context.joker_main  then
			return {
				xmult = card.ability.extra.Xmult,
			}
		end
  end,

  add_to_deck = function(self, card, from_debuff)
    card.ability.extra.last_hand = G.GAME.last_hand_played
  end,
  attributes = {"hand_type", "Xmult", "scaling", "reset", "scaling_evo"},
}

return {
  config_key = "Chatot",
  list = {chatot}
}







