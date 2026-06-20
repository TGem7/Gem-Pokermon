

-- Mega Sceptile 254
local mega_sceptile={
  name = "mega_sceptile",
  Gem_inject_prefix = "poke",
  pos = {x = 0, y = 4},
  soul_pos = {x = 1, y = 4},
  config = {extra = {money_mod = 3, money_earned = 0, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}, h_size = 1, odds = 2}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local card_vars = {center.ability.extra.money_mod, center.ability.extra.money_earned,
                       center.ability.extra.money_mod + ((pokermon.find_cards_by_ptype(center, "Grass") + pokermon.find_cards_by_ptype(center, "Dragon")) * center.ability.extra.money_mod)}
    pokermon.add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Grass",
  atlas = "AtlasJokersBasicGen03",
  gen = 3,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff then
      for i=1, #card.ability.extra.targets do
        if context.other_card:get_id() == card.ability.extra.targets[i].id then
            local earned = pokermon.ease_poke_dollars(card, "mega_sceptile", card.ability.extra.money_mod + ((pokermon.find_cards_by_ptype(card, "Grass") + pokermon.find_cards_by_ptype(card, "Dragon")) * card.ability.extra.money_mod), true) 
            card.ability.extra.money_earned = card.ability.extra.money_earned + earned
            return {
              dollars = earned,
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
    card.ability.extra.targets = pokermon.get_target_card_ranks("mega_sceptile", 3, card.ability.extra.targets)
  end,
}

local init = function()
  SMODS.Joker:take_ownership('poke_sceptile', { megas = { 'mega_sceptile' } }, true)
  pokermon.add_to_family("sceptile", "mega_sceptile")
end

return {
  config_key = "Treecko",
  init = init,
  list = { mega_sceptile }
}








