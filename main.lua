
--Load all Atlas
SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
})

SMODS.Atlas({
    key = "Gemdex1",
    path = "Gemdex1.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "shiny_Gemdex1",
    path = "shiny_Gemdex1.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "Gemdex3",
    path = "Gemdex3.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "shiny_Gemdex3",
    path = "shiny_Gemdex3.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "Gemdex5",
    path = "Gemdex5.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "shiny_Gemdex5",
    path = "shiny_Gemdex5.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "Gemdex7",
    path = "Gemdex7.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "shiny_Gemdex7",
    path = "shiny_Gemdex7.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "Gemdex8",
    path = "Gemdex8.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "shiny_Gemdex8",
    path = "shiny_Gemdex8.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "Gemdex9",
    path = "Gemdex9.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "shiny_Gemdex9",
    path = "shiny_Gemdex9.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "GemMegas",
    path = "GemMegas.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "shiny_GemMegas",
    path = "shiny_GemMegas.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "GemRegionals",
    path = "GemRegionals.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "shiny_GemRegionals",
    path = "shiny_GemRegionals.png",
    px = 71,
    py = 95
}):register()

--Required by the pokemon family function (right click on a pokemon joker)
table.insert(pokermon.family, {"treecko", "grovyle", "sceptile", "mega_sceptile"})
table.insert(pokermon.family, {"torchic", "combusken", "blaziken", "mega_blaziken"})
table.insert(pokermon.family, {"mudkip", "marshtomp", "swampert", "mega_swampert"})
table.insert(pokermon.family, {"mawile", "mega_mawile"})
table.insert(pokermon.family, {"meditite", "medicham", "mega_medicham"})
table.insert(pokermon.family, {"joltik", "galvantula"})
table.insert(pokermon.family, {"cubone", "marowak", "alolan_marowak"})
table.insert(pokermon.family, {"pincurchin"})
table.insert(pokermon.family, {"indeedee_f"})
table.insert(pokermon.family, {"indeedee_m"})
table.insert(pokermon.family, {"capsakid", "scovillain"})


Gem_config = SMODS.current_mod.config
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end

--Load Joker Display if the mod is enabled
if (SMODS.Mods["JokerDisplay"] or {}).can_load then
  local jokerdisplays = NFS.getDirectoryItems(mod_dir.."jokerdisplay")

  for _, file in ipairs(jokerdisplays) do
    sendDebugMessage ("The file is: "..file)
    local helper, load_error = SMODS.load_file("jokerdisplay/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      helper()
    end
  end
end

if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] and not pokermon_config.jokers_only then
    --Load backs
    local backs = NFS.getDirectoryItems(mod_dir.."backs")
  
    for _, file in ipairs(backs) do
      sendDebugMessage ("The file is: "..file)
      local back, load_error = SMODS.load_file("backs/"..file)
      if load_error then
        sendDebugMessage ("The error is: "..load_error)
      else
        local curr_back = back()
        if curr_back.init then curr_back:init() end
        
        for i, item in ipairs(curr_back.list) do
          SMODS.Back(item)
        end
      end
    end
  end

if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] and not pokermon_config.jokers_only then
    --Load stakes
    local stakes = NFS.getDirectoryItems(mod_dir.."stakes")
  
    for _, file in ipairs(stakes) do
      sendDebugMessage ("The file is: "..file)
      local stakes, load_error = SMODS.load_file("stakes/"..file)
      if load_error then
        sendDebugMessage ("The error is: "..load_error)
      else
        local curr_stake = stakes()
        if curr_stake.init then curr_stake:init() end
        
        for i, item in ipairs(curr_stake.list) do
          SMODS.Stake(item)
        end
      end
    end
  end

if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] and not pokermon_config.jokers_only then
    --Load stickers
    local stickers = NFS.getDirectoryItems(mod_dir.."stickers")
  
    for _, file in ipairs(stickers) do
      sendDebugMessage ("The file is: "..file)
      local sticker, load_error = SMODS.load_file("stickers/"..file)
      if load_error then
        sendDebugMessage ("The error is: "..load_error)
      else
        local curr_sticker = sticker()
        if curr_sticker.init then curr_sticker:init() end
        
        for i, item in ipairs(curr_sticker.list) do
          SMODS.Sticker(item)
        end
      end
    end
  end

local pconsumables = NFS.getDirectoryItems(mod_dir.."consumables")

