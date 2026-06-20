-- Alolan Marowak
local alolan_marowak={
  name = "alolan_marowak",
  Gem_inject_prefix = "poke",
  pos = {x = 6, y = 4},
  config = {extra = {xmult = 1, Xmult_mod = 0.4}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.c_poke_thickclub
    local count = #find_joker('thickclub')
    local xmult = center.ability.extra.xmult + center.ability.extra.Xmult_mod * count
    return { vars = {center.ability.extra.xmult, center.ability.extra.Xmult_mod,
                     xmult}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Fire",
  atlas = "AtlasJokersBasicGen01",
  gen = 1,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
        if context.selling_card and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.Xmult_mod
            return {
                message = localize('k_upgrade_ex')
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.GAME.blind.boss and card.ability.extra.xmult > 1 then
                card.ability.extra.xmult = 1
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
         if context.cardarea == G.jokers and context.scoring_hand then
          local count = #find_joker('thickclub')
            return {
              colour = G.C.XMULT,
              xmult = card.ability.extra.xmult + card.ability.extra.Xmult_mod * count
            }
        end
     end
  end,
}

init = function()
  local loc_vars_ref = SMODS.Joker.obj_table.j_poke_cubone.loc_vars
  assert(loc_vars_ref)
  SMODS.Joker:take_ownership('poke_cubone', {
    loc_vars = function(self, info_queue, center)
      local ret = loc_vars_ref(self, info_queue, center)
      if Gem_config.Cubone then ret.key = 'j_poke_cubone_Gem' end
      return ret
    end,
    item_req = "firestone",
    calculate = function(self, card, context)
      if context.joker_main then
        local count = #pokermon.get_consumeables() + #SMODS.find_card('c_poke_thickclub')
        if count > 0 then
          return { mult = card.ability.extra.mult * count }
        end
      end
      if context.using_consumeable then
        card.ability.extra.consumables_used = card.ability.extra.consumables_used + 1
      end

      -- evo checks
      return Gem_config.Cubone and pokermon.item_evo(self, card, context, "j_poke_alolan_marowak")
          or pokermon.scaling_evo(self, card, context, "j_poke_marowak", card.ability.extra.consumables_used, self.config.evo_rqmt)
    end,
    add_to_deck = function(self, card, from_debuff)
      pokermon.create_held_item("c_poke_thickclub")
      if Gem_config.Cubone and not from_debuff then
        -- Since the evolution code checks `ability.extra.item_req` and not `config.center.item_req` we have to do extra work.
        card.ability.extra.item_req = copy_table(card.config.center.item_req)
      end
    end
  }, true)
  pokermon.add_to_family("marowak", "alolan_marowak")
end

return {
  config_key = "Cubone",
  init = init,
  list = { alolan_marowak }
}
