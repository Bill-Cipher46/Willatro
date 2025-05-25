SMODS.Atlas
{
    key = "WillatroBacks",
    path = "WillatroBacks.png",
    px = 71,
    py = 95
}

--unseen deck
SMODS.Back {
    key = "unseen",
    atlas = "WillatroBacks",
    config = { extra = { consumeable_slots = 1, hand_size = 1 } },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.consumeable_slots, self.config.extra.hand_size } }
    end
}