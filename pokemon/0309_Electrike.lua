function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

--  Electrike 309
local electrike = {
  name = "electrike",
  pos = PokemonSprites["electrike"].base.pos,
  config = {extra = {targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, rounds = 4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    end
    local card_vars = {center.ability.extra.rounds}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Lightning",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      for _, scored_card in ipairs(context.scoring_hand) do
        for i=1, #card.ability.extra.targets do
          if scored_card:get_id() == card.ability.extra.targets[i].id then
              scored_card:set_ability('m_gold', nil, true)
              G.E_MANAGER:add_event(Event({
                  func = function()
                      scored_card:juice_up()
                      return true
                  end
              }))
          end
        end
      end
    end
    return level_evo(self, card, context, "j_Gem_manectric")
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      self:set_nature(card)
    end
  end,
  set_nature = function(self,card)
    card.ability.extra.targets = get_poke_target_card_ranks("electrike", 3, card.ability.extra.targets)
  end,
}

--  Manectric 310
local manectric = {
  name = "manectric",
  pos = PokemonSprites["manectric"].base.pos,
  config = {extra = {money_mod = 2, money_increase = 1, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    end
    local card_vars = {center.ability.extra.money_mod, center.ability.extra.money_increase}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = 3,
  cost = 8,
  stage = "One",
  ptype = "Lightning",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff and SMODS.has_enhancement(context.other_card, 'm_gold') then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
            local earned = ease_poke_dollars(card, "manectric", card.ability.extra.money_mod + (find_other_poke_or_energy_type(card, "Lightning") * card.ability.extra.money_increase), true)
            return {
              dollars = earned,
              card = card
            }
        end
      end
    end
    if context.before and not context.blueprint then
      for _, scored_card in ipairs(context.scoring_hand) do
        for i=1, #card.ability.extra.targets do
          if scored_card:get_id() == card.ability.extra.targets[i].id then
              scored_card:set_ability('m_gold', nil, true)
              G.E_MANAGER:add_event(Event({
                  func = function()
                      scored_card:juice_up()
                      return true
                  end
              }))
          end
        end
      end
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      self:set_nature(card)
    end
  end,
  set_nature = function(self,card)
    card.ability.extra.targets = get_poke_target_card_ranks("manectric", 3, card.ability.extra.targets)
  end,
   megas = { "mega_manectric" },
}

--  Mega Manectric 310
local mega_manectric = {
  name = "mega_manectric",
  pos = {x = 4, y = 5},
  soul_pos = {x = 5, y = 5},
  config = {extra = {Xmult = 2, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    end
    local card_vars = {center.ability.extra.Xmult}
    add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Lightning",
  atlas = "AtlasJokersBasicGen03",
  gen = 3,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff and SMODS.has_enhancement(context.other_card, 'm_gold') then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
            return {
              Xmult = card.ability.extra.Xmult,
              card = card
            }
        end
      end
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      self:set_nature(card)
    end
  end,
  set_nature = function(self,card)
    card.ability.extra.targets = get_poke_target_card_ranks("mega_manectric", 3, card.ability.extra.targets)
  end,
}

return {
  name = "Gem's Electrike",
  enabled = Gem_config.Electrike or false,
  list = { electrike, manectric, mega_manectric }
}








