function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
--  Morelull 755
local morelull = {
  name = "morelull",
  pos = PokemonSprites["morelull"].base.pos,
  config = {extra = {money_mod = 1, consumables_used = 0}, evo_rqmt = 15},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local consumables_left = math.max(0, self.config.evo_rqmt - center.ability.extra.consumables_used)
    return {vars = {center.ability.extra.money_mod, consumables_left}}
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Fairy",
  atlas = "AtlasJokersBasicNatdex",
  gen = 7,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
  -- Held Consumables gain $1 sell value whenever a consumable is used
    if context.using_consumeable then
      card.ability.extra.consumables_used = card.ability.extra.consumables_used + 1
      card:set_cost()
      for k, v in ipairs(G.consumeables.cards) do
        v.ability.extra_value = (v.ability.extra_value or 0) + card.ability.extra.money_mod
        v:set_cost()
        card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize('k_val_up')})
      end
    end
    return scaling_evo(self, card, context, "j_Gem_shiinotic", card.ability.extra.consumables_used, self.config.evo_rqmt)
  end,
}

--  Shiinotic 756
local shiinotic = {
  name = "shiinotic",
  pos = PokemonSprites["shiinotic"].base.pos,
  config = {extra = {money_mod = 2, mult = 0, card_limit = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local total = 0
    for k, v in ipairs(G.consumeables.cards) do
      total = total + v.sell_cost 
    end
    return {vars = {center.ability.extra.money_mod, total, center.ability.extra.card_limit}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fairy",
  atlas = "AtlasJokersBasicNatdex",
  gen = 7,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
  -- Held Consumables gain $1 sell value whenever a consumable is used
    if context.using_consumeable then
      card:set_cost()
      for k, v in ipairs(G.consumeables.cards) do
        v.ability.extra_value = (v.ability.extra_value or 0) + card.ability.extra.money_mod
        v:set_cost()
        card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize('k_val_up')})
      end
    end
-- Add up total consumable sell value
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local total = 0
        for k, v in ipairs(G.consumeables.cards) do
          total = total + v.sell_cost 
        end
  -- Give mult equal to total sell value of your consumables
        if total > 0 then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult + total}}, 
            colour = G.C.MULT,
            mult_mod = total
          }
        end
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.card_limit
      return true end }))
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.card_limit
      return true end }))
  end, 
}


return {
  name = "Gem's Morelull",
  enabled = Gem_config.Morelull or false,
  list = {morelull, shiinotic}
}

