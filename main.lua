GEM = {}

--Load all Atlas
SMODS.Atlas({
    key = "modicon",
    path = "Gem_icon.png",
    px = 32,
    py = 32
})
SMODS.Atlas({
  key = "Gem_placeholder",
  path = "Gem_placeholder.png",
  px = 71,
  py = 95
})
SMODS.Atlas({
  key = "Gem_fast",
  path = "Gem_fast.png",
  px = 71,
  py = 95
})
SMODS.Atlas({
  key = "Gem_sweets",
  path = "Gem_sweets.png",
  px = 71,
  py = 95
})

Gem_config = SMODS.current_mod.config
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
  pokermon_config = SMODS.Mods["Pokermon"].config
end

-- Load functions
local load_directory, item_loader = assert(SMODS.load_file("src/loader.lua"))()

load_directory("src/functions")

--Load pokemon files
load_directory("pokemon", item_loader.load_pokemon, { post_load = item_loader.load_pokemon_family })

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

-- Load consumables
load_directory("consumables", SMODS.Consumable)

--Load config tab setup file
assert(SMODS.load_file("src/settings.lua"))()

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
