-- Mega Mawile 303
local mega_mawile = {
  name = "mega_mawile",
  Gem_inject_prefix = "poke",
  pos = { x = 10, y = 4 },
  soul_pos =  {x = 11, y = 4 },
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_steel
    end
    return { vars = {  } }
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Metal",
  atlas = "AtlasJokersBasicGen03",
  gen = 3,
  blueprint_compat = false,
  calculate = function(self, card, context)
  end,
}

local init = function()
  SMODS.Joker:take_ownership('poke_mawile', { megas = { 'mega_mawile' } }, true)
  pokermon.add_to_family("mawile", "mega_mawile")
end

return {
  config_key = "Mawile",
  init = init,
  list = { mega_mawile }
}