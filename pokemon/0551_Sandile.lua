

-- Sandile and Krookodile proc on both small and big blinds, figure out how to seperate the two

-- Sandile 551
local sandile={
  name = "sandile",
  
  pos = PokemonSprites["sandile"].base.pos,
  config = { extra = { money = 1, money_mod = 1}, evo_rqmt = 3 },
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return { vars = { center.ability.extra.money, center.ability.extra.money_mod } }
  end,
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  perishable_compat = false,
  blueprint_compat = false,
  eternal_compat = true,
    calculate = function(self, card, context)
    -- Scale money
        if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.name == 'Small Blind' then
            card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MONEY,
                pokermon.scaling_evo(self, card, context, "j_Gem_krokorok", card.ability.extra.money, self.config.evo_rqmt)
            }
        end
        return pokermon.scaling_evo(self, card, context, "j_Gem_krokorok", card.ability.extra.money, self.config.evo_rqmt)
    end,
    -- End of round money
    calc_dollar_bonus = function(self, card)
        return pokermon.ease_poke_dollars(card, "sandile", card.ability.extra.money, true)
    end
}

-- Krokorok 552
local krokorok={
  name = "krokorok",
  
  pos = PokemonSprites["krokorok"].base.pos,
  config = { extra = { money = 3, Xmult = 1, Xmult_mod = .25}, evo_rqmt = 1.5 },
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    return { vars = { center.ability.extra.money, center.ability.extra.Xmult, center.ability.extra.Xmult_mod } }
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
    -- Give Xmult
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    -- Scale Xmult
        if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.name == 'Big Blind' then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MONEY,
                pokermon.scaling_evo(self, card, context, "j_Gem_krookodile", card.ability.extra.Xmult, self.config.evo_rqmt)
            }
        end
        return pokermon.scaling_evo(self, card, context, "j_Gem_krookodile", card.ability.extra.Xmult, self.config.evo_rqmt)
    end,
    -- End of round money
    calc_dollar_bonus = function(self, card)
        return pokermon.ease_poke_dollars(card, "krokorok", card.ability.extra.money, true)
    end
}

-- Krookodile 553
local krookodile={
  name = "krookodile",
  
  pos = PokemonSprites["krookodile"].base.pos,
  config = { extra = { money = 3, money_mod = 1, Xmult = 1.5, Xmult_mod = .25} },
  loc_vars = function(self, info_queue, card)
    pokermon.type_tooltip(self, info_queue, card)
    return { vars = { card.ability.extra.money, card.ability.extra.money_mod, card.ability.extra.Xmult, card.ability.extra.Xmult_mod } }
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
  gen = 5,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
    calculate = function(self, card, context)
    -- Give Xmult
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    -- Scale Xmult and Money
        if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
            card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MONEY
            }
        end
    end,
    -- End of round money
    calc_dollar_bonus = function(self, card)
        return pokermon.ease_poke_dollars(card, "krookodile", card.ability.extra.money, true)
    end
}

return {
  config_key = "Sandile",
  list = { sandile, krokorok, krookodile}
}

