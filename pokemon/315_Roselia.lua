function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
local budew={
  name = "budew",
  pos = PokemonSprites["budew"].base.pos,
  config = {extra = {Xmult_minus = 0.5, rounds = 2}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = {set = 'Other', key = 'baby'}
      info_queue[#info_queue+1] = G.P_CENTERS.m_poke_flower
    end
    return {vars = {center.ability.extra.Xmult_minus, center.ability.extra.rounds}}
  end,
  rarity = 2,
  cost = 4,
  stage = "Baby",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  gen = 4,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        faint_baby_poke(self, card, context)
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult_minus}}, 
          colour = G.C.XMULT,
          Xmult_mod = card.ability.extra.Xmult_minus
        }
      end
    end
    if context.end_of_round and not context.individual and not context.repetition and not card.debuff then
      local flower_card = SMODS.add_card { set = "Base", enhancement = "m_poke_flower", area = G.deck }
      return {
         colour = G.C.SECONDARY_SET.Enhanced,
         level_evo(self, card, context, "j_Gem_roselia"),
         func = function()
           SMODS.calculate_context({ playing_card_added = true, cards = { flower_card } })
         end
         }
    end
  end
}

local roselia={
  name = "roselia",
  pos = PokemonSprites["roselia"].base.pos,
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_poke_flower
      info_queue[#info_queue+1] = G.P_CENTERS.c_poke_shinystone
    end
    return {vars = {}}
  end,
  rarity = 3,
  cost = 8,
  enhancement_gate = 'm_poke_flower',
  item_req = "shinystone",
  stage = "Basic",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn and not context.blueprint then
      local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end
    if context.before and context.cardarea == G.jokers and not context.blueprint then
      if G.GAME.current_round.hands_played == 0 then
        for k, v in ipairs(context.scoring_hand) do
          if v.config.center == G.P_CENTERS.m_poke_flower and not v.debuff then
            local card = context.scoring_hand[#context.scoring_hand]
            card:set_ability(G.P_CENTERS.m_poke_flower, nil, true)
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up()
                    return true
                end
            }))
          end
        end
      end
    end
    return item_evo(self, card, context, "j_Gem_roserade")
  end
}

local roserade={
  name = "roserade",
  pos = PokemonSprites["roserade"].base.pos,
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_poke_flower
      info_queue[#info_queue+1] = {key = 'red_seal', set = 'Other'}
      info_queue[#info_queue+1] = {key = 'blue_seal', set = 'Other'}
    end
    return {vars = {}}
  end,
  rarity = "poke_safari",
  cost = 10,
  enhancement_gate = 'm_poke_flower',
  stage = "One",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  gen = 4,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn and not context.blueprint then
      local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end
    if context.before and context.cardarea == G.jokers and not context.blueprint then
      if G.GAME.current_round.hands_played == 0 then
        for k, v in ipairs(context.scoring_hand) do
          if v.config.center == G.P_CENTERS.m_poke_flower and not v.debuff then
            local card = context.scoring_hand[#context.scoring_hand]
            card:set_ability(G.P_CENTERS.m_poke_flower, nil, true)
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up()
                    return true
                end
            }))
          end
        end
      end
    end
    if context.cardarea == G.play and context.scoring_hand and context.full_hand and #context.full_hand == 1 then
      for k, v in ipairs(context.scoring_hand) do
        if v.config.center == G.P_CENTERS.m_poke_flower and not v.debuff then
          local target = context.scoring_hand[1]
          local args = {seal = SMODS.poll_seal({options = {'Red', 'Blue'}, guaranteed = true})}
          poke_convert_cards_to(target, args, true, true)
        end
      end
    end
  end
}



if Gem_config.Roselia then
  list = {budew, roselia, roserade}
else list = {}
end


return {name = "Roselia",
list = list
}
