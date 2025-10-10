local berrysweet = {
  name = "berrysweet",
  key = "berrysweet",
  set = "Item",
  config = {max_highlighted = 3, min_highlighted = 1},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  pos = {x = 0, y = 0},
  atlas = "Gem_placeholder",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if G.jokers.highlighted and #G.jokers.highlighted == 1 then
        if string.find(G.jokers.highlighted[1].config.center.name,"alcremie") and not (G.jokers.highlighted[1].config.center.name == "alcremie_berry") and not (G.jokers.highlighted[1].config.center.name == "alcremie_love") and not (G.jokers.highlighted[1].config.center.name == "alcremie_star") and not (G.jokers.highlighted[1].config.center.name == "alcremie_clover") and not (G.jokers.highlighted[1].config.center.name == "alcremie_flower") and not (G.jokers.highlighted[1].config.center.name == "alcremie_ribbon") then
          return true
        else
          return false
        end
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"alcremie") and not (poke.config.center.name == "alcremie_berry") and not (poke.config.center.name == "alcremie_love") and not (poke.config.center.name == "alcremie_star") and not (poke.config.center.name == "alcremie_clover") and not (poke.config.center.name == "alcremie_flower") and not (poke.config.center.name == "alcremie_ribbon")and not (poke.debuff)) then
          return true
        else
          return false
        end
      end
    end
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
    if #G.hand.highlighted >= self.config.min_highlighted then
      juice_flip(card)
      local enhance = self.config.enhancement
      for i = 1, #G.hand.highlighted do
        G.hand.highlighted[i]:set_ability(enhance, nil, true)
      end
      juice_flip(card, true)
      poke_unhighlight_cards()
      evo_item_use_total(self, card, area, copier)
    else
      highlighted_evo_item(self, card, area, copier)
    end

    local target = nil
    if G.jokers.highlighted and #G.jokers.highlighted == 1 and 
        (string.find(G.jokers.highlighted[1].config.center.name,"alcremie") and not (G.jokers.highlighted[1].config.center.name == "alcremie_berry") and not (G.jokers.highlighted[1].config.center.name == "alcremie_love")and not (G.jokers.highlighted[1].config.center.name == "alcremie_star")and not (G.jokers.highlighted[1].config.center.name == "alcremie_clover")and not (G.jokers.highlighted[1].config.center.name == "alcremie_flower")and not (G.jokers.highlighted[1].config.center.name == "alcremie_ribbon")) and not (G.jokers.highlighted[1].debuff) then
      target = G.jokers.highlighted[1]
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"alcremie") and not (poke.config.center.name == "alcremie_berry") and not (poke.config.center.name == "alcremie_love") and not (poke.config.center.name == "alcremie_star") and not (poke.config.center.name == "alcremie_clover") and not (poke.config.center.name == "alcremie_flower") and not (poke.config.center.name == "alcremie_ribbon")and not (poke.debuff)) then
          target = poke
          break
        end
      end
    end
    if target then
        poke_evolve(target, "j_Gem_alcremie_berry")
    end
  end,
  in_pool = function(self)
    return false
  end
}

local lovesweet = {
  name = "lovesweet",
  key = "lovesweet",
  set = "Item",
  config = {max_highlighted = 3, min_highlighted = 1},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  pos = {x = 0, y = 0},
  atlas = "Gem_placeholder",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if G.jokers.highlighted and #G.jokers.highlighted == 1 then
        if string.find(G.jokers.highlighted[1].config.center.name,"alcremie") and not (G.jokers.highlighted[1].config.center.name == "alcremie_berry") and not (G.jokers.highlighted[1].config.center.name == "alcremie_love") and not (G.jokers.highlighted[1].config.center.name == "alcremie_star") and not (G.jokers.highlighted[1].config.center.name == "alcremie_clover") and not (G.jokers.highlighted[1].config.center.name == "alcremie_flower") and not (G.jokers.highlighted[1].config.center.name == "alcremie_ribbon") then
          return true
        else
          return false
        end
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"alcremie") and not (poke.config.center.name == "alcremie_berry") and not (poke.config.center.name == "alcremie_love") and not (poke.config.center.name == "alcremie_star") and not (poke.config.center.name == "alcremie_clover") and not (poke.config.center.name == "alcremie_flower") and not (poke.config.center.name == "alcremie_ribbon")and not (poke.debuff)) then
          return true
        else
          return false
        end
      end
    end
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
    if #G.hand.highlighted >= self.config.min_highlighted then
      juice_flip(card)
      local enhance = self.config.enhancement
      for i = 1, #G.hand.highlighted do
        G.hand.highlighted[i]:set_ability(enhance, nil, true)
      end
      juice_flip(card, true)
      poke_unhighlight_cards()
      evo_item_use_total(self, card, area, copier)
    else
      highlighted_evo_item(self, card, area, copier)
    end

    local target = nil
    if G.jokers.highlighted and #G.jokers.highlighted == 1 and 
        (string.find(G.jokers.highlighted[1].config.center.name,"alcremie") and not (G.jokers.highlighted[1].config.center.name == "alcremie_berry") and not (G.jokers.highlighted[1].config.center.name == "alcremie_love")and not (G.jokers.highlighted[1].config.center.name == "alcremie_star")and not (G.jokers.highlighted[1].config.center.name == "alcremie_clover")and not (G.jokers.highlighted[1].config.center.name == "alcremie_flower")and not (G.jokers.highlighted[1].config.center.name == "alcremie_ribbon")) and not (G.jokers.highlighted[1].debuff) then
      target = G.jokers.highlighted[1]
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"alcremie") and not (poke.config.center.name == "alcremie_berry") and not (poke.config.center.name == "alcremie_love") and not (poke.config.center.name == "alcremie_star") and not (poke.config.center.name == "alcremie_clover") and not (poke.config.center.name == "alcremie_flower") and not (poke.config.center.name == "alcremie_ribbon")and not (poke.debuff)) then
          target = poke
          break
        end
      end
    end
    if target then
        poke_evolve(target, "j_Gem_alcremie_love")
    end
  end,
  in_pool = function(self)
    return false
  end
}

