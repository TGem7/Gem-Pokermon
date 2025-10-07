function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Pincurchin
local pincurchin={
  name = "pincurchin",
  
  pos = PokemonSprites["pincurchin"].base.pos,
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Lightning",
  atlas = "AtlasJokersBasicNatdex",
  gen = 8,
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = false,
  calculate = function(self, card, context)
    if context.selling_self and not context.blueprint then
      for _ = 1,#find_pokemon_type("Lightning") do
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.0,
            func = (function()
                  local card = create_card('Energy', G.consumeables, nil, nil, nil, nil, 'c_poke_lightning_energy')
                  local edition = {negative = true}
                  card:set_edition(edition, true)
                  card:add_to_deck()
                  G.consumeables:emplace(card)
                  G.GAME.consumeable_buffer = 0
              return true
            end)}))
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("poke_electric_surge_ex"), colour = G.ARGS.LOC_COLOURS["pink"]})
      end
    end
  end,
}

if Gem_config.Pincurchin then
  list = {pincurchin}
else list = {}
end


return {name = "Pincurchin",
list = list
}
