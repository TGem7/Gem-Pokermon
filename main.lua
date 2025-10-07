
--Load all Atlas
SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
})

--Required by the pokemon family function (right click on a pokemon joker)
pokermon.add_family({"treecko", "grovyle", "sceptile", "mega_sceptile"})
pokermon.add_family({"torchic", "combusken", "blaziken", "mega_blaziken"})
pokermon.add_family({"mudkip", "marshtomp", "swampert", "mega_swampert"})
pokermon.add_family({"mawile", "mega_mawile"})
pokermon.add_family({"meditite", "medicham", "mega_medicham"})
pokermon.add_family({"hisuian_growlithe", "hisuian_arcanine"})
pokermon.add_family({"cubone", "marowak", "alolan_marowak"})
pokermon.add_family({"pincurchin"})
pokermon.add_family({"indeedee_f"})
pokermon.add_family({"indeedee_m"})
pokermon.add_family({"capsakid", "scovillain"})


Gem_config = SMODS.current_mod.config
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end

--Load pokemon file
local pfiles = NFS.getDirectoryItems(mod_dir.."pokemon")

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
        if string.find(item.atlas, "Gem") then
          pokermon.Pokemon(item,"Gem",true)
        else
          pokermon.Pokemon(item,"Gem",false)
        end
      end
    end
  end
end

SMODS.current_mod.config_tab = function() 
    return {
        n = G.UIT.ROOT,
        config = {
            align = "cm",
            padding = 0.05,
            colour = G.C.CLEAR,
        },
        nodes = {
            create_toggle({
                label = localize("hisuian_growlithe_line"),
                ref_table = Gem_config,
                ref_value = "H_Growlithe",
            }),
            create_toggle({
                label = localize("cubone_line"),
                ref_table = Gem_config,
                ref_value = "Cubone",
            }),
            create_toggle({
                label = localize("treecko_line"),
                ref_table = Gem_config,
                ref_value = "Treecko",
            }),
            create_toggle({
                label = localize("torchic_line"),
                ref_table = Gem_config,
                ref_value = "Torchic",
            }),
            create_toggle({
                label = localize("mudkip_line"),
                ref_table = Gem_config,
                ref_value = "Mudkip",
            }),
            create_toggle({
                label = localize("mawile_line"),
                ref_table = Gem_config,
                ref_value = "Mawile",
            }),
            create_toggle({
                label = localize("meditite_line"),
                ref_table = Gem_config,
                ref_value = "Meditite",
            }),
            create_toggle({
                label = localize("pincurchin_line"),
                ref_table = Gem_config,
                ref_value = "Pincurchin",
            }),
            create_toggle({
                label = localize("indeedee_f_line"),
                ref_table = Gem_config,
                ref_value = "Indeedee_F",
            }),
            create_toggle({
                label = localize("indeedee_m_line"),
                ref_table = Gem_config,
                ref_value = "Indeedee_M",
            }),
            create_toggle({
                label = localize("capsakid_line"),
                ref_table = Gem_config,
                ref_value = "Capsakid",
            }),
        },
    }
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