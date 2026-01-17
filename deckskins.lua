sendInfoMessage("Loading Deckskins...", "WillatroDeckSkins")

local suits = {'Hearts', 'Clubs', 'Diamonds', 'Spades'}
local dranks = {'Jack', 'Queen', "King"}
local ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace"}

local rhc = SMODS.Atlas{
    key = "WillatroHighContrast",
    path = "highcontrast.png",
    px = 71,
    py = 95
}

local rlc = SMODS.Atlas{
    key = "WillatroLowContrast",
    path = "lowcontrast.png",
    px = 71,
    py = 95
}

for i, suit in ipairs(suits) do

	SMODS.DeckSkin {
		key = "deckskins_"..suit,
		suit = suit,
		loc_txt = {
			['default'] = "Willatro Deck Skins"
		},
		palettes = {},
	}
	
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['willatro_deckskins_'..suit], {key = 'willatro_deckskins_lc', ranks = ranks, display_ranks = dranks, atlas = rlc.key,})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['willatro_deckskins_'..suit], {key = 'willatro_deckskins_hc', ranks = ranks, display_ranks = dranks, atlas = rhc.key,})

end