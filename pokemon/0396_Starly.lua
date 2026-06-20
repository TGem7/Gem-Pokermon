-- Starly 396
local starly={
  name = "starly",
  pos = PokemonSprites["starly"].base.pos,
  config = {extra = {mult = 0,mult_mod = 1,rounds = 4,rank = "2", id = 2}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.rounds, localize(center.ability.extra.rank or "2", 'ranks')}}
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Colorless",
  atlas = "AtlasJokersBasicNatdex",
  gen = 4,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return 
      {
        mult = card.ability.extra.mult
      }
    end
    if context.hand_drawn and SMODS.drawn_cards and not context.blueprint then
      for i = 1, #SMODS.drawn_cards do
        if SMODS.drawn_cards[i]:get_id() == card.ability.extra.id then
          card.ability.extra.id, card.ability.extra.rank = pokermon.next_owned_rank(card.ability.extra.id, card.ability.extra.rank)

          SMODS.scale_card(card, {
            ref_value = 'mult',
            scalar_value = 'mult_mod',
            message_colour = G.C.MULT
          })
        end
      end
    end
    return pokermon.level_evo(self, card, context, "j_Gem_staravia")
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial and G.playing_cards then
      card.ability.extra.id, card.ability.extra.rank = pokermon.get_lowest_rank(14, "Ace")
    end
  end,
  attributes = {"rank", "mult", "scaling", "round_evo"},
}

local staravia={
  name = "staravia",
  pos = PokemonSprites["staravia"].base.pos,
  config = {extra = {mult = 0,mult_mod = 2,rounds = 4,rank = "2", id = 2}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.rounds, localize(center.ability.extra.rank or "2", 'ranks')}}
  end,
  rarity = 2,
  cost = 6,
  stage = "One",
  ptype = "Colorless",
  atlas = "AtlasJokersBasicNatdex",
  gen = 4,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return 
      {
        mult = card.ability.extra.mult
      }
    end
    if context.hand_drawn and SMODS.drawn_cards and not context.blueprint then
      for i = 1, #SMODS.drawn_cards do
        if SMODS.drawn_cards[i]:get_id() == card.ability.extra.id then
          card.ability.extra.id, card.ability.extra.rank = pokermon.next_owned_rank(card.ability.extra.id, card.ability.extra.rank)

          SMODS.scale_card(card, {
            ref_value = 'mult',
            scalar_value = 'mult_mod',
            message_colour = G.C.MULT
          })
        end
      end
    end
    return pokermon.level_evo(self, card, context, "j_Gem_staraptor")
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial and G.playing_cards then
      card.ability.extra.id, card.ability.extra.rank = pokermon.get_lowest_rank(14, "Ace")
    end
  end,
  attributes = {"rank", "mult", "scaling", "round_evo"},
}

local staraptor={
  name = "staraptor",
  pos = PokemonSprites["staraptor"].base.pos,
  config = {extra = {mult = 0,mult_mod = 3,rank = "2", id = 2, card_threshold = 10, cards_drawn = 0, upgrade = false}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.rounds, localize(center.ability.extra.rank or "2", 'ranks'), center.ability.extra.card_threshold, math.max(0, center.ability.extra.card_threshold - center.ability.extra.cards_drawn), 
                    center.ability.extra.upgrade and "("..localize('k_active_ex')..")" or ''}}
  end,
  rarity = 'poke_safari',
  cost = 8,
  stage = "Two",
  ptype = "Colorless",
  atlas = "AtlasJokersBasicNatdex",
  gen = 4,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before then
     if card.ability.extra.cards_drawn >= 10 then
      if not context.blueprint then
        card.ability.extra.cards_drawn = 0
        G.E_MANAGER:add_event(Event({
          func = function()
            card.ability.extra.upgrade = false
            return true
          end
        }))
      end
      return {
        card = card,
        level_up = true,
        message = localize('k_level_up_ex')
      }
    end
    end
    if context.joker_main then
      return 
      {
        mult = card.ability.extra.mult
      }
    end
    if context.hand_drawn and SMODS.drawn_cards and not context.blueprint then
      for i = 1, #SMODS.drawn_cards do
        if SMODS.drawn_cards[i]:get_id() == card.ability.extra.id then
          card.ability.extra.id, card.ability.extra.rank = pokermon.next_owned_rank(card.ability.extra.id, card.ability.extra.rank)
          card.ability.extra.cards_drawn = card.ability.extra.cards_drawn + 1
          SMODS.scale_card(card, {
            ref_value = 'mult',
            scalar_value = 'mult_mod',
            message_colour = G.C.MULT
          })
        end
      end
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial and G.playing_cards then
      card.ability.extra.id, card.ability.extra.rank = pokermon.get_lowest_rank(14, "Ace")
    end
  end,
  attributes = {"rank", "mult", "scaling", "round_evo"},
}

return {
  config_key = 'Starly',
  list = { starly, staravia, staraptor },
}

