SMODS.Atlas{
  key = "club_setback",
  px = 69,
  py = 93,
  path = "club_setback.png"
}

local joker = {
  key = "club_setback",
  loc_txt = {
    name = "Club Setback",
    text = {
      "Cards with {C:clubs}Club{} suit",
      "give {C:chips}+#1#{} Chips",
      "when held in hand"
    }
  },
  config = { extra = { chip = 20, suit = "Clubs" } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chip } }
  end,
  atlas = "club_setback",
  rarity = 1,
  cost = 4,
  blueprint_compat = true,
  discovered = true,
  calculate = function(self, card, context)
    if 
      context.individual 
      and context.cardarea == G.hand 
      and not context.after 
      and not context.before 
      and not context.end_of_round 
    then
      if context.other_card:is_suit(card.ability.extra.suit) then
        G.E_MANAGER:add_event(Event({
          trigger = immediate,
          func = function()
            card:juice_up()
            return true
          end
        }))
        SMODS.eval_this(context.other_card, {
          chip_mod = card.ability.extra.chip,
          message = localize {type = 'variable', key = 'a_chips', vars = {card.ability.extra.chip}}
        })
      end
    end
  end
}

SMODS.Joker(joker)
