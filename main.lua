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
  key = "maelmc_mart",
  path = "maelmc_mart.png",
  px = 71,
  py = 95
}):register()

--Required by the pokemon family function (right click on a pokemon joker)
pokermon.add_family({"treecko", "grovyle", "sceptile", "mega_sceptile"})
pokermon.add_family({"torchic", "combusken", "blaziken", "mega_blaziken"})
pokermon.add_family({"mudkip", "marshtomp", "swampert", "mega_swampert"})
pokermon.add_family({"mawile", "mega_mawile"})
pokermon.add_family({"meditite", "medicham", "mega_medicham"})
pokermon.add_family({"electrike", "manectric", "mega_manectric"})
pokermon.add_family({"budew", "roselia", "roserade"})
pokermon.add_family({"carvanha", "sharpedo", "mega_sharpedo"})
pokermon.add_family({"hisuian_growlithe", "hisuian_arcanine"})
pokermon.add_family({"cubone", "marowak", "alolan_marowak"})
pokermon.add_family({"yamask", "cofagrigus"})
pokermon.add_family({"milcery", "alcremie", "alcremie_berry", "alcremie_love", "alcremie_star", "alcremie_clover", "alcremie_flower", "alcremie_ribbon"})
pokermon.add_family({"pincurchin"})
pokermon.add_family({"indeedee_f"})
pokermon.add_family({"indeedee_m"})
pokermon.add_family({"capsakid", "scovillain"})

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
