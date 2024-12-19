-- SMODS.Atlas{
--   key = "placeholder",
--   px = 71,
--   py = 95,
--   path = "placeholder.png"
-- }

local joker = {
  key = "placeholder",
  loc_txt = {
    name = "placeholder",
    text = {
      "placeholder"
    }
  },
  atlas = "placeholder",
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
