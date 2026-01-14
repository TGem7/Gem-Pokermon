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

-- Load functions
local load_directory, item_loader = assert(SMODS.load_file("src/loader.lua"))()

load_directory("src/functions")

--Load pokemon file
local load_pokemon_ref = pokermon.load_pokemon
function pokermon.load_pokemon(item)
  if item.Gem_inject_prefix then
    item.key = item.Gem_inject_prefix .. '_' .. item.name
    item.prefix_config = item.prefix_config or {}
    item.prefix_config.key = { mod = false }
  end
  return load_pokemon_ref(item)
end

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
          local custom_prefix = item.Gem_inject_prefix or "Gem"
          local custom_atlas = item.atlas and string.find(item.atlas, "Gem")
          pokermon.Pokemon(item, custom_prefix, custom_atlas)
        end
      end
    end
  end
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

--Required by the pokemon family function (right click on a pokemon joker)
local name_lists = {
  {"treecko", "grovyle", "sceptile", "mega_sceptile"},
  {"torchic", "combusken", "blaziken", "mega_blaziken"},
  {"mudkip", "marshtomp", "swampert", "mega_swampert"},
  {"absol", "mega_absol"},
  {"baltoy", "claydol"},
  {"mawile", "mega_mawile"},
  {"meditite", "medicham", "mega_medicham"},
  {"electrike", "manectric", "mega_manectric"},
  {"carvanha", "sharpedo", "mega_sharpedo"},
  {"hisuian_growlithe", "hisuian_arcanine"},
  {"alolan_grimer", "alolan_muk"},
  {"cubone", "marowak", "alolan_marowak"},
  {"hisuian_qwilfish", "overqwil"},
  {"yamask", "cofagrigus"},
  {"sandile", "krokorok", "krookodile"},
  {"morelull", "shiinotic"},
  {"sizzlipede", "centiskorch"},
  {"wailmer", "wailord"},
  {"chingling", "chimecho"},
  {"zeraora"},
  {"milcery", "alcremie", "alcremie_berry", "alcremie_love", "alcremie_star", "alcremie_clover", "alcremie_flower", "alcremie_ribbon"},
  {"pincurchin"},
  {"indeedee_f"},
  {"indeedee_m"},
  {"capsakid", "scovillain", "mega_scovillain"},
  {"kubfu", "urshifu_single_strike", "urshifu_rapid_strike"},
  {"great_tusk"},
  {"iron_treads"},
  {"iron_hands"},
  {"flutter_mane"},
  {"iron_bundle"},
  {"sandy_shocks"},
  {"scream_tail"},
  {"iron_jugulis"},
  {"koraidon"},
  {"miraidon"},
  {"noibat", "noivern"},
  {"greavard", "houndstone"},
  {"minccino", "cinccino"},
  {"cryogonal"},
  {"cutiefly", "ribombee"},
  {"phantump", "trevenant"},
  {"stufful", "bewear"},
  {"espurr", "meowstic", "meowstic_f", "mega_meowstic"},
}

SMODS.Rarity{
    key = "paradox",
    default_weight = 0,
    badge_colour = HEX("C7001B"),
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity{
    key = "future_paradox",
    default_weight = 0,
    badge_colour = HEX("FB00FF"),
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

for i, list in ipairs(name_lists) do
  pokermon.add_family(list)
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

SMODS.Joker:take_ownership('poke_sceptile', { megas = { 'mega_sceptile' } }, true)
SMODS.Joker:take_ownership('poke_blaziken', { megas = { 'mega_blaziken' } }, true)
SMODS.Joker:take_ownership('poke_swampert', { megas = { 'mega_swampert' } }, true)
SMODS.Joker:take_ownership('poke_absol', { megas = { 'mega_absol' } }, true)

print("DEBUG: main.lua loaded")

--doesnt work right now, ill figure it out later.
--local function replace_specific_jokers_with_random()

GEM.utils.hook_before_function(SMODS.current_mod, 'reset_game_globals', function(run_start)
  if run_start then
    for _, center in pairs(G.P_CENTERS) do
      if center.Gem_config_key and not Gem_config[center.Gem_config_key] then
        G.GAME.banned_keys[center.key] = true
      end
    end
  end
end)
