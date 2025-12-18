SMODS.Atlas
{
    key = "WillatroCryptid",
    path = "WillowCryptid.png",
    px = 71,
    py = 95
}

willatro.upgrades["j_willatro_thecoolerjoker"] = {
    key = "j_willatro_coolest_joker",
    upgradeable = true
}

--the coolest joker
SMODS.Joker {
    key = "coolest_joker",
    rarity = "cry_exotic",
    atlas = "WillatroCryptid",
    pos = {x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    cost = 50,
    blueprint_compat = true,
    config = {
        extra = {
            emult = 4
        }
    },

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(center.ability.extra.emult)
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = {
						number_format(card.ability.extra.emult),
					},
				}),
				Emult_mod = lenient_bignum(card.ability.extra.emult),
				colour = G.C.DARK_EDITION,
			}
		end
    end
}