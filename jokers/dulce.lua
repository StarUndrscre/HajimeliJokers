SMODS.Atlas{
  key = "dulce",
  px = 71,
  py = 95,
  path = "dulce.png"
}

local joker = {
  key = "dulce",
  loc_txt = {
    name = "Dulce",
    text = {
      "placeholder"
    }
  },
  atlas = "dulce",
  rarity = 2,
  cost = 5,
  blueprint_compat = true,
  discovered = true,
  calculate = function(self, card, context)
    if context.joker_main then
      
    end
  end
}

-- SMODS.Joker(joker)
