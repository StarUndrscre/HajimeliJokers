print("Hajimeli Jokers running!")
local mod = SMODS.Mods["HajimeliJokers"]

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
        G.jokers:emplace(new_card('j_blueprint'))
        G.jokers:emplace(new_card('j_HJML_club_setback'))
        G.jokers:emplace(new_card('j_brainstorm'))
        for _, card in ipairs(G.playing_cards) do
					card:change_suit('Clubs')
				end
        return true
      end
    }))
  end
}
