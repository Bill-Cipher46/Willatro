SMODS.Atlas {
    key = "WillatroOrgans",
    path = "WillowOrgans.png",
    px = 71,
    py = 95
}

SMODS.Rarity {
    key = "organ",
    loc_txt = {},
    badge_colour = HEX("6f222c")

}

--#region organs
SMODS.Joker {
    key = "heart",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    cost = 6,

}

SMODS.Joker {
    key = "brain",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 2, y = 0 },
    soul_pos = { x = 3, y = 0 },
    cost = 6,
}

SMODS.Joker {
    key = "eye",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 4, y = 0 },
    cost = 6,
    config = {
        extra = {
            mult = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.willatro_jokeinthebox or {}).suit or 'Spades'
        return
        {
            vars = {
                card.ability.extra.mult,
                localize(suit, 'suits_singular'), 
                colours = { G.C.SUITS[suit] }
            }
        }
    end,
}

SMODS.Joker {
    key = "liver",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 5, y = 0 },
    cost = 6,
}

SMODS.Joker {
    key = "lungs",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 6, y = 0 },
    cost = 6,
}

SMODS.Joker {
    key = "stomach",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 7, y = 0 },
    cost = 6,
}

--#endregion