SMODS.Atlas{
  key = "aime",
  px = 71,
  py = 95,
  path = "aime.png"
}

local joker = {
  key = "aime",
  loc_txt = {
    name = "Aime Card",
    text = {
      "Adds {C:mult}x#1#{} Mult for",
      "every {C:Attention}Joker{} triggered",
      "{C:inactive}(Currently {C:mult}x#2#{} {C:inactive}Mult){}"
    }
  },
  config = { extra = { x_mult = 0.05 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult, card.ability.x_mult } }
  end,
  atlas = "aime",
  rarity = 3,
  cost = 9,
  blueprint_compat = true,
  discovered = true,
  calculate = function(self, card, context)
    if context.post_trigger then
      card.ability.x_mult = card.ability.x_mult + card.ability.extra.x_mult
      G.E_MANAGER:add_event(Event({
        func = function()
          (context.blueprint_card or card):juice_up(0.5, 0.5)
          return true
        end,
      }))
      card_eval_status_text(card, 'extra', card.ability.extra.x_mult, nil, nil, {
        message = "Data saved!",
        colour = G.C.ATTENTION
      })
    end

    if context.joker_main then
      return { xmult = card.ability.x_mult }
    end
  end
}

SMODS.Joker(joker)
