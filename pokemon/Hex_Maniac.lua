-- Hex_Maniac 
local hex_maniac={
  name = "hex_maniac", 
  pos = {x = 0, y = 0},
  config = {extra = {rounds_total = 2, rounds_current = 0}},
  loc_vars = function(self, info_queue, card)
    if pokermon_config.detailed_tooltips then
      if not card.edition or (card.edition and not card.edition.polychrome) then
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
      end
    end
    return {vars = {card.ability.extra.rounds_total, card.ability.extra.rounds_current}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Other",
  designer = "vagabond_aeon",
  artist = "Sonfive",
  atlas = "Gem_hex_maniac",
  eternal_compat = false,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.selling_self and (card.ability.extra.rounds_current >= card.ability.extra.rounds_total) and not context.blueprint then
			local eligiblejokers = {}
			for k, v in pairs(G.jokers.cards) do
				if v.ability.set == "Joker" and not v.edition and v ~= card then
					table.insert(eligiblejokers, v)
				end
			end
			if #eligiblejokers > 0 then
				local eligible_card =
					pseudorandom_element(eligiblejokers, pseudoseed("hex_maniac"))
				local edition = { polychrome = true }
				eligible_card:set_edition(edition, true)
				check_for_unlock({ type = "have_edition" })
				if not context.retrigger_joker then
					card:juice_up(0.5, 0.5)
				end
			end
    end
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
      card.ability.extra.rounds_current = card.ability.extra.rounds_current + 1
      if card.ability.extra.rounds_current == card.ability.extra.rounds_total then
          local eval = function(card) return not card.REMOVED end
          juice_card_until(card, eval, true)
      end
      return {
          message = (card.ability.extra.rounds_current < card.ability.extra.rounds_total) and
              (card.ability.extra.rounds_current .. '/' .. card.ability.extra.rounds_total) or
              localize('k_active_ex'),
          colour = G.C.FILTER
      }
    end
  end,
  attributes = {"editions"},
}

return {
  config_key = "Hex_Maniac",
  list = { hex_maniac }
}
