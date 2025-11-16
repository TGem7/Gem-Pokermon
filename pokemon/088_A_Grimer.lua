function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
--  Alolan Grimer 088
local alolan_grimer = {
  name = "alolan_grimer",
  pos = {x = 14, y = 3},
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {}}
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Dark",
  atlas = "AtlasJokersBasicGen01",
  gen = 1,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
        local more
        if pseudorandom('grime') < .50 then
          more = 0
        else
          more = 1
        end
        if context.first_hand_drawn then
          if more == 0 then
               local _card = SMODS.add_card { set = "Base", seal = SMODS.poll_seal({ guaranteed = true, type_key = 'vremade_certificate_seal' }) }
                G.GAME.blind:debuff_card(_card)
                G.hand:sort()
                SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
          else
                local _card = SMODS.add_card { set = "Base", enhancement = SMODS.poll_enhancement({options = {"m_bonus", "m_mult", "m_wild", "m_glass", "m_steel", "m_gold", "m_lucky"}, guaranteed = true}) }
                G.GAME.blind:debuff_card(_card)
                G.hand:sort()
                SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
          end
        end
    end,
}

--  Alolan Muk 089
local alolan_muk = {
  name = "alolan_muk",
  pos = {x = 0, y = 4},
  config = {extra = {num = 1, dem = 4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local num, dem = SMODS.get_probability_vars(center, center.ability.extra.num, center.ability.extra.dem, 'alolan_grimer')
    return {vars = {num, dem}}
  end,
  rarity = 3,
  cost = 8,
  stage = "One",
  ptype = "Dark",
  atlas = "AtlasJokersBasicGen01",
  gen = 1,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
        local more
          if pseudorandom('grime') < .33 then
            more = 0
          elseif pseudorandom('grime') < .67 then
            more = 1
          else
            more = 2
          end
        if context.first_hand_drawn then
          if SMODS.pseudorandom_probability(card, 'alolan_grimer', card.ability.extra.num, card.ability.extra.dem, 'alolan_grimer') then
               local _card = SMODS.add_card { set = "Base", enhancement = SMODS.poll_enhancement({options = {"m_bonus", "m_mult", "m_wild", "m_glass", "m_steel", "m_gold", "m_lucky"}, guaranteed = true}), seal = SMODS.poll_seal({ guaranteed = true, type_key = 'vremade_certificate_seal' }), edition = poll_edition('aura', nil, true, true) }
                G.GAME.blind:debuff_card(_card)
                G.hand:sort()
                SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
          elseif more == 0 then
               local _card = SMODS.add_card { set = "Base", seal = SMODS.poll_seal({ guaranteed = true, type_key = 'vremade_certificate_seal' }) }
                G.GAME.blind:debuff_card(_card)
                G.hand:sort()
                SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
          elseif more == 1 then
                local _card = SMODS.add_card { set = "Base", enhancement = SMODS.poll_enhancement({options = {"m_bonus", "m_mult", "m_wild", "m_glass", "m_steel", "m_gold", "m_lucky"}, guaranteed = true}) }
                G.GAME.blind:debuff_card(_card)
                G.hand:sort()
                SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
          else 
                local _card = SMODS.add_card { set = "Base", edition = poll_edition('aura', nil, true, true) }
                G.GAME.blind:debuff_card(_card)
                G.hand:sort()
                SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
          end
        end
    end,
}

return {
  name = "Gem's Alolan Grimer",
  enabled = Gem_config.A_Grimer or false,
  list = {alolan_grimer, alolan_muk}
}

