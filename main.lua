print("Hajimeli Jokers running!")
local mod = SMODS.Mods["HajimeliJokers"]

local desc_loc_txt = {
  text = {
    "Several themed Jokers referencing Hajimeli Team members (+ other miscellaneous stuff)",
    "Artists: Ryoko Amesapphi, 57_dayo, SoftySapphie, Uni, mothbeanie, DokiNabi, Inksurgence, Lumbud84"
  }
}

-- SMODS.current_mod.credits_tab = function()
  -- return {
		-- tab_definition_function = function()
      -- return {
        -- n = G.UIT.ROOT,
        -- config = {
          -- colour = G.C.CLEAR
        -- },
        -- nodes = {
          -- n = G.UIT.C,
          -- config = {
            -- colour = G.C.WHITE
          -- },
          -- nodes = {
            -- n = G.UIT.T,
            -- config = {
              -- text = "fbwuh",
              -- scale = 0.75,
              -- colour = G.C.WHITE
            -- }
          -- }
        -- }
      -- }
		-- end
  -- }
-- end

-- G.localization.descriptions.Mod["HajimeliJokers"] = desc_loc_txt

-- assert(load(NFS.read(mod.path .. "lib/hook.lua")))()

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
        G.jokers:emplace(new_card('j_HJML_glitch'))
        G.jokers:emplace(new_card('j_HJML_club_setback'))
        for _, card in ipairs(G.playing_cards) do
					card:change_suit('Clubs')
				end
        return true
      end
    }))
  end
}
