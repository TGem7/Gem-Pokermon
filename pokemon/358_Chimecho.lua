function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

local chingling={
  name = "chingling",
  pos = PokemonSprites["chingling"].base.pos,
  config = {extra = {Xmult_minus = 0.75, rounds = 2,}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = {set = 'Other', key = 'baby'}
      info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
      info_queue[#info_queue+1] = G.P_CENTERS.c_justice
    end
    return {vars = {center.ability.extra.Xmult_minus, center.ability.extra.rounds}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Baby",
  ptype = "Psychic",
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
      local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_justice')
      local edition = {negative = true}
      _card:set_edition(edition, true)
      _card:add_to_deck()
      G.consumeables:emplace(_card)
    end
    return level_evo(self, card, context, "j_Gem_chimecho")
  end
}

-- Chimecho 358
local chimecho = {
  name = "chimecho",
  pos = PokemonSprites["chimecho"].base.pos,
  config = {extra = {num = 1, dem = 4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_glass
    end
    local num, dem = SMODS.get_probability_vars(center, center.ability.extra.num, center.ability.extra.dem, 'alcremie')
    return {vars = {num, dem}}
  end,
  rarity = 'poke_safari',
 enhancement_gate = 'm_glass',
  cost = 8,
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
        local more
        if pseudorandom('chimecho') < .50 then
          more = 0
        else
          more = 1
        end
    -- Earn give tarots or items when glass cards score
    if context.individual and not context.end_of_round and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_glass') and SMODS.pseudorandom_probability(card, 'chimecho', card.ability.extra.num, card.ability.extra.dem, 'chimecho') then
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        if more == 0 then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          return {
            extra = {focus = card, message = localize('k_plus_tarot'), colour = G.C.PURPLE, func = function()
              G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                  local card_type = 'Tarot'
                  local _card = create_card(card_type,G.consumeables, nil, nil, nil, nil, nil, 'sup')
                  _card:add_to_deck()
                  G.consumeables:emplace(_card)
                  G.GAME.consumeable_buffer = 0
                  return true
                end
              }))
            end},
          }
        else
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          return {
            extra = {focus = card, message = localize('poke_plus_pokeitem'), colour = G.C.ITEM, func = function()
              G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                  local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, nil)
                  _card:add_to_deck()
                  G.consumeables:emplace(_card)
                  G.GAME.consumeable_buffer = 0
                  return true
                end
              }))
            end},
          }
        end
      end
    end
  end,
}

return {
  name = "Gem's Chimecho",
  enabled = Gem_config.Chimecho or false,
  list = {chingling, chimecho}
}