local starsweet = {
  name = "starsweet",
  key = "starsweet",
  set = "Item",
  config = {max_highlighted = 3, min_highlighted = 1},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  pos = {x = 0, y = 0},
  atlas = "Gem_placeholder",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if G.jokers.highlighted and #G.jokers.highlighted == 1 then
        if string.find(G.jokers.highlighted[1].config.center.name,"alcremie") and not (G.jokers.highlighted[1].config.center.name == "alcremie_berry") and not (G.jokers.highlighted[1].config.center.name == "alcremie_love") and not (G.jokers.highlighted[1].config.center.name == "alcremie_star") and not (G.jokers.highlighted[1].config.center.name == "alcremie_clover") and not (G.jokers.highlighted[1].config.center.name == "alcremie_flower") and not (G.jokers.highlighted[1].config.center.name == "alcremie_ribbon") then
          return true
        else
          return false
        end
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"alcremie") and not (poke.config.center.name == "alcremie_berry") and not (poke.config.center.name == "alcremie_love") and not (poke.config.center.name == "alcremie_star") and not (poke.config.center.name == "alcremie_clover") and not (poke.config.center.name == "alcremie_flower") and not (poke.config.center.name == "alcremie_ribbon")and not (poke.debuff)) then
          return true
        else
          return false
        end
      end
    end
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
    if #G.hand.highlighted >= self.config.min_highlighted then
      juice_flip(card)
      local enhance = self.config.enhancement
      for i = 1, #G.hand.highlighted do
        G.hand.highlighted[i]:set_ability(enhance, nil, true)
      end
      juice_flip(card, true)
      poke_unhighlight_cards()
      evo_item_use_total(self, card, area, copier)
    else
      highlighted_evo_item(self, card, area, copier)
    end

    local target = nil
    if G.jokers.highlighted and #G.jokers.highlighted == 1 and 
        (string.find(G.jokers.highlighted[1].config.center.name,"alcremie") and not (G.jokers.highlighted[1].config.center.name == "alcremie_berry") and not (G.jokers.highlighted[1].config.center.name == "alcremie_love")and not (G.jokers.highlighted[1].config.center.name == "alcremie_star")and not (G.jokers.highlighted[1].config.center.name == "alcremie_clover")and not (G.jokers.highlighted[1].config.center.name == "alcremie_flower")and not (G.jokers.highlighted[1].config.center.name == "alcremie_ribbon")) and not (G.jokers.highlighted[1].debuff) then
      target = G.jokers.highlighted[1]
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"alcremie") and not (poke.config.center.name == "alcremie_berry") and not (poke.config.center.name == "alcremie_love") and not (poke.config.center.name == "alcremie_star") and not (poke.config.center.name == "alcremie_clover") and not (poke.config.center.name == "alcremie_flower") and not (poke.config.center.name == "alcremie_ribbon")and not (poke.debuff)) then
          target = poke
          break
        end
      end
    end
    if target then
        poke_evolve(target, "j_Gem_alcremie_star")
    end
  end,
  in_pool = function(self)
    return false
  end
}

