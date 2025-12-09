function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Iron Bundle 991
local iron_bundle={
  name = "iron_bundle", 
  pos = {x = 0, y = 66}, 
  soul_pos = {x = 1, y = 66}, 
  config = {extra = {money = 8, Xmult = 0.05, total_sell_value = 0}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'deli_gift'}
    if pokermon_config.detailed_tooltips then
      if not center.edition or (center.edition and not center.edition.polychrome) then
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
      end
      info_queue[#info_queue+1] = {key = 'tag_coupon', set = 'Tag'}
      info_queue[#info_queue+1] = G.P_CENTERS.j_gift
    end
    return {vars = {center.ability.extra.money, center.ability.extra.Xmult, 1 + center.ability.extra.total_sell_value * center.ability.extra.Xmult}}
  end,
  rarity = "Gem_future_paradox", 
  cost = 15, 
  stage = "Paradox", 
  ptype = "Water",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
  calculate = function(self, card, context)
  if context.before then
    local gift = pseudorandom(pseudoseed('delibird'))
    if gift > .65 then
      local earned = ease_poke_dollars(card, "iron_bundle", card.ability.extra.money, true)
      return {
          dollars = earned
      }
    elseif gift > .35 then
      --create item
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, nil)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
      end
    elseif gift > .15 then
      --create coupon tag
      G.E_MANAGER:add_event(Event({
        func = (function()
            add_tag(Tag('tag_coupon'))
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return true
        end)
      }))
    else
      --create polychrome gift card
      if #G.jokers.cards < G.jokers.config.card_limit then
        local temp_card = {set = "Joker", area = G.jokers, key = "j_gift", no_edition = true}
        local new_card = SMODS.create_card(temp_card)
        local edition = {polychrome = true}
        new_card:set_edition(edition, true)
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
      end
    end
    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_gift_ex'), colour = G.C.GREEN})
  end  
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = {1 + card.ability.extra.total_sell_value * card.ability.extra.Xmult}}, 
          colour = G.C.MULT,
          Xmult_mod = 1 + card.ability.extra.total_sell_value * card.ability.extra.Xmult, 
          card = card
        }
      end
    end
  end,
  update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN then
      local sell_cost = 0
      for i = 1, #G.jokers.cards do
          if (G.jokers.cards[i].area and G.jokers.cards[i].area == G.jokers) then
              sell_cost = sell_cost + G.jokers.cards[i].sell_cost
          end
      end
      card.ability.extra.total_sell_value = sell_cost
    end
  end
}

return {
  name = "Gem's Iron Bundle",
  enabled = Gem_config.Iron_Bundle or false,
  list = { iron_bundle }
}




