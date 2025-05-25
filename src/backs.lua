SMODS.Atlas
{
    key = "WillatroBacks",
    path = "WillowDecks.png",
    px = 71,
    py = 95
}

--unseen deck
SMODS.Back {
    key = "unseen",
    atlas = "WillatroBacks",
    config = { extra = { consumeable_slots = -1, hand_size = -1 } },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.consumeable_slots, self.config.extra.hand_size } }
    end,

    apply = function(self, back)
        G.GAME.starting_params.consumeable_slots = G.GAME.starting_params.consumeable_slots + self.config.extra.consumeable_slots
        G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.extra.hand_size
    end
}