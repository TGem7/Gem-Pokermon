-- Patrat 504
local patrat={
  name = "patrat",
  pos = PokemonSprites["patrat"].base.pos,
  config = {extra = {scry = 2, money_mod = 1, earned = 0}, evo_rqmt = 8},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    local money_left = math.max(0, self.config.evo_rqmt - center.ability.extra.earned)
    return {vars = { center.ability.extra.scry, center.ability.extra.money_mod, money_left, localize(G.GAME.current_round.bulb1card and G.GAME.current_round.bulb1card.rank or "Ace", 'ranks')}}
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Colorless",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if not context.end_of_round and context.scoring_hand then
      if context.individual and context.cardarea == G.poke_scry_view and context.other_card:get_id() == G.GAME.current_round.bulb1card.id and not context.other_card.debuff then
        if not context.blueprint then
          card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money_mod
        end
        local earned = pokermon.ease_poke_dollars(card, "pat", card.ability.extra.money_mod, true)
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + earned
        return {
          dollars = earned,
          func = function()
            G.E_MANAGER:add_event(Event({
              func = function()
                G.GAME.dollar_buffer = 0
                return true
              end
            }))
          end
        }
      end
    end
    return pokermon.scaling_evo(self, card, context, "j_Gem_watchog", card.ability.extra.earned, self.config.evo_rqmt)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = (G.GAME.poke_scry_amount or 0) + card.ability.extra.scry
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = math.max(0,(G.GAME.poke_scry_amount or 0) - card.ability.extra.scry)
  end,
}

-- Watchog 505
local watchog={
  name = "watchog",
  pos = PokemonSprites["watchog"].base.pos,
  config = {extra = {scry = 4, money_mod = 2, money_mod1 = 2, money_mod2 = 1, earned = 0}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = { center.ability.extra.scry, center.ability.extra.money_mod, localize(G.GAME.current_round.bulb1card and G.GAME.current_round.bulb1card.rank or "Ace", 'ranks'), center.ability.extra.money_mod2}}
  end,
  rarity = "poke_safari",
  cost = 6,
  stage = "One",
  ptype = "Colorless",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if not context.end_of_round and context.scoring_hand then
      if context.individual and context.cardarea == G.poke_scry_view and context.other_card:get_id() == G.GAME.current_round.bulb1card.id and not context.other_card.debuff then
        if not context.blueprint then
          card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money_mod
        end
        local earned = pokermon.ease_poke_dollars(card, "pat", card.ability.extra.money_mod, true)
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + earned
        return {
          dollars = earned,
          func = function()
            G.E_MANAGER:add_event(Event({
              func = function()
                G.GAME.dollar_buffer = 0
                return true
              end
            }))
          end
        }
      end
    end
    if context.after and card.ability.extra.earned > 0 then
        card.ability.extra.money_mod = card.ability.extra.money_mod + card.ability.extra.money_mod2
        card.ability.extra.earned = 0
    end
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
      if card.ability.extra.money_mod > card.ability.extra.money_mod1 then
                card.ability.extra.money_mod = card.ability.extra.money_mod1
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = (G.GAME.poke_scry_amount or 0) + card.ability.extra.scry
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = math.max(0,(G.GAME.poke_scry_amount or 0) - card.ability.extra.scry)
  end,
}

return {
  config_key = 'Patrat',
  list = { patrat, watchog },
}


