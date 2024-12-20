print("Hajimeli Jokers running!")
local mod = SMODS.Mods["HajimeliJokers"]

NFS.load(mod.path.."credits.lua")()

local jokerFiles = NFS.getDirectoryItems(mod.path.."jokers")
for k, file in pairs(jokerFiles) do
  local lowercasename = string.sub(file, 1, string.len(file) - 4):lower()
  print("checking " .. lowercasename)
  if string.find(file, ".lua") then
    print("loading joker: " .. file)
    NFS.load(mod.path.."jokers/"..file)()
  end
end

function new_card(key)
  return create_card('Joker', G.jokers, nil, nil, nil, nil, key)
end

SMODS.Back{
  name = "HJML Test Deck",
  key = "hjmltest",
  loc_txt = {
    name = "HJML Test Deck",
    text = {
      "hajimeli test joker"
    }
  },
  apply = function(self)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.jokers:emplace(new_card('j_joker'))
        G.jokers:emplace(new_card('j_HJML_speedrun'))
        for _, card in ipairs(G.playing_cards) do
          assert(SMODS.change_base(card, nil, '4'))
        end
        return true
      end
    }))
  end
}

SMODS.Atlas{
  key = "placeholder",
  px = 71,
  py = 95,
  path = "placeholder.png"
}
