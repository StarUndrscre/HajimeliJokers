SMODS.Atlas{
  key = "glitch",
  px = 69,
  py = 93,
  path = "glitch.png"
}

local joker = {
  key = "glitch",
  loc_txt = {
    name = "Glitch",
    text = {
      "Copies ability of a",
      "random {C:attention}Joker{} in hand"
    }
  },
  atlas = "glitch",
  rarity = 3,
  cost = 8,
  blueprint_compat = true,
  discovered = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local other_joker = pseudorandom_element(G.jokers.cards, pseudoseed('glitch'))

      if other_joker == self then
        other_joker = pseudorandom_element(G.jokers.cards, pseudoseed('glitch_not_self_please'))
      end

      if other_joker.config.center.blueprint_compat == false then
        other_joker = pseudorandom_element(G.jokers.cards, pseudoseed('glitch_compatible_please'))
      end

      if other_joker and other_joker.config.center.blueprint_compat then
        context.blueprint_card = card
        G.E_MANAGER:add_event(Event({
          trigger = immediate,
          func = function()
            other_joker:juice_up(0.3, 0.3)
            return true
          end
        }))
        other_joker:calculate_joker(context)
      end
    end
  end
}

SMODS.Joker(joker)
