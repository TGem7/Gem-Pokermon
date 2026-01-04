function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Koraidon 1007
local koraidon={
  name = "koraidon", 
  pos = {x = 2, y = 67}, 
  soul_pos = {x = 3, y = 67}, 
  config = {extra = {key = nil}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {}}
  end,
  rarity = 4, 
  cost = 15, 
  stage = "Legendary", 
  ptype = "Dragon",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
      apply = function(self, card, val)
        card.ability[self.key] = val
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            time = 0.2,
            func = function()
                energy_increase(card, get_type(card), (energy_max + (G.GAME.energy_plus or 0) +
                    (type(card.ability.extra) == "table" and card.ability.extra.e_limit_up or 0)) - get_total_energy(card), true)
                card:juice_up(1, 0.5)
                return true
            end
        }))
    end,
calculate = function(self, card, context)
-- Create a random Past Paradox joker when boss blind defeated
   if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss and (#G.jokers.cards + G.GAME.joker_buffer) < G.jokers.config.card_limit then
          G.GAME.joker_buffer = G.GAME.joker_buffer + 1
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            G.GAME.joker_buffer = 0
            play_sound('timpani')
            -- if edition is nil, it'll try again for an edition
            local _card = SMODS.create_card({set = "Joker", rarity = "Gem_paradox", area = G.jokers, key = card.ability.extra.key})
            energy_increase(_card, get_type(_card), energy_max + (G.GAME.energy_plus or 0) +
                    (type(card.ability.extra) == "table" and card.ability.extra.e_limit_up or 0) - get_total_energy(_card), true)
            _card:add_to_deck()
            local loc = 1
            for i,jkr in ipairs(G.jokers.cards) do
              if jkr == card then
                loc = i
              end
            end
            if card.edition and card.edition.poke_shiny then
              SMODS.change_booster_limit(-1)
            end
            G.jokers:emplace(_card, loc)
            return true
          end}))
   end
end,
}

return {
  name = "Gem's Koraidon",
  enabled = Gem_config.Koraidon or false,
  list = { koraidon }
}




