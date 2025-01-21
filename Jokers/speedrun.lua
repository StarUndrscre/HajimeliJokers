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

-- this feels like a bad idea but we're trying it anyway since i have no options ~star
if G.GAME then
  G.GAME.hjml_speedrun_timer = 0
  G.GAME.hjml_speedrun_timer_old = 0
end

function hjml_speedrun_update_timer(time)
  G.GAME.hjml_speedrun_timer_old = G.GAME_hjml_speedrun_timer
  G.GAME.hjml_speedrun_timer = time
end

local upd = Game.update
function Game:update(dt)
  upd(self, dt)
  if G.GAME.hjml_speedrun_timer then
    if G.GAME.hjml_speedrun_timer ~= G.GAME.hjml_speedrun_timer_old then
      if G.jokers then
        for i = 1, #G.jokers.cards do
          if G.jokers.cards[i].ability.name == "j_HJML_speedrun" then
            local card = G.jokers.cards[i]
            if card.ability_UIBox_table then
              card.ability_UIBox_table.main[3][1].config.text = tostring(G.GAME.hjml_speedrun_timer)
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
      "{C:important}under a certain time{}",
      "0/0"
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
  blueprint_compat = false,
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
    hjml_speedrun_update_timer(card.ability.extra.player_stopwatch)
  end,
  calc_dollar_bonus = function(self, card)
    if card.ability.extra.player_stopwatch <= card.ability.extra.time_required then
      return card.ability.extra.money
    end
  end,
  generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    local target = {
      type = 'descriptions',
      key = self.key,
      set = self.set,
      nodes = desc_nodes,
      vars = specific_vars or {}
    }
    local res = {}
    if self.loc_vars and type(self.loc_vars) == 'function' then
      res = self:loc_vars(info_queue, card) or {}
      target.vars = res.vars or target.vars
      target.key = res.key or target.key
      target.set = res.set or target.set
      target.scale = res.scale
      target.text_colour = res.text_colour
    end
    if desc_nodes == full_UI_table.main and not full_UI_table.name then
      full_UI_table.name = self.set == 'Enhanced' and 'temp_value' or localize { type = 'name', set = target.set, key = target.key, nodes = full_UI_table.name }
    elseif desc_nodes ~= full_UI_table.main and not desc_nodes.name and self.set ~= 'Enhanced' then
      desc_nodes.name = localize{type = 'name_text', key = target.key, set = target.set } 
    end
    if specific_vars and specific_vars.debuffed and not res.replace_debuff then
      target = { type = 'other', key = 'debuffed_' ..
      (specific_vars.playing_card and 'playing_card' or 'default'), nodes = desc_nodes }
    end
    if res.main_start then
      desc_nodes[#desc_nodes + 1] = res.main_start
    end
    localize(target)
    if res.main_end then
      desc_nodes[#desc_nodes + 1] = res.main_end
    end
    desc_nodes.background_colour = res.background_colour
  end
}

SMODS.Joker(joker)
