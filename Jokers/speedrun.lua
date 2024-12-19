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
      "{C:important}under a certain time{}",
      "{C:inactive,s:0.8}(#2#/#3#){}"
    }
  },
  config = { extra = { 
    money = 10,
    player_stopwatch = 0,
    time_required = 0,
    player_in_blind = false,
    player_being_scored = false,
    time_elasped = 0
  } },
  loc_vars = function(self, info_queue, card)
    return { vars = { 
      card.ability.extra.money, 
      card.ability.extra.player_stopwatch,
      card.ability.extra.time_required,
    } }
  end,
  atlas = "placeholder",
  rarity = 2,
  cost = 4,
  blueprint_compat = true,
  discovered = true,
  calculate = function(self, card, context)
    -- local update_ref = Game.update
    -- function Game:update(dt)
    --   plr_st.s = plr_st.s + math.floor(dt)
    --   plr_st.ms = plr_st.ms + (round(dt, 2))%1
    --   update_ref(self, dt)
    -- end

    if context.setting_blind and context.blind == G.GAME.round_resets.blind then
      card.ability.extra.player_in_blind = true

      card.ability.extra.time_required = 100
    end

    if context.scoring_hand and context.cardarea == G.jokers and context.before then
      card.ability.extra.player_being_scored = true
      print("being scored")
    end

    if context.scoring_hand and context.cardarea == G.jokers and context.after then
      card.ability.extra.player_being_scored = false
      print("not being scored")
    end

    if context.end_of_round then
      -- stop timer
      -- check if under time requirement and give money
      -- if new ante, lower time requirement
      card.ability.extra.player_in_blind = false
    end

    if context.leaving_shop then
      card.ability.extra.player_stopwatch = 0
    end
  end,
  update = function(self, card, dt)
    if (card.ability.extra.player_in_blind == false) or (card.ability.extra.player_being_scored) then return end
    card.ability.extra.player_stopwatch = (card.ability.extra.player_stopwatch + round(dt, 2))
  end,
  calc_dollar_bonus = function(self, card)
    if card.ability.extra.player_stopwatch <= card.ability.extra.time_required then
      return card.ability.extra.money
    end
  end,
}

SMODS.Joker(joker)
