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

-- this feels like a bad idea but we're trying it anyway since i have no options ~star
function hjml_speedrun_update_timer(dt, init)
  if G.GAME.hjml_speedrun_timer then
    if not init then
      if G.GAME_hjml_speedrun_timer then
        G.GAME.hjml_speedrun_timer_old = G.GAME_hjml_speedrun_timer
      end

      G.GAME.hjml_speedrun_timer = G.GAME.hjml_speedrun_timer + dt
    elseif init then
      G.GAME.hjml_speedrun_timer = 0
    end

    G.GAME.hjml_speedrun_timer = G.GAME.hjml_speedrun_timer + dt

    -- I don't know why, I don't want to know why, I shouldn't
    -- have to wonder why, but for whatever reason this stupid
    -- timer isn't loading correctly unless we do this terribleness
    -- ( https://youtube.com/clip/UgkxJCA1dWmmpkehBimt4YG6PHMjq_EhhgcL )
    G.hjml_speedrun_exploit_prevention = G.GAME.hjml_speedrun_timer
  else
    -- https://cdn.discordapp.com/stickers/1054943787178274927.png
    G.GAME.hjml_speedrun_timer = G.GAME.hjml_speedrun_timer or 0
  end
end

local _start = Game.start_run
function Game:start_run(args)
  _start(self, args)
  if G.hjml_speedrun_exploit_prevention then
    self.GAME.hjml_speedrun_timer = G.hjml_speedrun_exploit_prevention
  end
end

local upd = Game.update
function Game:update(dt)
  upd(self, dt)

  if (G.STATE == G.STATES.SELECTING_HAND) and (not G.SETTINGS.paused) then
    hjml_speedrun_update_timer(dt)
  end

  if G.STATE == G.STATES.BLIND_SELECT then
    if G.GAME_hjml_speedrun_timer ~= 0 then
      hjml_speedrun_update_timer(0, true)
    end
  end

  if G.GAME.hjml_speedrun_timer then
    if G.GAME.hjml_speedrun_timer ~= G.GAME.hjml_speedrun_timer_old then
      if G.jokers then
        for i = 1, #G.jokers.cards do
          if G.jokers.cards[i].ability.name == "j_HJML_speedrun" then
            local card = G.jokers.cards[i]

            -- make sure there's always 2 decimal places
            local timer = "(" .. string.format("%2.2f", G.GAME.hjml_speedrun_timer) .. "/" .. tostring(card.ability.extra.time_required) .. ")"

            if card.ability_UIBox_table then
              card.ability_UIBox_table.main[3][1].config.text = timer
            end
            if card.children.h_popup then
              card.children.h_popup:recalculate()
            end
          end
        end
      end
    end
  end
end

local joker = {
  key = "speedrun",
  loc_txt = {
    name = "Speedrun",
    text = {
      "Gives {C:money}$#1#{} if Blind is completed",
      "{C:attention}under a certain time{}",
      "{C:inactive}(0.00/60){}",
      "{s:0.15} {}",
      "{C:red,s:0.75}Time requirement goes down{}",
      "{C:red,s:0.75}by {C:attention,s:0.75}5{C:red,s:0.75} per {C:attention,s:0.75}Ante{C:red,s:0.75} and caps at {C:attention,s:0.75}15{}"
    }
  },
  config = { extra = { 
    money = 10,
    time_required = 60
  } },
  loc_vars = function(self, info_queue, card)
    return { vars = { 
      card.ability.extra.money
    } }
  end,
  atlas = "placeholder",
  rarity = 2,
  cost = 4,
  blueprint_compat = false,
  discovered = true,
  calculate = function(self, card, context)
    local ante = G.GAME.round_resets.ante
    card.ability.extra.time_required = 65 - (5*ante)
    if card.ability.extra.time_required <= 15 then
      card.ability.extra.time_required = 15
    end
  end,
  calc_dollar_bonus = function(self, card)
    if G.GAME.hjml_speedrun_timer <= card.ability.extra.time_required then
      return card.ability.extra.money
    end
  end
}

SMODS.Joker(joker)
