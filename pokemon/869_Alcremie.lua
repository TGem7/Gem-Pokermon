function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function Gem_setup_drag_evolve(self, card, forced_key)
  if not forced_key then return end

  -- This is distance in game units, not pixels
  -- for reference, jokers are roughly 2.05 game units wide
  local shake_rqmt = self.config.shake_rqmt
  local is_evolving = false

  local card_drag_orig = card.drag
  card.drag = function(self, offset)
    card_drag_orig(self, offset)
    -- Card variables become nil when evolving so stop checking shakes after we evolve
    if not is_evolving then
      -- Set a starting point if we've just started dragging
      if card.ability.extra.prev_drag_x == 0 then card.ability.extra.prev_drag_x = self.T.x end
      if card.ability.extra.prev_drag_y == 0 then card.ability.extra.prev_drag_y = self.T.y end

      local x1, x2 = card.ability.extra.prev_drag_x, self.T.x
      local y1, y2 = card.ability.extra.prev_drag_y, self.T.y
      local distance = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)

      card.ability.extra.prev_drag_x = self.T.x
      card.ability.extra.prev_drag_y = self.T.y
      card.ability.extra.dist_dragged = distance + card.ability.extra.dist_dragged

      if card.ability.extra.dist_dragged > shake_rqmt then
        is_evolving = true
        poke_evolve(card, forced_key)
      end
    end
  end

  local card_stop_drag_orig = card.stop_drag
  card.stop_drag = function(self)
    card_stop_drag_orig(self)
    card.ability.extra.prev_drag_x = 0
    card.ability.extra.prev_drag_y = 0
    card.ability.extra.dist_dragged = 0
  end
end

-- Milcery 868
local milcery = {
  name = "milcery",
  pos = PokemonSprites["milcery"].base.pos,
  config = { extra = { prev_drag_x = 0, prev_drag_y = 0, dist_dragged = 0 }, shake_rqmt = 25 },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.money}}
  end,
  designer = "Emma",
  rarity = 3,
  cost = 8,
  stage = "Basic",
  ptype = "Fairy",
  atlas = "AtlasJokersBasicNatdex",
  gen = 8,
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = true,
  add_to_deck = function(self, card, card_table, other_card)
    Gem_setup_drag_evolve(self, card, "j_Gem_alcremie")
  end,
  load = function(self, card, card_table, other_card)
    Gem_setup_drag_evolve(self, card, "j_Gem_alcremie")
  end
}


--  Alcremie 869
local alcremie = {
  name = "alcremie",
  pos = {x = 10, y = 0},
  config = {extra = {money = 4, num = 1, dem = 10}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local num, dem = SMODS.get_probability_vars(center, center.ability.extra.num, center.ability.extra.dem, 'alcremie')
    return {vars = {center.ability.extra.money, num, dem}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fairy",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.reroll_shop and not context.blueprint then
      if SMODS.pseudorandom_probability(card, 'alcremie', card.ability.extra.num, card.ability.extra.dem, 'alcremie') then
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if pseudorandom('alcremie') < .17 then
              set = "Item"
              message = "poke_plus_pokeitem"
              colour = G.ARGS.LOC_COLOURS.item
              conname = "c_Gem_berrysweet"
            elseif pseudorandom('alcremie') > .17 and pseudorandom('alcremie') < .34 then
              set = "Item"
              message = "poke_plus_pokeitem"
              colour = G.ARGS.LOC_COLOURS.item
              conname = "c_Gem_lovesweet"
            elseif pseudorandom('alcremie') > .34 and pseudorandom('alcremie') < .51 then
              set = "Item"
              message = "poke_plus_pokeitem"
              colour = G.ARGS.LOC_COLOURS.item
              conname = "c_Gem_starsweet"
            elseif pseudorandom('alcremie') > .51 and pseudorandom('alcremie') < .68 then
              set = "Item"
              message = "poke_plus_pokeitem"
              colour = G.ARGS.LOC_COLOURS.item
              conname = "c_Gem_cloversweet"
            elseif pseudorandom('alcremie') > .68 and pseudorandom('alcremie') < .85 then
              set = "Item"
              message = "poke_plus_pokeitem"
              colour = G.ARGS.LOC_COLOURS.item
              conname = "c_Gem_flowersweet"
            else
              set = "Item"
              message = "poke_plus_pokeitem"
              colour = G.ARGS.LOC_COLOURS.item
              conname = "c_Gem_ribbonsweet"
            end
            local _card = create_card(set, G.consumeables, nil, nil, nil, nil, conname)
            _card:add_to_deck()
            G.consumeables:emplace(_card)
            card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize(message), colour = colour})
        end
      end
    end
  end,
  calc_dollar_bonus = function(self, card)
    return ease_poke_dollars(card, "alcremie", card.ability.extra.money, true)
  end
}
local alcremie_berry = {
  name = "alcremie_berry",
  pos = {x = 12, y = 1},
  config = {extra = {rounds = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fairy",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  aux_poke = true,
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand and not context.blueprint then
      if context.before then
        card.ability.extra.upgrade = false
        return {
          card = card,
          level_up = true,
          message = localize('k_level_up_ex')
        }
      end
    end
    return level_evo(self, card, context, "j_Gem_alcremie")
  end,
}
local alcremie_love = {
  name = "alcremie_love", 
  pos = {x = 14, y = 2},
  config = {extra = {rounds = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fairy",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  aux_poke = true,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      local forced_key = matching_energy(G.jokers.cards[1]);
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
          trigger = 'before',
          delay = 0.0,
          func = (function()
                  local card = create_card('Energy', G.consumeables, nil, nil, nil, nil, forced_key)
                  card:add_to_deck()
                  G.consumeables:emplace(card)
                  G.GAME.consumeable_buffer = 0
              return true
          end)}))
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("poke_plus_energy"), colour = G.ARGS.LOC_COLOURS["pink"]})
    end
    return level_evo(self, card, context, "j_Gem_alcremie")
  end,
}

