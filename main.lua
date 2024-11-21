print("Hajimeli Jokers running!")
local mod = SMODS.Mods["HajimeliJokers"]

local jokerFiles = NFS.getDirectoryItems(mod.path.."jokers")
local modJokers = {}
for k, file in pairs(jokerFiles) do
  local lowercasename = string.sub(file, 1, string.len(file) - 4):lower()
  print("checking " .. lowercasename)
  if string.find(file, ".lua") then
    print("loading joker: " .. file)
    local joker = NFS.load(mod.path.."jokers/"..file)()
    table.insert(modJokers, joker)
  end
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
      trigger = 'after',
      delay = 0.1,
      func = function()
        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_HJML_glitch')
        G.jokers:emplace(create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_joker'))
        G.jokers:emplace(card)
        G.jokers:emplace(create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_blue_joker'))
        G.jokers:emplace(create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_popcorn'))
        return true
      end
    }))
  end
}
