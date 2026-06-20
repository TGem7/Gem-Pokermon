

--  Electrike 309
local electrike = {
  name = "electrike",
  pos = PokemonSprites["electrike"].base.pos,
  config = {extra = {targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, rounds = 4}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    end
    local card_vars = {center.ability.extra.rounds}
    pokermon.add_target_cards_to_vars(card_vars, center.ability.extra.targets)
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
    if context.individual and not context.end_of_round and context.cardarea == G.play and not SMODS.has_enhancement(context.other_card, 'm_gold') then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
          context.other_card:set_ability('m_gold', nil, true)
          return { card = context.other_card }
        end
      end
    end
    return pokermon.level_evo(self, card, context, "j_Gem_manectric")
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      self:set_nature(card)
    end
  end,
  set_nature = function(self,card)
    card.ability.extra.targets = pokermon.get_target_card_ranks("electrike", 3, card.ability.extra.targets)
  end,
}

--  Manectric 310
local manectric = {
  name = "manectric",
  pos = PokemonSprites["manectric"].base.pos,
  config = {extra = {money_mod = 2, money_increase = 1, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    end
    local card_vars = {center.ability.extra.money_mod, center.ability.extra.money_increase}
    pokermon.add_target_cards_to_vars(card_vars, center.ability.extra.targets)
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
    if context.individual and not context.end_of_round and context.cardarea == G.play then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
          if SMODS.has_enhancement(context.other_card, 'm_gold') then
            local earned = pokermon.ease_poke_dollars(card, "manectric", card.ability.extra.money_mod + (pokermon.find_cards_by_ptype(card, "Lightning") * card.ability.extra.money_increase), true)
            return {
              dollars = earned,
              card = card
            }
          else
            context.other_card:set_ability('m_gold', nil, true)
            return { card = context.other_card }
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
    card.ability.extra.targets = pokermon.get_target_card_ranks("manectric", 3, card.ability.extra.targets)
  end,
   megas = { "mega_manectric" },
}

--  Mega Manectric 310
local mega_manectric = {
  name = "mega_manectric",
  pos = {x = 4, y = 5},
  soul_pos = {x = 5, y = 5},
  config = {extra = {Xmult_multi = 2, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    end
    local card_vars = {center.ability.extra.Xmult_multi}
    pokermon.add_target_cards_to_vars(card_vars, center.ability.extra.targets)
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
              xmult = card.ability.extra.Xmult_multi,
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
    card.ability.extra.targets = pokermon.get_target_card_ranks("mega_manectric", 3, card.ability.extra.targets)
  end,
}

return {
  config_key = "Electrike",
  list = { electrike, manectric, mega_manectric }
}








