SMODS.Joker{
  key = "glitch",
  loc_txt = {
    name = "Glitch",
    text = {
      "Copies ability of a random {C:joker}Joker {} in hand"
    }
  },
  rarity = 3,
  cost = 8,
  calculate = function(self, card, context)
    if context.joker_main then
      local other_joker = nil
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == self then other_joker = G.jokers.cards[i+1] end
      end
      if other_joker and other_joker ~= self then
        context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
        context.blueprint_card = context.blueprint_card or self
        if context.blueprint > #G.jokers.cards + 1 then return end
        local other_joker_ret = other_joker:calculate_joker(context)
        if other_joker_ret then 
          other_joker_ret.card = context.blueprint_card or self
          other_joker_ret.colour = G.C.BLUE
          return other_joker_ret
        end
      end
    end
  end
}
