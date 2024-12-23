-- SMODS.Atlas{
--   key = "speedrun",
--   px = 71,
--   py = 95,
--   path = "speedrun.png"
-- }

-- Gives $10 if Blind is
-- completed under a certain time
-- (00.00/XX.XX)

-- use cryptid's the clock blind as a base?
-- time scales based on ante
-- stop timer when hand is being scored
-- probably gonna have to deal with game speed
-- time required multiplied by game speed??

-- possible variable names
-- player_stopwatch 
-- time_required
-- time_required_visual
-- game_speed = G.SETTINGS.GAME_SPEED
-- player_being_scored
-- player_in_blind

-- https://stackoverflow.com/a/41534034
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

local joker = {
  key = "speedrun",
  loc_txt = {
    name = "Speedrun",
    text = {
      "Gives {C:money}$#1#{} if Blind is completed",
      "{C:important}under a certain time{}"
    }
  },
  config = { extra = { 
    money = 10,
    player_stopwatch = 0,
    time_required = 60,
    player_in_blind = false,
    player_being_scored = false,
    time_elasped = 0
  } },
  loc_vars = function(self, info_queue, card)
    return { vars = { 
      card.ability.extra.money
    } }
  end,
  atlas = "placeholder",
  rarity = 2,
  cost = 4,
  blueprint_compat = true,
  discovered = true,
  calculate = function(self, card, context)
    local ante = G.GAME.round_resets.ante
    card.ability.extra.time_required = 65 - (5*ante)
    if card.ability.extra.time_required <= 15 then
      card.ability.extra.time_required = 15
    end

    if context.setting_blind and context.blind == G.GAME.round_resets.blind then
      card.ability.extra.player_in_blind = true
      G.E_MANAGER:add_event(Event({
        func = function()
          card.ability.extra.player_in_blind = true
          return true
        end,
      }))
    end

    if context.scoring_hand and context.cardarea == G.jokers and context.before then
      card.ability.extra.player_being_scored = true
      G.E_MANAGER:add_event(Event({
        func = function()
          card.ability.extra.player_being_scored = true
          return true
        end,
      }))
    end

    if context.scoring_hand and context.cardarea == G.jokers and context.after then
      G.E_MANAGER:add_event(Event({
        func = function()
          card.ability.extra.player_being_scored = false
          return true
        end,
      }))
    end

    if context.end_of_round then
      G.E_MANAGER:add_event(Event({
        func = function()
          card.ability.extra.player_in_blind = false
          return true
        end,
      }))
    end

    if context.ending_shop then
      card.ability.extra.player_stopwatch = 0
    end
  end,
  update = function(self, card, dt)
    if (card.ability.extra.player_in_blind == false) or (card.ability.extra.player_being_scored) then return end
    if G.GAME.blind.chips <= G.GAME.chips then return end -- if we're over the score then stop counting up
    card.ability.extra.player_stopwatch = (card.ability.extra.player_stopwatch + round(dt, 2))
  end,
  calc_dollar_bonus = function(self, card)
    if card.ability.extra.player_stopwatch <= card.ability.extra.time_required then
      return card.ability.extra.money
    end
  end,
}

SMODS.Joker(joker)
