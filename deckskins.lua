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

SMODS.DeckSkin {
	key = "deckskins_Hearts",
	suit = "Hearts",
	loc_txt = {
		['default'] = "Megumin's Stuff"
	},
	palettes = {},
}

SMODS.DeckSkin.add_palette(SMODS.DeckSkins['willatro_deckskins_Hearts'], {key = 'willatro_deckskins_lc', ranks = ranks, display_ranks = dranks, atlas = rlc.key,})
SMODS.DeckSkin.add_palette(SMODS.DeckSkins['willatro_deckskins_Hearts'], {key = 'willatro_deckskins_hc', ranks = ranks, display_ranks = dranks, atlas = rhc.key,})

SMODS.DeckSkin {
	key = "deckskins_Clubs",
	suit = "Clubs",
	loc_txt = {
		['default'] = "Gravity Falls"
	},
	palettes = {},
}

SMODS.DeckSkin.add_palette(SMODS.DeckSkins['willatro_deckskins_Clubs'], {key = 'willatro_deckskins_lc', ranks = ranks, display_ranks = dranks, atlas = rlc.key,})
SMODS.DeckSkin.add_palette(SMODS.DeckSkins['willatro_deckskins_Clubs'], {key = 'willatro_deckskins_hc', ranks = ranks, display_ranks = dranks, atlas = rhc.key,})

SMODS.DeckSkin {
	key = "deckskins_Diamonds",
	suit = "Diamonds",
	loc_txt = {
		['default'] = "Unseen Explosion"
	},
	palettes = {},
}

SMODS.DeckSkin.add_palette(SMODS.DeckSkins['willatro_deckskins_Diamonds'], {key = 'willatro_deckskins_lc', ranks = ranks, display_ranks = dranks, atlas = rlc.key,})
SMODS.DeckSkin.add_palette(SMODS.DeckSkins['willatro_deckskins_Diamonds'], {key = 'willatro_deckskins_hc', ranks = ranks, display_ranks = dranks, atlas = rhc.key,})

SMODS.DeckSkin {
	key = "deckskins_Spades",
	suit = "Spades",
	loc_txt = {
		['default'] = "Willow's OCs"
	},
	palettes = {},
}

SMODS.DeckSkin.add_palette(SMODS.DeckSkins['willatro_deckskins_Spades'], {key = 'willatro_deckskins_lc', ranks = ranks, display_ranks = dranks, atlas = rlc.key,})
SMODS.DeckSkin.add_palette(SMODS.DeckSkins['willatro_deckskins_Spades'], {key = 'willatro_deckskins_hc', ranks = ranks, display_ranks = dranks, atlas = rhc.key,})
