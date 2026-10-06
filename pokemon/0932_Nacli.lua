-- Nacli 932
local nacli = {
  name = "nacli",
  pos = PokemonSprites["nacli"].base.pos,
  config = {extra = {rounds = 5}},
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.rounds}}
  end,
  rarity = 1,
  cost = 4,
  gen = 9,
  stage = "Basic",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  designer = "MagerBluetooth",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    -- Enhance a random unenhanced card in the opening hand
    if context.first_hand_drawn then
      local unenhanced_cards = {}
      for i = 1, #G.hand.cards do
        if G.hand.cards[i].config and G.hand.cards[i].config.center and G.hand.cards[i].config.center.set ~= 'Enhanced' then
          unenhanced_cards[#unenhanced_cards+1] = G.hand.cards[i]
        end
      end
      
      if #unenhanced_cards > 0 then
        local target_card = pseudorandom_element(unenhanced_cards, 'nacli')
        local random_enhancement = SMODS.poll_enhancement({options = {"m_bonus", "m_mult", "m_wild", "m_glass", "m_steel", "m_gold", "m_lucky", "m_stone", "m_poke_seed"}, guaranteed = true})
        
        G.E_MANAGER:add_event(Event({
          func = function()
            target_card:set_ability(G.P_CENTERS[random_enhancement], nil, true)
            target_card:juice_up()
            return true
          end
        }))
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('poke_salt_cure_ex'), colour = G.C.CHIPS})
      end
    end

    return pokermon.level_evo(self, card, context, "j_Gem_naclstack")
  end,
  attributes = {"enhancements", "round_evo"},
}

-- Naclstack 933
local naclstack = {
  name = "naclstack",
  pos = PokemonSprites["naclstack"].base.pos,
  config = {extra = {rounds = 5}},
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 6,
  gen = 9,
  stage = "One",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  designer = "MagerBluetooth",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    -- Enhance a random unenhanced card in hand after each hand is played
    if context.after and not context.blueprint then
      local unenhanced_cards = {}
      for i = 1, #G.hand.cards do
        if G.hand.cards[i].config and G.hand.cards[i].config.center and G.hand.cards[i].config.center.set ~= 'Enhanced' then
          unenhanced_cards[#unenhanced_cards+1] = G.hand.cards[i]
        end
      end

      if #unenhanced_cards > 0 then
        local target_card = pseudorandom_element(unenhanced_cards, 'naclstack')
        local random_enhancement = SMODS.poll_enhancement({options = {"m_bonus", "m_mult", "m_wild", "m_glass", "m_steel", "m_gold", "m_lucky", "m_stone", "m_poke_seed"}, guaranteed = true})
        
        G.E_MANAGER:add_event(Event({
          func = function()
            target_card:set_ability(G.P_CENTERS[random_enhancement], nil, true)
            target_card:juice_up()
            return true
          end
        }))
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_salt_cure_ex'), colour = G.C.CHIPS})
      end
    end

    return pokermon.level_evo(self, card, context, "j_Gem_garganacl")
  end,
  attributes = {"enhancements", "round_evo"},
}

-- Garganacl 934
local garganacl = {
  name = "garganacl",
  pos = PokemonSprites["garganacl"].base.pos,
  config = {extra = {Xmult = 4, Xmult_minus = 0.1, Xmult_min = 1}},
  loc_vars = function(self, info_queue, center)
    local unenhanced_count = 0
    if G.playing_cards then
      for _, v in ipairs(G.playing_cards) do
        if v.config and v.config.center and v.config.center.set ~= 'Enhanced' then
          unenhanced_count = unenhanced_count + 1
        end
      end
    end
    local current_Xmult = math.max(center.ability.extra.Xmult_min, center.ability.extra.Xmult - (unenhanced_count * center.ability.extra.Xmult_minus))

    return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_minus, center.ability.extra.Xmult_min, current_Xmult, unenhanced_count}}
  end,
  rarity = "poke_safari",
  cost = 8,
  gen = 9,
  stage = "Two",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  designer = "MagerBluetooth",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    -- Provide Xmult scoring bonus based on unenhanced cards in deck
    if context.joker_main then
      local unenhanced_count = 0
      for i = 1, #G.playing_cards do
        if G.playing_cards[i].config and G.playing_cards[i].config.center and G.playing_cards[i].config.center.set ~= 'Enhanced' then
          unenhanced_count = unenhanced_count + 1
        end
      end
      
      local final_Xmult = math.max(card.ability.extra.Xmult_min, card.ability.extra.Xmult - (unenhanced_count * card.ability.extra.Xmult_minus))
      
      return {
        Xmult = final_Xmult
      }
    end

    -- Enhance a single random unenhanced card in hand after each played hand
    if context.after and not context.blueprint then
      local unenhanced_cards = {}
      for i = 1, #G.hand.cards do
        if G.hand.cards[i].config and G.hand.cards[i].config.center and G.hand.cards[i].config.center.set ~= 'Enhanced' then
          unenhanced_cards[#unenhanced_cards+1] = G.hand.cards[i]
        end
      end

      if #unenhanced_cards > 0 then
        local target_card = pseudorandom_element(unenhanced_cards, 'garganacl')
        local random_enhancement = SMODS.poll_enhancement({options = {"m_bonus", "m_mult", "m_wild", "m_glass", "m_steel", "m_gold", "m_lucky", "m_stone", "m_poke_seed"}, guaranteed = true})
        
        G.E_MANAGER:add_event(Event({
          func = function()
            target_card:set_ability(G.P_CENTERS[random_enhancement], nil, true)
            target_card:juice_up()
            return true
          end
        }))
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "localize('poke_salt_cure_ex)", colour = G.C.CHIPS})
      end
    end
  end,
  attributes = {"xmult", "enhancements", "modify_card"},
}

return {
  config_key = 'Nacli',
  list = { nacli, naclstack, garganacl },
}