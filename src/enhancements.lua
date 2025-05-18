SMODS.Atlas {
    key = "WillatroEnhancements",
    path = "WillowEnhancements.png",
    px = 71,
    py = 95
}

SMODS.Enhancement {
    key = "overgrown",
    atlas = "WillatroEnhancements",
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end
}