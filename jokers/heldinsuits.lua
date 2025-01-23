-- https://stackoverflow.com/questions/2421695/first-character-uppercase-lua
function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

function printtable(table, indent)
  print(tostring(table))
  for index, value in pairs(table) do 
    print('    ' .. tostring(index) .. ' : ' .. tostring(value))
  end
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
      if context.joker_main and context.glitch then
        for _, other_card in pairs(G.hand.cards) do
          if other_card:is_suit(self.ability.extra.suit) then
            G.E_MANAGER:add_event(Event({
              trigger = immediate,
              func = function()
                self:juice_up(0.1, 0.1)
                card:juice_up()
                return true
              end
            }))

            SMODS.eval_this(other_card, {
              chip_mod = self.ability.extra.chip,
              message = localize {type = 'variable', key = 'a_chips', vars = {self.ability.extra.chip}}
            })
          end
        end
      end
      if context.joker_main and not context.glitch then
        for _, other_card in pairs(G.hand.cards) do
          if other_card:is_suit(card.ability.extra.suit) then
            G.E_MANAGER:add_event(Event({
              trigger = immediate,
              func = function()
                card:juice_up()
                return true
              end
            }))

            SMODS.eval_this(other_card, {
              chip_mod = card.ability.extra.chip,
              message = localize {type = 'variable', key = 'a_chips', vars = {card.ability.extra.chip}}
            })
          end
        end
      end
    end
  }
  return joker
end

SMODS.Joker(held_in("club"))
SMODS.Joker(held_in("heart"))
SMODS.Joker(held_in("diamond"))
SMODS.Joker(held_in("spade"))
