function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
--  Cryogonal 615
local cryogonal = {
  name = "cryogonal",
  pos = PokemonSprites["cryogonal"].base.pos,
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_glass
    end
    return {vars = {}}
  end,
  designer = "CBMX",
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Water",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      local faces = 0
      for _, scored_card in ipairs(context.scoring_hand) do
        if scored_card:is_face() then
              faces = faces + 1
              scored_card:set_ability('m_glass', nil, true)
              G.E_MANAGER:add_event(Event({
                  func = function()
                      scored_card:juice_up()
                      return true
                  end
              }))
        end
      end
      if faces > 0 then
          return {
              message = localize('k_glass'),
              colour = G.C.MONEY
          }
     end
    end
  end,
}

return {
  name = "Gem's Cryogonal",
  enabled = Gem_config.Cryogonal or false,
  list = {cryogonal}
}

