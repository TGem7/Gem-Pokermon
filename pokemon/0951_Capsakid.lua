function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- Capsakid
local capsakid = {
  name = "capsakid",
  
  pos = PokemonSprites["capsakid"].base.pos,
  config = {extra = {mult = 6}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_seed
    info_queue[#info_queue+1] = G.P_CENTERS.c_poke_firestone
    return {vars = {center.ability.extra.mult}}
  end,
  rarity = 1, 
  cost = 4, 
  enhancement_gate = 'm_poke_seed',
  item_req = "firestone",
  stage = "Basic", 
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and not context.end_of_round and context.cardarea == G.play and not context.other_card.debuff and SMODS.has_enhancement(context.other_card,"m_poke_seed") then
      return {
            message = localize('poke_spicy_ex'),
            mult = card.ability.extra.mult,
            card = card
      }
    end
    if context.individual and not context.end_of_round and context.cardarea == G.hand then
      if SMODS.has_enhancement(context.other_card, 'm_poke_seed') then 
          return {
            message = localize('poke_spicy_ex'),
            h_mult = card.ability.extra.mult,
            card = card,
          }
      end
    end
    return item_evo(self, card, context, "j_Gem_scovillain")
  end
}

-- Scovillain
local scovillain = {
  name = "scovillain",
  pos = PokemonSprites["scovillain"].base.pos,
  config = {extra = {Xmult_multi = 2}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_mult
      info_queue[#info_queue+1] = G.P_CENTERS.m_poke_seed
    end
    return {vars = {center.ability.extra.Xmult_multi}}
  end,
  rarity = "poke_safari", 
  cost = 8, 
  stage = "One", 
  ptype = "Fire",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn and not context.blueprint then
      local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end
      if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_mult') and G.GAME.current_round.hands_played == 0 and not context.blueprint then
        local all_mult = true
        for k, v in pairs(context.scoring_hand) do
          if not SMODS.has_enhancement(v, "m_mult") then
            all_mult = false
          end
        end
        if all_mult then
          local cards_held = {}
            for k, v in ipairs(G.hand.cards) do
              table.insert(cards_held, v)
            end
              pseudoshuffle(cards_held, pseudoseed('blacksludge'))
              local limit = math.min(#cards_held, 1)
              for i = 1, limit do
                poke_convert_cards_to(cards_held[i], {mod_conv = 'm_poke_flower'}, true, true)
                cards_held[i]:juice_up()
              end
        end
      end
        if context.individual and not context.end_of_round and context.cardarea == G.hand then
          local suit_number = next(SMODS.find_card('j_poke_roserade')) and 3 or 4
          if poke_suit_check(context.scoring_hand, suit_number) then
      if SMODS.has_enhancement(context.other_card, 'm_poke_seed') then 
          return {
            message = localize('poke_spicy_ex'),
            xmult = card.ability.extra.Xmult_multi,
            card = card,
          }
      elseif SMODS.has_enhancement(context.other_card, 'm_poke_flower') then 
          return {
            message = localize('poke_spicy_ex'),
            xmult = card.ability.extra.Xmult_multi,
            card = card,
          }
      end
            end
        end
  end,
  megas = { "mega_scovillain" },
}

-- Mega Scovillain
local mega_scovillain = {
  name = "mega_scovillain",
  pos = PokemonSprites["scovillain"].base.pos,
  config = {extra = {Xmult_multi = 3}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = G.P_CENTERS.m_poke_seed
    end
    return {vars = {center.ability.extra.Xmult_multi}}
  end,
  rarity = "poke_mega", 
  cost = 12, 
  stage = "Mega", 
  ptype = "Fire",
  atlas = "AtlasJokersBasicNatdex",
  gen = 9,
  blueprint_compat = true,
  calculate = function(self, card, context)
        if context.individual and not context.end_of_round and context.cardarea == G.hand then
          local suit_number = next(SMODS.find_card('j_poke_roserade')) and 3 or 4
          if poke_suit_check(context.scoring_hand, suit_number) then
      if SMODS.has_enhancement(context.other_card, 'm_poke_seed') then 
          return {
            message = localize('poke_spicy_ex'),
            xmult = card.ability.extra.Xmult_multi,
            card = card,
          }
      elseif SMODS.has_enhancement(context.other_card, 'm_poke_flower') then 
          return {
            message = localize('poke_spicy_ex'),
            xmult = card.ability.extra.Xmult_multi,
            card = card,
          }
      end
            end
        end
  end
}

return {
  name = "Gem's Capsakid",
  enabled = Gem_config.Capsakid or false,
  list = { capsakid, scovillain, mega_scovillain }
}




