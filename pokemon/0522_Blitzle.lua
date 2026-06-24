-- Blitzle 522
local blitzle={
  name = "blitzle",
  pos = PokemonSprites["blitzle"].base.pos,
  config = {extra = {mult = 0, mult_mod = 6}, evo_rqmt = 12},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}}
  end,
  rarity = 1, 
  cost = 4, 
  stage = "Basic", 
  ptype = "Lightning",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  blueprint_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult
        }
      end
    end
    return pokermon.scaling_evo(self, card, context, "j_Gem_zebstrika", card.ability.extra.mult, self.config.evo_rqmt)
  end,
  update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN then
      card.ability.extra.mult = G.GAME.skips * card.ability.extra.mult_mod
    end
  end,
  attributes = {"mult", "scaling", "skip"},
}

local zebstrika={
  name = "zebstrika",
  pos = PokemonSprites["zebstrika"].base.pos,
  config = {extra = {mult = 0, mult_mod = 10, count = 0}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = {key = 'tag_skip', set = 'Tag', specific_vars = {5, 5 * G.GAME.skips}}
    end
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.count}}
  end,
  rarity = 'poke_safari', 
  cost = 6, 
  stage = "One", 
  ptype = "Lightning",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  blueprint_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)
      if context.skip_blind then
        if card.ability.extra.count < 1 then
          card.ability.extra.count = card.ability.extra.count + 1
        else
      G.E_MANAGER:add_event(Event({
        func = (function()
            add_tag(Tag('tag_skip'))
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return true
        end)
      }))
          card.ability.extra.count = 0
        end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult
        }
      end
    end
  end,
  update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN then
      card.ability.extra.mult = G.GAME.skips * card.ability.extra.mult_mod
    end
  end,
  attributes = {"mult", "scaling", "skip"},
}
return {
  config_key = "Blitzle",
  list = { blitzle, zebstrika }
}