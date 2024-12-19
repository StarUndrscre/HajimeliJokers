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
      "{C:inactive,s:0.8}(#2#.#3#/#4#.#5#){}"
    }
  },
  config = { extra = { 
    money = 10,
    player_stopwatch = {
      s = 0,
      ms = 0,
    },
    time_required = {
      s = 0,
      ms = 0,
    }
  } },
  loc_vars = function(self, info_queue, card) -- yes i know this looks messy, but it works, okay?
    local time_required_visual = {
      s = "",
      ms = ""
    }
    if card.ability.extra.time_required.s <= 9 and card.ability.extra.time_required.s >= 0 then
      time_required_visual.s = "0" .. card.ability.extra.time_required.s
    end
    if card.ability.extra.time_required.ms <= 9 and card.ability.extra.time_required.ms >= 0 then
      time_required_visual.ms = "0" .. card.ability.extra.time_required.ms
    end

    local player_stopwatch_visual = {
      s = "",
      ms = ""
    }
    if card.ability.extra.player_stopwatch.s <= 9 and card.ability.extra.player_stopwatch.s >= 0 then
      player_stopwatch_visual.s = "0" .. card.ability.extra.player_stopwatch.s
    end
    if card.ability.extra.player_stopwatch.ms <= 9 and card.ability.extra.player_stopwatch.ms >= 0 then
      player_stopwatch_visual.ms = "0" .. card.ability.extra.player_stopwatch.ms
    end
    return { vars = { 
      card.ability.extra.money, 
      player_stopwatch_visual.s,
      player_stopwatch_visual.ms, 
      time_required_visual.s,
      time_required_visual.ms,
    } }
  end,
  atlas = "placeholder",
  rarity = 2,
  cost = 4,
  blueprint_compat = true,
  discovered = true,
  update = function(self, card, dt)
    local plr_st = {}
    local time_req = {}

    plr_st.s = card.ability.extra.player_stopwatch.s
    plr_st.ms = card.ability.extra.player_stopwatch.ms
    time_req.s = card.ability.extra.time_required.s
    time_req.ms = card.ability.extra.time_required.ms

    plr_st.s = plr_st.s + math.floor(dt)
    plr_st.ms = plr_st.ms + (round(dt, 2))%1
  end,
  calculate = function(self, card, context)
    local plr_st = {}
    local time_req = {}

    plr_st.s = card.ability.extra.player_stopwatch.s
    plr_st.ms = card.ability.extra.player_stopwatch.ms
    time_req.s = card.ability.extra.time_required.s
    time_req.ms = card.ability.extra.time_required.ms

    -- local update_ref = Game.update
    -- function Game:update(dt)
    --   plr_st.s = plr_st.s + math.floor(dt)
    --   plr_st.ms = plr_st.ms + (round(dt, 2))%1
    --   update_ref(self, dt)
    -- end

    if context.setting_blind and context.blind == G.GAME.round_resets.blind then
      -- start timer
    end

    if context.scoring_hand and context.cardarea == G.jokers and context.before then
      -- pause timer
    end

    if context.scoring_hand and context.cardarea == G.jokers and context.after then
      -- resume timer
    end

    if context.end_of_round then
      -- stop timer
      -- check if under time requirement and give money
      -- reset timer
      -- if new ante, lower time requirement
    end
  end
}

SMODS.Joker(joker)
