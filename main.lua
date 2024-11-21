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
  config = {joker = "glitch"},
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
        G.jokers:emplace(new_card('j_HJML_glitch'))
        G.jokers:emplace(new_card('j_blue_joker'))
        G.jokers:emplace(new_card('j_popcorn'))
        return true
      end
    }))
  end
}
