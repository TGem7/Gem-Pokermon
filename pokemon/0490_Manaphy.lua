-- Manaphy 490
local manaphy={
  name = "manaphy", 
  pos = {x = 18, y = 32}, 
  soul_pos = {x = 19, y = 32}, 
  config = {extra = {Xmult = 2, Xmult_mod = .2, suit = "Hearts", card_threshold = 20, count = 0}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    local phiones = #SMODS.find_card("j_Gem_phione")
    local xmult_mod = center.ability.extra.Xmult_mod + (0.04 * phiones)
    return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod, center.ability.extra.suit, math.max(0, center.ability.extra.card_threshold - center.ability.extra.count), xmult_mod}}
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Water",
  atlas = "AtlasJokersBasicNatdex",
  gen = 4,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
  if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) and not context.blueprint then
    if card.ability.extra.count < card.ability.extra.card_threshold then
      card.ability.extra.count = card.ability.extra.count + 1
    end
    if card.ability.extra.count >= card.ability.extra.card_threshold then
      card.ability.extra.Xmult_mod = card.ability.extra.Xmult_mod + (0.04 * #SMODS.find_card("j_Gem_phione"))
        SMODS.scale_card(card, {
          ref_value = 'Xmult',
          scalar_value = 'Xmult_mod',
          operation = function(ref_table, ref_value, initial, change)
            ref_table[ref_value] = initial + change * #pokermon.find_pokemon_type("Water")
          end,
          message_colour = G.C.MULT,
          message = localize('poke_take_heart_ex')
        })
        card.ability.extra.count = 0
        card.ability.extra.Xmult_mod = card.ability.extra.Xmult_mod - (0.04 * #SMODS.find_card("j_Gem_phione"))
        SMODS.add_card{set = "Joker", key = "j_Gem_manaphy_egg", edition = "e_negative"}
        return {
          message = localize('poke_take_heart_ex'), 
          colour = G.C.MULT,
        }
    end
  end
    if context.joker_main then
      return {
        Xmult = card.ability.extra.Xmult
      }
    end
  end,
}

local function is_egg_helper(card)
  local name = ''
  if not card.name and card.ability.name then
    name = card.ability.name
  end
  if name == "rolycoly" or name == "carkol" or name == "coalossal" then
    --print("STEAM ENGINE")
    return true
  elseif name == "slugma" or name == "magcargo" or name == "camerupt" then
    --print("MAGMA ARMOR")
    return true
  elseif name == "magby" or name == "magmar" or name == "magmortar" then
    --print("FLAME BODY")
    return true
  elseif name == "litwick" or name == "lampent" or name == "chandelure" then
    --print("FLAME BODY")
    return true
  elseif name == "larvesta" or name == "volcarona" then
    --print("FLAME BODY")
    return true
  elseif name == "fletchinder" or name == "talonflame" then
    --print("FLAME BODY")
    return true
  elseif name == "sizzlipede" or name == "centiskorch" then
    --print("FLAME BODY")
    return true
  elseif name == "moltres" then
    --print("FLAME BODY")
    return true
  elseif name == "heatran" then
    --print("FLAME BODY")
    return true
  elseif name == "charcadet" then
    --print("FLAME BODY")
    return true
  end
end

local manaphy_egg = {
  name = "manaphy_egg",
  pos = {x = 2, y = 1},
  config = {extra = {key = nil, rounds = 3}},
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.rounds}}
  end,
  rarity = 4,
  cost = 1,
  stage = "Legendary",
  atlas = "AtlasJokersBasicOthers",
  blueprint_compat = false,
  eternal_compat = false,
  perishable_compat = false,
  rental_compat = false,
  custom_pool_func = true,
  in_pool = function(self)
    return false
  end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
      local adjacent = 0
      local adjacent_jokers = pokermon.get_adjacent_jokers(card)
      for i = 1, #adjacent_jokers do
        if is_egg_helper(adjacent_jokers[i]) then adjacent = adjacent + 1 end
      end
      card.ability.extra.rounds = card.ability.extra.rounds - 1
      if next(SMODS.find_card('j_poke_oologist')) then
        if (adjacent + #SMODS.find_card('c_poke_fire_energy')) > 0 and pseudorandom('egg') < (adjacent + #SMODS.find_card('c_poke_fire_energy'))/4 then
          card.ability.extra.rounds = card.ability.extra.rounds - 1
        end
        card.ability.extra.rounds = card.ability.extra.rounds - adjacent/4
      end
      if card.ability.extra.rounds <= 1 then
        local eval = function(card) return card.ability.extra.rounds and card.ability.extra.rounds <= 1 end
        juice_card_until(card, eval, true)
      end
      if card.ability.extra.rounds <= 0 then
        SMODS.destroy_cards(card, nil, true)
        SMODS.add_card{set = "Joker", key = "j_Gem_phione", edition = "e_negative"}
        return {
        message = localize('poke_crack_ex'),
        }
      else
        return {
            message = localize('poke_shake_ex')
        }
      end
    end
  end
}

-- Phione 489
local phione={
  name = "phione", 
  pos = {x = 16, y = 32}, 
  soul_pos = {x = 17, y = 32}, 
  config = {extra = {manaphy_xmult_increase = 0.04}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.manaphy_xmult_increase}}
  end,
  rarity = 4,
  cost = 4,
  stage = "Legendary",
  ptype = "Water",
  atlas = "AtlasJokersBasicNatdex",
  gen = 4,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  in_pool = function(self)
    return false
  end,
  calculate = function(self, card, context)
  end,
}

return {
  config_key = "Manaphy",
  list = { manaphy, manaphy_egg, phione }
}

