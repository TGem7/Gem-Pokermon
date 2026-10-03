-- Komala 775
local komala={
  name = "komala",
  pos = PokemonSprites["komala"].base.pos,
  config = {extra = {scry = 2, retriggers = 1, targets = {{value = "Ace", id = "14"}, {value = "King", id = "13"}, {value = "Queen", id = "12"}}}},
  loc_vars = function(self, info_queue, center)
    pokermon.type_tooltip(self, info_queue, center)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'scry_cards'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"rank"}}
    local card_vars = {center.ability.extra.scry}
    pokermon.add_target_cards_to_vars(card_vars, center.ability.extra.targets)
    return {vars = card_vars}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Colorless",
  atlas = "AtlasJokersBasicNatdex",
  gen = 7,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
     for i=1, #card.ability.extra.targets do
      if context.other_card:get_id() == card.ability.extra.targets[i].id then
       return {
          message = localize('k_again_ex'),
          repetitions = card.ability.extra.retriggers,
          card = card
        }
      end
     end
    end
    if context.repetition and context.cardarea == G.poke_scry_view and (next(context.card_effects[1]) or #context.card_effects > 1) then
     for i=1, #card.ability.extra.targets do
      if context.other_card:get_id() == card.ability.extra.targets[i].id then
       return {
          message = localize('k_again_ex'),
          repetitions = card.ability.extra.retriggers,
          card = card
        }
      end
     end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = (G.GAME.poke_scry_amount or 0) + card.ability.extra.scry
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = math.max(0,(G.GAME.poke_scry_amount or 0) - card.ability.extra.scry)
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      self:set_nature(card)
    end
  end,
  set_nature = function(self,card)
    card.ability.extra.targets = pokermon.get_target_card_ranks("komala", 3, card.ability.extra.targets)
  end,
}



return {
  config_key = "Komala",
  list = {komala}
}



