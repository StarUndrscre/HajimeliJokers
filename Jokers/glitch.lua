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
      "Copies ability of",
      "a random {C:attention}Joker{}"
    }
  },
  atlas = "glitch",
  rarity = 3,
  cost = 9,
  blueprint_compat = true,
  discovered = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local i = 2
      local other_joker = pseudorandom_element(G.jokers.cards, pseudoseed('glitch'))
      local rolled_valid = false
      
      if not other_joker == card and other_joker.config.center.blueprint_compat then rolled_valid = true end

      -- we rolled a non-compatible blueprint card/we rolled ourselves... try to reroll again
      while not rolled_valid do
        other_joker = pseudorandom_element(G.jokers.cards, pseudoseed('glitch' .. tostring(i)))
        print(other_joker.ability.name)

        if other_joker == card or not other_joker.config.center.blueprint_compat then
          i = i + 1 -- what do you MEAN += doesn't exist...
        else
          rolled_valid = true
        end
      end

      if other_joker and other_joker.config.center.blueprint_compat then
        print("copying " .. other_joker.ability.name)
        G.E_MANAGER:add_event(Event({
          func = function()
            card:juice_up()
            other_joker:juice_up(0.3, 0.4)
            return true
          end
        }))

        context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
        context.blueprint_card = context.blueprint_card or card
        context.glitch = (context.glitch and (context.glitch + 1)) or 1
        if other_joker.config.center.calculate then
          other_joker.config.center.calculate(other_joker, card, context)
        else
          local other_joker_ret = other_joker:calculate_joker(context)
          if other_joker_ret then 
            other_joker_ret.card = context.blueprint_card or card
            other_joker_ret.colour = G.C.BLUE
          end
        end
      end
    end
  end
}

SMODS.Joker(joker)
