function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Mawile 303
local mawile={
  name = "mawile", 
  
  pos = PokemonSprites["mawile"].base.pos,
  config = { extra = { copy = 1 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_steel
    end
      return { vars = { card.ability.extra.copy } }
  end,
  rarity = 3, 
  cost = 8, 
  stage = "Basic", 
  ptype = "Metal",
  atlas = "AtlasJokersBasicNatdex",
  gen = 3,
  blueprint_compat = true,
  calculate = function(self, card, context)
        if context.before and #context.full_hand == 1 then
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
              local copy = copy_card(context.full_hand[1], nil, nil, G.playing_card)
              copy:set_ability(G.P_CENTERS.m_steel, nil, true)
              poke_add_card(copy, card)
            return {
                message = localize('k_copied_ex'),
                colour = G.C.CHIPS,
                func = function() -- This is for timing purposes, it runs after the message
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } })
                            return true
                        end
                    }))
                end
            }
        end
        if context.final_scoring_step and #context.full_hand == 1 and not context.blueprint then
             context.full_hand[1].mawile_remove = card
             card:juice_up()
        end
        if context.destroy_card and context.destroy_card.mawile_remove == card and not context.blueprint then
        context.destroy_card.to_be_removed_by = nil
        return {
          remove = true
        }
      end
   end,
  megas = { "mega_mawile" },
}
-- Mega Mawile 303
local mega_mawile = {
  name = "mega_mawile",
  
  pos = { x = 10, y = 4 },
  soul_pos =  {x = 11, y = 4 },
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
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

return {
  name = "Gem's Mawile",
  enabled = Gem_config.Mawile or false,
  list = { mawile, mega_mawile }
}