local cloversweet = {
  name = "cloversweet",
  key = "cloversweet",
  set = "Item",
  config = {max_highlighted = 3, min_highlighted = 1},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  pos = {x = 0, y = 0},
  atlas = "Gem_placeholder",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if G.jokers.highlighted and #G.jokers.highlighted == 1 then
        if string.find(G.jokers.highlighted[1].config.center.name,"alcremie") and not (G.jokers.highlighted[1].config.center.name == "alcremie_berry") and not (G.jokers.highlighted[1].config.center.name == "alcremie_love") and not (G.jokers.highlighted[1].config.center.name == "alcremie_star") and not (G.jokers.highlighted[1].config.center.name == "alcremie_clover") and not (G.jokers.highlighted[1].config.center.name == "alcremie_flower") and not (G.jokers.highlighted[1].config.center.name == "alcremie_ribbon") then
          return true
        else
          return false
        end
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"alcremie") and not (poke.config.center.name == "alcremie_berry") and not (poke.config.center.name == "alcremie_love") and not (poke.config.center.name == "alcremie_star") and not (poke.config.center.name == "alcremie_clover") and not (poke.config.center.name == "alcremie_flower") and not (poke.config.center.name == "alcremie_ribbon")and not (poke.debuff)) then
          return true
        else
          return false
        end
      end
    end
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
    if #G.hand.highlighted >= self.config.min_highlighted then
      juice_flip(card)
      local enhance = self.config.enhancement
      for i = 1, #G.hand.highlighted do
        G.hand.highlighted[i]:set_ability(enhance, nil, true)
      end
      juice_flip(card, true)
      poke_unhighlight_cards()
      evo_item_use_total(self, card, area, copier)
    else
      highlighted_evo_item(self, card, area, copier)
    end

    local target = nil
    if G.jokers.highlighted and #G.jokers.highlighted == 1 and 
        (string.find(G.jokers.highlighted[1].config.center.name,"alcremie") and not (G.jokers.highlighted[1].config.center.name == "alcremie_berry") and not (G.jokers.highlighted[1].config.center.name == "alcremie_love")and not (G.jokers.highlighted[1].config.center.name == "alcremie_star")and not (G.jokers.highlighted[1].config.center.name == "alcremie_clover")and not (G.jokers.highlighted[1].config.center.name == "alcremie_flower")and not (G.jokers.highlighted[1].config.center.name == "alcremie_ribbon")) and not (G.jokers.highlighted[1].debuff) then
      target = G.jokers.highlighted[1]
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"alcremie") and not (poke.config.center.name == "alcremie_berry") and not (poke.config.center.name == "alcremie_love") and not (poke.config.center.name == "alcremie_star") and not (poke.config.center.name == "alcremie_clover") and not (poke.config.center.name == "alcremie_flower") and not (poke.config.center.name == "alcremie_ribbon")and not (poke.debuff)) then
          target = poke
          break
        end
      end
    end
    if target then
        poke_evolve(target, "j_Gem_alcremie_clover")
    end
  end,
  in_pool = function(self)
    return false
  end
}

local flowersweet = {
  name = "flowersweet",
  key = "flowersweet",
  set = "Item",
  config = {max_highlighted = 3, min_highlighted = 1},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  pos = {x = 0, y = 0},
  atlas = "Gem_placeholder",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if G.jokers.highlighted and #G.jokers.highlighted == 1 then
        if string.find(G.jokers.highlighted[1].config.center.name,"alcremie") and not (G.jokers.highlighted[1].config.center.name == "alcremie_berry") and not (G.jokers.highlighted[1].config.center.name == "alcremie_love") and not (G.jokers.highlighted[1].config.center.name == "alcremie_star") and not (G.jokers.highlighted[1].config.center.name == "alcremie_clover") and not (G.jokers.highlighted[1].config.center.name == "alcremie_flower") and not (G.jokers.highlighted[1].config.center.name == "alcremie_ribbon") then
          return true
        else
          return false
        end
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"alcremie") and not (poke.config.center.name == "alcremie_berry") and not (poke.config.center.name == "alcremie_love") and not (poke.config.center.name == "alcremie_star") and not (poke.config.center.name == "alcremie_clover") and not (poke.config.center.name == "alcremie_flower") and not (poke.config.center.name == "alcremie_ribbon")and not (poke.debuff)) then
          return true
        else
          return false
        end
      end
    end
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
    if #G.hand.highlighted >= self.config.min_highlighted then
      juice_flip(card)
      local enhance = self.config.enhancement
      for i = 1, #G.hand.highlighted do
        G.hand.highlighted[i]:set_ability(enhance, nil, true)
      end
      juice_flip(card, true)
      poke_unhighlight_cards()
      evo_item_use_total(self, card, area, copier)
    else
      highlighted_evo_item(self, card, area, copier)
    end

    local target = nil
    if G.jokers.highlighted and #G.jokers.highlighted == 1 and 
        (string.find(G.jokers.highlighted[1].config.center.name,"alcremie") and not (G.jokers.highlighted[1].config.center.name == "alcremie_berry") and not (G.jokers.highlighted[1].config.center.name == "alcremie_love")and not (G.jokers.highlighted[1].config.center.name == "alcremie_star")and not (G.jokers.highlighted[1].config.center.name == "alcremie_clover")and not (G.jokers.highlighted[1].config.center.name == "alcremie_flower")and not (G.jokers.highlighted[1].config.center.name == "alcremie_ribbon")) and not (G.jokers.highlighted[1].debuff) then
      target = G.jokers.highlighted[1]
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"alcremie") and not (poke.config.center.name == "alcremie_berry") and not (poke.config.center.name == "alcremie_love") and not (poke.config.center.name == "alcremie_star") and not (poke.config.center.name == "alcremie_clover") and not (poke.config.center.name == "alcremie_flower") and not (poke.config.center.name == "alcremie_ribbon")and not (poke.debuff)) then
          target = poke
          break
        end
      end
    end
    if target then
        poke_evolve(target, "j_Gem_alcremie_flower")
    end
  end,
  in_pool = function(self)
    return false
  end
}