if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] then
  for _, file in ipairs(pconsumables) do
    sendDebugMessage ("The file is: "..file)
    local consumable, load_error = SMODS.load_file("consumables/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      local curr_consumable = consumable()
      if curr_consumable.init then curr_consumable:init() end
      
      for i, item in ipairs(curr_consumable.list) do
        if ((not pokermon_config.jokers_only and not item.pokeball) or (item.pokeball and pokermon_config.pokeballs)) or (item.evo_item and not pokermon_config.no_evos) then
          SMODS.Consumable(item)
        end
      end
    end
  end 
end



-- Get mod path and load other files
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end

print("DEBUG")

--Load pokemon file
local pfiles = NFS.getDirectoryItems(mod_dir.."pokemon")
if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] then
  for _, file in ipairs(pfiles) do
    sendDebugMessage ("The file is: "..file)
    local pokemon, load_error = SMODS.load_file("pokemon/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      local curr_pokemon = pokemon()
      if curr_pokemon.init then curr_pokemon:init() end
      
      if curr_pokemon.list and #curr_pokemon.list > 0 then
        for i, item in ipairs(curr_pokemon.list) do
          if (pokermon_config.jokers_only and not item.joblacklist) or not pokermon_config.jokers_only  then
            item.discovered = true
            if not item.key then
              item.key = item.name
            end
            if not pokermon_config.no_evos and not item.custom_pool_func then
              item.in_pool = function(self)
                return pokemon_in_pool(self)
              end
            end
            if not item.config then
              item.config = {}
            end
            if item.ptype then
              if item.config and item.config.extra then
                item.config.extra.ptype = item.ptype
              elseif item.config then
                item.config.extra = {ptype = item.ptype}
              end
            end
            if not item.set_badges then
              item.set_badges = poke_set_type_badge
            end
            if item.item_req then
              if item.config and item.config.extra then
                item.config.extra.item_req = item.item_req
              elseif item.config then
                item.config.extra = {item_req = item.item_req}
              end
            end
            if item.evo_list then
              if item.config and item.config.extra then
                item.config.extra.evo_list = item.evo_list
              elseif item.config then
                item.config.extra = {item_req = item.evo_list}
              end
            end
            if pokermon_config.jokers_only and item.rarity == "poke_safari" then
              item.rarity = 3
            end
            item.discovered = not pokermon_config.pokemon_discovery 
            SMODS.Joker(item)
          end
        end
      end
    end
  end
end 



--Load Debuff logic
local sprite, load_error = SMODS.load_file("functions/functions.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  sprite()
end

if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] and not pokermon_config.jokers_only then
  if (SMODS.Mods["CardSleeves"] or {}).can_load then
    --Load Sleeves
    local sleeves = NFS.getDirectoryItems(mod_dir.."sleeves")

    for _, file in ipairs(sleeves) do
      sendDebugMessage ("the file is: "..file)
      local sleeve, load_error = SMODS.load_file("sleeves/"..file)
      if load_error then
        sendDebugMessage("The error is: "..load_error)
      else
        local curr_sleeve = sleeve()
        if curr_sleeve.init then curr_sleeve.init() end
        
        for i,item in ipairs (curr_sleeve.list) do
          CardSleeves.Sleeve(item)
        end
      end
    end
  end
end

SMODS.Joker:take_ownership('poke_cubone', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end, 
		-- more on this later

    },
    true -- silent | suppresses mod badge
)


SMODS.Joker:take_ownership('poke_marowak', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end,
		-- more on this later

    },
   true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('poke_treecko', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end, 
		-- more on this later

    },
    true -- silent | suppresses mod badge
)


SMODS.Joker:take_ownership('poke_grovyle', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end,
		-- more on this later

    },
   true -- silent | suppresses mod badge
)


SMODS.Joker:take_ownership('poke_sceptile', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end,
		-- more on this later

    },
   true -- silent | suppresses mod badge
)


SMODS.Joker:take_ownership('poke_torchic', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end, 
		-- more on this later

    },
    true -- silent | suppresses mod badge
)


SMODS.Joker:take_ownership('poke_combusken', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end,
		-- more on this later

    },
   true -- silent | suppresses mod badge
)


SMODS.Joker:take_ownership('poke_blaziken', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end,
		-- more on this later

    },
   true -- silent | suppresses mod badge
)


SMODS.Joker:take_ownership('poke_mudkip', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end, 
		-- more on this later

    },
    true -- silent | suppresses mod badge
)


SMODS.Joker:take_ownership('poke_marshtomp', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end,
		-- more on this later

    },
   true -- silent | suppresses mod badge
)


SMODS.Joker:take_ownership('poke_swampert', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	aux_poke = true,
    no_collection = true,
    custom_pool_func = true,
    in_pool = function(self)
        return false
    end,
		-- more on this later

    },
   true -- silent | suppresses mod badge
)
print("DEBUG: main.lua loaded")

--doesnt work right now, ill figure it out later.
--local function replace_specific_jokers_with_random()