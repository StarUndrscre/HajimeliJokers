-- SMODS.Atlas{
--   key = "club_setback",
--   px = 69,
--   py = 93,
--   path = "club_setback.png"
-- }

-- SMODS.Atlas{
--   key = "heart_setback",
--   px = 69,
--   py = 93,
--   path = "heart_setback.png"
-- }

-- SMODS.Atlas{
--   key = "diamond_setback",
--   px = 69,
--   py = 93,
--   path = "diamond_setback.png"
-- }

-- https://stackoverflow.com/questions/2421695/first-character-uppercase-lua
function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

local function held_in(suit)
  SMODS.Atlas{
    key = suit .. "_setback",
    px = 69,
    py = 93,
    path = suit .. "_setback.png"
  }

  local joker = {
    key = suit .. "_setback",
    loc_txt = {
      name = "Held in " .. firstToUpper(suit) .. "s",
      text = {
        "Each {C:" .. suit .. "s}" .. firstToUpper(suit) .. "{} card",
        "held in hand",
        "gives {C:chips}+#1#{} Chips"
      }
    },
    config = { extra = { chip = 20, suit = firstToUpper(suit) .. "s" } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.chip } }
    end,
    atlas = suit .. "_setback",
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
              local card_to_juice = card
              if context.blueprint_card then
                card_to_juice = context.blueprint_card
              end
              
              card_to_juice:juice_up()
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
  return joker
end

SMODS.Joker(held_in("club"))
SMODS.Joker(held_in("heart"))
SMODS.Joker(held_in("diamond"))