local ribbonsweet = {
  name = "ribbonsweet",
  key = "ribbonsweet",
  set = "Item",
  config = {max_highlighted = 3, min_highlighted = 1},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  pos = {x = 0, y = 0},
  atlas = "Gem_placeholder",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if G.jokers.highlighted and #G.jokers.highlighted == 1 then
        if string.find(G.jokers.highlighted[1].config.center.name,"alcremie") and not (G.jokers.highlighted[1].config.center.name == "alcremie_berry") and not (G.jokers.highlighted[1].config.center.name == "alcremie_love") and not (G.jokers.highlighted[1].config.center.name == "alcremie_star") and not (G.jokers.highlighted[1].config.center.name == "alcremie_clover") and not (G.jokers.highlighted[1].config.center.name == "alcremie_flower") and not (G.jokers.highlighted[1].config.center.name == "alcremie_ribbon") then
          return true
        else
          return false
        end
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"alcremie") and not (poke.config.center.name == "alcremie_berry") and not (poke.config.center.name == "alcremie_love") and not (poke.config.center.name == "alcremie_star") and not (poke.config.center.name == "alcremie_clover") and not (poke.config.center.name == "alcremie_flower") and not (poke.config.center.name == "alcremie_ribbon")and not (poke.debuff)) then
          return true
        else
          return false
        end
      end
    end
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
    if #G.hand.highlighted >= self.config.min_highlighted then
      juice_flip(card)
      local enhance = self.config.enhancement
      for i = 1, #G.hand.highlighted do
        G.hand.highlighted[i]:set_ability(enhance, nil, true)
      end
      juice_flip(card, true)
      poke_unhighlight_cards()
      evo_item_use_total(self, card, area, copier)
    else
      highlighted_evo_item(self, card, area, copier)
    end

    local target = nil
    if G.jokers.highlighted and #G.jokers.highlighted == 1 and 
        (string.find(G.jokers.highlighted[1].config.center.name,"alcremie") and not (G.jokers.highlighted[1].config.center.name == "alcremie_berry") and not (G.jokers.highlighted[1].config.center.name == "alcremie_love")and not (G.jokers.highlighted[1].config.center.name == "alcremie_star")and not (G.jokers.highlighted[1].config.center.name == "alcremie_clover")and not (G.jokers.highlighted[1].config.center.name == "alcremie_flower")and not (G.jokers.highlighted[1].config.center.name == "alcremie_ribbon")) and not (G.jokers.highlighted[1].debuff) then
      target = G.jokers.highlighted[1]
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"alcremie") and not (poke.config.center.name == "alcremie_berry") and not (poke.config.center.name == "alcremie_love") and not (poke.config.center.name == "alcremie_star") and not (poke.config.center.name == "alcremie_clover") and not (poke.config.center.name == "alcremie_flower") and not (poke.config.center.name == "alcremie_ribbon")and not (poke.debuff)) then
          target = poke
          break
        end
      end
    end
    if target then
        poke_evolve(target, "j_Gem_alcremie_ribbon")
    end
  end,
  in_pool = function(self)
    return false
  end
}

if Gem_config.Alcremie then
  list = {
    berrysweet, lovesweet, starsweet, cloversweet, flowersweet, ribbonsweet
  }
else list = {}
end


return {name = "Gem's Items",
  list = list
}