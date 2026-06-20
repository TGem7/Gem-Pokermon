local function find_target(key)
  return pokermon.find_leftmost_or_highlighted(function(joker) return joker.config.center_key == key and not joker.debuff end)
end

local scrollofdarkness = {
  name = "scrollofdarkness",
  key = "scrollofdarkness",
  set = "poke_item",
  pos = {x = 0, y = 0},
  atlas = "Gem_placeholder",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_target("j_Gem_kubfu") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    pokermon.evolve(find_target("j_Gem_kubfu"), "j_Gem_urshifu_single_strike")
  end,
  in_pool = function(self)
    return false
  end
}

local scrollofwaters = {
  name = "scrollofwaters",
  key = "scrollofwaters",
  set = "poke_item",
  pos = {x = 0, y = 0},
  atlas = "Gem_placeholder",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_target("j_Gem_kubfu") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    pokermon.evolve(find_target("j_Gem_kubfu"), "j_Gem_urshifu_rapid_strike")
  end,
  in_pool = function(self)
    return false
  end
}

list = { scrollofdarkness, scrollofwaters }


return {
  name = "Gem's Scrolls",
  list = list
}
