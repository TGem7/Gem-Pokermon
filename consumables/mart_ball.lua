local fastball = {
  name = "fastball",
  key = "fastball",
  set = "poke_item",
  config = {extra = {count = 1, round_on_add = 1, rare = 4, uncommon = 2, common = 1}},
  loc_vars = function(self, info_queue, center)
   info_queue[#info_queue+1] = {set = 'Other', key = 'fast'}
   local skips = G.GAME.skips
      if G.GAME.skips >= center.ability.extra.rare then
      key = self.key.."_max"      
    elseif G.GAME.skips < center.ability.extra.common and G.GAME.skips > 0 then
      key = self.key.."_start"
    else 
      key = self.key.."_deck"
    end
    return {vars = {skips}}
  end,
  pos = { x = 0, y = 0 },
  atlas = "Gem_fast",
  cost = 3,
  pokeball = true,
  unlocked = true,
  discovered = true,
  in_pool = function(self)
    return G.GAME.skips > 0
  end,
  can_use = function(self, card)
    if (#G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers) and G.GAME.skips > 0 then
        return true
    else
        return false
    end
  end,
  calculate = function(self, card, context)
    local count = 0
    update = function(self, card, dt)
      if G.STAGE == G.STAGES.RUN then
        count = G.GAME.skips * 1
      end
    end
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
      play_sound('timpani')
      local _card = nil
      if G.GAME.skips < self.config.extra.uncommon then
        _card = create_random_poke_joker("fastball", "Basic", nil, nil, nil)
      elseif self.config.extra.uncommon <= G.GAME.skips and G.GAME.skips < self.config.extra.rare then
        _card = create_random_poke_joker("fastball", "One", nil, nil, nil)
      elseif self.config.extra.rare <= G.GAME.skips then
        _card = create_random_poke_joker("fastball ", "Two", nil, nil, nil)
      end
      _card:add_to_deck()
      G.jokers:emplace(_card)
      return true end }))
    delay(0.6)
  end,
}

list = { fastball }

return {
  name = "Gem's Ball",
  list = list,
}