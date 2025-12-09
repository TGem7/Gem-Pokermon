function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Flutter Mane 987
local flutter_mane={
  name = "flutter_mane", 
  pos = {x = 22, y = 65}, 
  soul_pos = {x = 23, y = 65}, 
  config = {extra = {chip_mod = 10, chips = 0, cards_scored = 0, score_goal = 100}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    if not card.edition or (card.edition and not card.edition.negative) then
      info_queue[#info_queue+1] = G.P_CENTERS.e_negative
    end
    return {vars = {card.ability.extra.chip_mod, card.ability.extra.chips, card.ability.extra.score_goal, math.max(0, card.ability.extra.score_goal - card.ability.extra.cards_scored)}}
  end,
  designer = "MaelMC",
  rarity = "Gem_paradox", 
  cost = 15, 
  stage = "Paradox", 
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card then
      if not context.other_card.debuff and context.other_card:is_face() then
        context.other_card.ability.nominal_drain = context.other_card.ability.nominal_drain or 0
        context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
        local drained_vals = math.min(card.ability.extra.chip_mod, context.other_card.base.nominal - context.other_card.ability.nominal_drain - 1)
        if drained_vals > 0 then
          context.other_card.ability.nominal_drain = context.other_card.ability.nominal_drain + drained_vals
        end
        local drain_bonus = math.min(context.other_card.ability.bonus + context.other_card.ability.perma_bonus, card.ability.extra.chip_mod - drained_vals)
        if drain_bonus > 0 then
          context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus - drain_bonus
          drained_vals = drained_vals + drain_bonus
        end
        if drained_vals > 0 then
          card.ability.extra.chips = card.ability.extra.chips + drained_vals
          card.ability.extra.cards_scored = card.ability.extra.cards_scored + drained_vals
          return {
            message = localize('k_eroded_ex'),
            colour = G.C.CHIPS,
            card = context.other_card,
            extra = { func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')}) end },
          }
        end
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        if card.ability.extra.cards_scored >=100 then
          card.ability.extra.cards_scored = 0
          G.E_MANAGER:add_event(Event({
          func = (function()
              add_tag(Tag('tag_negative'))
              play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
              play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
              return true
          end)
          }))
        end
        return {
          message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}},
          colour = G.C.CHIPS,
          chip_mod = card.ability.extra.chips,
        }
      end
    end
  end,
}

return {
  name = "Gem's Flutter Mane",
  enabled = Gem_config.Flutter_Mane or false,
  list = { flutter_mane }
}




