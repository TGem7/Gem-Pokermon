local function find_target(key)
  return pokermon.find_leftmost_or_highlighted(function(joker) return joker.config.center_key == key and not joker.debuff end)
end

local berrysweet = {
  name = "berrysweet",
  key = "berrysweet",
  set = "poke_item",
  pos = {x = 1, y = 0},
  atlas = "Gem_sweets",
  artist = "Emma",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_target("j_Gem_alcremie") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    pokermon.evolve(find_target("j_Gem_alcremie"), "j_Gem_alcremie_berry")
  end,
  in_pool = function(self)
    return false
  end
}

local lovesweet = {
  name = "lovesweet",
  key = "lovesweet",
  set = "poke_item",
  pos = {x = 0, y = 0},
  atlas = "Gem_sweets",
  artist = "Emma",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_target("j_Gem_alcremie") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    pokermon.evolve(find_target("j_Gem_alcremie"), "j_Gem_alcremie_love")
  end,
  in_pool = function(self)
    return false
  end
}

local starsweet = {
  name = "starsweet",
  key = "starsweet",
  set = "poke_item",
  pos = {x = 4, y = 0},
  atlas = "Gem_sweets",
  artist = "Emma",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_target("j_Gem_alcremie") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    pokermon.evolve(find_target("j_Gem_alcremie"), "j_Gem_alcremie_star")
  end,
  in_pool = function(self)
    return false
  end
}

local cloversweet = {
  name = "cloversweet",
  key = "cloversweet",
  set = "poke_item",
  pos = {x = 2, y = 0},
  atlas = "Gem_sweets",
  artist = "Emma",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_target("j_Gem_alcremie") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    pokermon.evolve(find_target("j_Gem_alcremie"), "j_Gem_alcremie_clover")
  end,
  in_pool = function(self)
    return false
  end
}

local flowersweet = {
  name = "flowersweet",
  key = "flowersweet",
  set = "poke_item",
  pos = {x = 3, y = 0},
  atlas = "Gem_sweets",
  artist = "Emma",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_target("j_Gem_alcremie") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    pokermon.evolve(find_target("j_Gem_alcremie"), "j_Gem_alcremie_flower")
  end,
  in_pool = function(self)
    return false
  end
}

local ribbonsweet = {
  name = "ribbonsweet",
  key = "ribbonsweet",
  set = "poke_item",
  pos = {x = 5, y = 0},
  atlas = "Gem_sweets",
  artist = "Emma",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_target("j_Gem_alcremie") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    pokermon.evolve(find_target("j_Gem_alcremie"), "j_Gem_alcremie_ribbon")
  end,
  in_pool = function(self)
    return false
  end
}

list = { berrysweet, lovesweet, starsweet, cloversweet, flowersweet, ribbonsweet }

return {
  name = "Gem's Items",
  list = list,
}
