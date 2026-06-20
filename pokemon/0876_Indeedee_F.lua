

-- Indeedee F
local indeedee_f={
  name = "indeedee_f",
  
  pos = {x = 14, y = 8},
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen08",
  gen = 8,
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = false,
  calculate = function(self, card, context)
    if context.selling_self and not context.blueprint then
      for _ = 1, #pokermon.find_pokemon_type("Psychic") do
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.0,
            func = (function()
                  local card = create_card('poke_energy', G.consumeables, nil, nil, nil, nil, 'c_poke_psychic_energy')
                  local edition = {negative = true}
                  card:set_edition(edition, true)
                  card:add_to_deck()
                  G.consumeables:emplace(card)
                  G.GAME.consumeable_buffer = 0
              return true
            end)}))
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("poke_psychic_surge_ex"), colour = G.ARGS.LOC_COLOURS["pink"]})
      end
    end
  end,
}

return {
  config_key = "Indeedee_F",
  list = { indeedee_f }
}

