SMODS.Atlas{
  key = "eamuse",
  px = 71,
  py = 95,
  path = "eamuse.png"
}

local joker = {
  key = "eamuse",
  loc_txt = {
    name = "e-amusement pass",
    text = {
      "Adds {C:mult}+#1#{} Mult for",
      "every {C:Attention}Joker{} triggered",
      "{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult){}"
    }
  },
  config = { extra = { mult = 0.5 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.mult } }
  end,
  atlas = "eamuse",
  rarity = 2,
  cost = 5,
  blueprint_compat = true,
  discovered = true,
  calculate = function(self, card, context)
    -- if context.individual and context.cardplay == G.jokers then
    --   if not context.other_joker ~= card then
    --     card.ability.mult = card.ability.mult + card.ability.extra.mult
    --     card_eval_status_text(card, 'extra', card.ability.extra.mult, nil, nil, nil)
    --   end
    -- end
    if context.post_trigger then
      card.ability.mult = card.ability.mult + card.ability.extra.mult
      G.E_MANAGER:add_event(Event({
        func = function()
          (context.blueprint_card or card):juice_up(0.5, 0.5)
          return true
        end,
      }))
      card_eval_status_text(card, 'extra', card.ability.extra.mult, nil, nil, {
        message = localize("k_upgrade_ex")
      })
    end

    if context.joker_main then
      SMODS.eval_this(card, {
        mult_mod = card.ability.mult,
        message = localize {type = 'variable', key = 'a_mult', vars = {card.ability.mult}}
      })
    end
  end
}

SMODS.Joker(joker)