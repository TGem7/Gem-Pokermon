-- Trapinch 328
local trapinch = {
  name = "trapinch",
  pos = PokemonSprites["trapinch"].base.pos,
  config = { extra = { mult_loss = 5, mult = 25, chip_mod_minus = 1, suit = "Diamonds", rounds = 4 } },
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_loss, center.ability.extra.chip_mod_minus, localize(center.ability.extra.suit, 'suits_singular'), center.ability.extra.rounds}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  designer = "JoJokerPlays",
  gen = 3,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
                card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_loss
                return {
                    message = localize { type = 'variable', key = 'a_mult_minus', vars = { card.ability.extra.mult_loss } },
                    colour = G.C.MULT
                }
            end
    if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then

      local drained_chips = pokermon.drain_chips(context.other_card, card.ability.extra.chip_mod_minus)
      if drained_chips > 0 then
        return {
          message = localize('k_eroded_ex'),
          colour = G.C.CHIPS,
        }
      end
    end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
      return pokermon.level_evo(self, card, context, "j_Gem_vibrava")
    end,
}

-- Vibrava 329
local vibrava = {
  name = "vibrava",
  pos = PokemonSprites["vibrava"].base.pos,
  config = { extra = { mult = 5, chip_mod_minus = 1, suit = "Diamonds", chips = 0, chip_mod = 5 }, evo_rqmt = 50 },
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult, center.ability.extra.chip_mod_minus, localize(center.ability.extra.suit, 'suits_singular'), center.ability.extra.chips, center.ability.extra.chip_mod}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  designer = "JoJokerPlays",
  gen = 3,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then

      local drained_chips = pokermon.drain_chips(context.other_card, card.ability.extra.chip_mod_minus)
      if drained_chips > 0 then
        return {
          message = localize('k_eroded_ex'),
          colour = G.C.CHIPS,
        }
      end
    end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    if context.individual and context.cardarea == G.play then
      local total_chips = pokermon.total_chips(context.other_card)
      if total_chips < 2 and not context.blueprint then
      SMODS.scale_card(card, {
        ref_value = 'chips',
        scalar_value = 'chip_mod',
        message_colour = G.C.CHIPS,
      })
      end
    end      
    return pokermon.scaling_evo(self, card, context, "j_Gem_flygon", card.ability.extra.chips, self.config.evo_rqmt)
    end,
}

-- Flygon 330
local flygon = {
  name = "flygon",
  pos = PokemonSprites["flygon"].base.pos,
  config = { extra = { chip_mod_minus = 1, suit = "Diamonds", chips = 0, chip_mod = 5, Xmult = 1, Xmult_mod = 0.02 }, evo_rqmt = 100 },
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.chip_mod_minus, localize(center.ability.extra.suit, 'suits_singular'), 
    center.ability.extra.chips, center.ability.extra.chip_mod, center.ability.extra.Xmult, center.ability.extra.Xmult_mod}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  designer = "JoJokerPlays",
  gen = 3,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then

      local drained_chips = pokermon.drain_chips(context.other_card, card.ability.extra.chip_mod_minus)
      if drained_chips > 0 then
        return {
          message = localize('k_eroded_ex'),
          colour = G.C.CHIPS,
        }
      end
    end

    if context.individual and context.cardarea == G.play then
      local total_chips = pokermon.total_chips(context.other_card)
      if total_chips < 2 and not context.blueprint then
        SMODS.scale_card(card, {
          ref_value = 'chips',
          scalar_value = 'chip_mod',
          message_colour = G.C.CHIPS,
        })
      SMODS.scale_card(card, {
        ref_value = 'Xmult',
        scalar_value = 'Xmult_mod',
        message_colour = G.C.XMULT,
      })
      end
    end    
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                Xmult = card.ability.extra.Xmult
            }
        end  
    end,
}

return {
  config_key = "Trapinch",
  list = {trapinch, vibrava, flygon}
}







