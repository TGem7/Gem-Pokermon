GEM = {}


--Load all Atlas
SMODS.Atlas({
    key = "modicon",
    path = "nephrite_icon.png",
    px = 32,
    py = 32
})
SMODS.Atlas({
  key = "Gem_placeholder",
  path = "Gem_placeholder.png",
  px = 71,
  py = 95
}):register()
SMODS.Atlas({
  key = "Gem_sweets",
  path = "Gem_sweets.png",
  px = 71,
  py = 95
}):register()

Gem_config = SMODS.current_mod.config
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end

assert(SMODS.load_file("src/functions.lua"))()

--Load pokemon file
local pfiles = NFS.getDirectoryItems(mod_dir.."pokemon")

for _, file in ipairs(pfiles) do
  sendDebugMessage ("The file is: "..file)
  local pokemon, load_error = SMODS.load_file("pokemon/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_pokemon = pokemon()

    if curr_pokemon.enabled then 
      if curr_pokemon.init then curr_pokemon:init() end
     
      if curr_pokemon.list and #curr_pokemon.list > 0 then
        for i, item in ipairs(curr_pokemon.list) do
          if string.find(item.atlas, "Gem") then
            pokermon.Pokemon(item,"Gem",true)
          else
            pokermon.Pokemon(item,"Gem",false)
          end
        end
      end
    end
  end
end

--Required by the pokemon family function (right click on a pokemon joker)
local hoenn_starters = {}
local name_lists = {
  {"treecko", "grovyle", "sceptile", "mega_sceptile"},
  {"torchic", "combusken", "blaziken", "mega_blaziken"},
  {"mudkip", "marshtomp", "swampert", "mega_swampert"},
  {"mawile", "mega_mawile"},
  {"meditite", "medicham", "mega_medicham"},
  {"electrike", "manectric", "mega_manectric"},
  {"budew", "roselia", "roserade"},
  {"carvanha", "sharpedo", "mega_sharpedo"},
  {"hisuian_growlithe", "hisuian_arcanine"},
  {"cubone", "marowak", "alolan_marowak"},
  {"yamask", "cofagrigus"},
  {"milcery", "alcremie", "alcremie_berry", "alcremie_love", "alcremie_star", "alcremie_clover", "alcremie_flower", "alcremie_ribbon"},
  {"pincurchin"},
  {"indeedee_f"},
  {"indeedee_m"},
  {"capsakid", "scovillain"},
  {"kubfu", "urshifu_single_strike", "urshifu_rapid_strike"},
}

for i, list in ipairs(name_lists) do
  pokermon.add_family(list)
  -- Dex Ordering for Pokermon Dip
  if (SMODS.Mods["NachosPokermonDip"] or {}).can_load and PkmnDip and PkmnDip.dex_order_groups then
    if i > 3 then PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = list
    else for k, name in ipairs(list) do table.insert(hoenn_starters, name) end end
  end
end

-- The Hoenn Starters are annoying because the vanilla copies technically still exist
if (SMODS.Mods["NachosPokermonDip"] or {}).can_load and PkmnDip and PkmnDip.dex_order_groups then
  PkmnDip.dex_order_groups[#PkmnDip.dex_order_groups+1] = hoenn_starters end

-- Load consumables
local pconsumables = NFS.getDirectoryItems(mod_dir.."consumables")

for _, file in ipairs(pconsumables) do
  sendDebugMessage ("The file is: "..file)
  local consumable, load_error = SMODS.load_file("consumables/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_consumable = consumable()
    if curr_consumable.init then curr_consumable:init() end
    
    for i, item in ipairs(curr_consumable.list) do
      if not (item.pokeball and not pokermon_config.pokeballs) then
        item.discovered = not pokermon_config.pokemon_discovery
        SMODS.Consumable(item)
      end
    end
  end
end

--Load config tab setup file
assert(SMODS.load_file("src/settings.lua"))()

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
