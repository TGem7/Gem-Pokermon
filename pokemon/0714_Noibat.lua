function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
--  Noibat 714
local noibat = {
  name = "noibat",
  pos = PokemonSprites["noibat"].base.pos,
  config = { extra = { Xmult_mod = 0.5, Xmult = 1 }, evo_rqmt = 3 },
  loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult } }
  end,
  rarity = 3,
  cost = 8,
  stage = "Basic",
  ptype = "Dragon",
  atlas = "AtlasJokersBasicNatdex",
  gen = 6,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
      if context.setting_blind and not card.getting_sliced and not context.blueprint then
          -- See note about SMODS Scaling Manipulation on the wiki
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
          local destructable_jokers = {}
          for i = 1, #G.jokers.cards do
              if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced then
                  destructable_jokers[#destructable_jokers + 1] =
                      G.jokers.cards[i]
              end
          end
          local joker_to_destroy = pseudorandom_element(destructable_jokers, 'Gem_noibat')

          if joker_to_destroy then
              joker_to_destroy.getting_sliced = true
              G.E_MANAGER:add_event(Event({
                  func = function()
                      (context.blueprint_card or card):juice_up(0.8, 0.8)
                      joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                      return true
                  end
              }))
          end
          return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } } }
      end
      if context.joker_main then
          return {
              xmult = card.ability.extra.Xmult,
              scaling_evo(self, card, context, "j_Gem_noivern", card.ability.extra.Xmult, self.config.evo_rqmt)
          }
      end
      return scaling_evo(self, card, context, "j_Gem_noivern", card.ability.extra.Xmult, self.config.evo_rqmt)
  end,
}

--  Noivern 715
local noivern = {
  name = "noivern",
  pos = PokemonSprites["noivern"].base.pos,
  config = { extra = { Xmult_mod = 0.5, Xmult = 3 } },
  loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult } }
  end,
  rarity = 'poke_safari',
  cost = 10,
  stage = "One",
  ptype = "Dragon",
  atlas = "AtlasJokersBasicNatdex",
  gen = 6,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.ending_shop then
      card.ability.extra.selected = false
      local eval = function() return not card.ability.extra.selected end
      juice_card_until(card, eval, true)
    end
    if context.setting_blind and not card.getting_sliced and not context.blueprint then
      local my_pos = nil
      for i = 1, #G.jokers.cards do
          if G.jokers.cards[i] == card then my_pos = i; break end
      end
      if my_pos and G.jokers.cards[my_pos+1] and not card.getting_sliced and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced then 
          local sliced_card = G.jokers.cards[my_pos+1]
          sliced_card.getting_sliced = true
          
          G.GAME.joker_buffer = G.GAME.joker_buffer - 1
          G.E_MANAGER:add_event(Event({func = function()
              G.GAME.joker_buffer = 0
              card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
              card:juice_up(0.8, 0.8)
              sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
              play_sound('slice1', 0.96+math.random()*0.08)
          return true end }))
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_boomburst_ex') } )
      end
      if my_pos and G.jokers.cards[my_pos-1] and not card.getting_sliced and not G.jokers.cards[my_pos-1].ability.eternal and not G.jokers.cards[my_pos-1].getting_sliced then 
          local sliced_cards = G.jokers.cards[my_pos-1]
          sliced_cards.getting_sliced = true
          
          G.GAME.joker_buffer = G.GAME.joker_buffer - 1
          G.E_MANAGER:add_event(Event({func = function()
              G.GAME.joker_buffer = 0
              card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
              card:juice_up(0.8, 0.8)
              sliced_cards:start_dissolve({HEX("57ecab")}, nil, 1.6)
              play_sound('slice1', 0.96+math.random()*0.08)
          return true end }))
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_boomburst_ex') } )
      end
      card.ability.extra.selected = true
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize('poke_boomburst_ex'), 
          colour = G.C.MULT,
          Xmult_mod = card.ability.extra.Xmult
        }
      end
    end
  end,
}

return {
  name = "Gem's Noibat",
  enabled = Gem_config.Noibat or false,
  list = {noibat, noivern}
}