local alcremie_star = {
  name = "alcremie_star",
  pos = {x = 0, y = 4},
  config = {extra = {money_mod = 3, money_earned = 0, rounds = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.money_mod, center.ability.extra.money_earned, center.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fairy",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  aux_poke = true,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before then
      G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money_mod
        local earned = ease_poke_dollars(card, "alcremie_clover", math.min(14, card.ability.extra.money_mod), true) 
        card.ability.extra.money_earned = card.ability.extra.money_earned + earned
        return {
          dollars = earned,
          card = card
        }
    end
    return level_evo(self, card, context, "j_Gem_alcremie")
  end
}

local alcremie_clover = {
  name = "alcremie_clover", 
  pos = {x = 2, y = 5},
  config = {extra = {num = 1, dem = 5, money_mod = 3, money_earned = 0, rounds = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.num, center.ability.extra.dem, center.ability.extra.money_mod, center.ability.extra.money_earned, center.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fairy",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  aux_poke = true,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before then
      card.ability.extra.num = card.ability.extra.num + 1
    end
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      if (not context.other_card.debuff) and SMODS.pseudorandom_probability(card, 'alcremie_clover', card.ability.extra.num, card.ability.extra.dem, 'alcremie_clover') then
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money_mod
            local earned = ease_poke_dollars(card, "alcremie_clover", math.min(14, card.ability.extra.money_mod), true) 
            card.ability.extra.money_earned = card.ability.extra.money_earned + earned
            return {
              dollars = earned,
              card = card
            }
      end
    end
    if context.end_of_round then
      card.ability.extra.num = 1
    end
    return level_evo(self, card, context, "j_Gem_alcremie")
  end
}

local alcremie_flower = {
  name = "alcremie_flower", 
  pos = {x = 4, y = 6},
  config = {extra = {rounds = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fairy",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  aux_poke = true,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        set = "Item"
        message = "poke_plus_pokeitem"
        colour = G.ARGS.LOC_COLOURS.item
        local _card = create_card(set, G.consumeables, nil, nil, nil, nil, nil)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
        card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize(message), colour = colour})
    end
    end
   end
   return level_evo(self, card, context, "j_Gem_alcremie")
 end
}

local alcremie_ribbon = {
  name = "alcremie_ribbon", 
  pos = {x = 6, y = 7},
  config = {extra = {rounds = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fairy",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  aux_poke = true,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        set = "Tarot"
        message = "k_plus_tarot"
        colour = G.C.PURPLE
        local _card = create_card(set, G.consumeables, nil, nil, nil, nil, nil)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
        card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize(message), colour = colour})
    end
    end
   end
   return level_evo(self, card, context, "j_Gem_alcremie")
 end
}

return {
  name = "Gem's Alcremie",
  enabled = Gem_config.Alcremie or false,
  list = {milcery, alcremie, alcremie_berry, alcremie_love, alcremie_star, alcremie_clover, alcremie_flower, alcremie_ribbon}
}

