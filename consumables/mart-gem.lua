local function find_leftmost_or_highlighted(key)
  local target
  if #G.jokers.highlighted == 0 then
    target = SMODS.find_card(key)[1]
  else
    if #G.jokers.highlighted == 1
        and G.jokers.highlighted[1].config.center.key == key
        and not G.jokers.highlighted[1].debuff then
      target = G.jokers.highlighted[1]
    end
  end
  return target
end

local berrysweet = {
  name = "berrysweet",
  key = "berrysweet",
  set = "Item",
  pos = {x = 1, y = 0},
  atlas = "Gem_sweets",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_leftmost_or_highlighted("j_Gem_alcremie") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    poke_evolve(find_leftmost_or_highlighted("j_Gem_alcremie"), "j_Gem_alcremie_berry")
  end,
  in_pool = function(self)
    return false
  end
}

local lovesweet = {
  name = "lovesweet",
  key = "lovesweet",
  set = "Item",
  pos = {x = 1, y = 0},
  atlas = "Gem_sweets",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_leftmost_or_highlighted("j_Gem_alcremie") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    poke_evolve(find_leftmost_or_highlighted("j_Gem_alcremie"), "j_Gem_alcremie_love")
  end,
  in_pool = function(self)
    return false
  end
}

local starsweet = {
  name = "starsweet",
  key = "starsweet",
  set = "Item",
  pos = {x = 2, y = 0},
  atlas = "Gem_sweets",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_leftmost_or_highlighted("j_Gem_alcremie") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    poke_evolve(find_leftmost_or_highlighted("j_Gem_alcremie"), "j_Gem_alcremie_star")
  end,
  in_pool = function(self)
    return false
  end
}

local cloversweet = {
  name = "cloversweet",
  key = "cloversweet",
  set = "Item",
  pos = {x = 3, y = 0},
  atlas = "Gem_sweets",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_leftmost_or_highlighted("j_Gem_alcremie") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    poke_evolve(find_leftmost_or_highlighted("j_Gem_alcremie"), "j_Gem_alcremie_clover")
  end,
  in_pool = function(self)
    return false
  end
}

local flowersweet = {
  name = "flowersweet",
  key = "flowersweet",
  set = "Item",
  pos = {x = 4, y = 0},
  atlas = "Gem_sweets",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_leftmost_or_highlighted("j_Gem_alcremie") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    poke_evolve(find_leftmost_or_highlighted("j_Gem_alcremie"), "j_Gem_alcremie_flower")
  end,
  in_pool = function(self)
    return false
  end
}

local ribbonsweet = {
  name = "ribbonsweet",
  key = "ribbonsweet",
  set = "Item",
  pos = {x = 5, y = 0},
  atlas = "Gem_sweets",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return find_leftmost_or_highlighted("j_Gem_alcremie") ~= nil
  end,
  use = function(self, card)
    set_spoon_item(card)
    poke_evolve(find_leftmost_or_highlighted("j_Gem_alcremie"), "j_Gem_alcremie_ribbon")
  end,
  in_pool = function(self)
    return false
  end
}

if Gem_config.Alcremie then
  list = {
    berrysweet, lovesweet, starsweet, cloversweet, flowersweet, ribbonsweet
  }
else
  list = {}
end


return {
  name = "Gem's Items",
  list = list
}
