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
    config = { extra = { consumable_slots = -1, hand_size = -1 } },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.consumable_slots, self.config.extra.hand_size } }
    end,

    apply = function(self, back)
        G.GAME.starting_params.consumable_slots = G.GAME.starting_params.consumable_slots + self.config.extra.consumable_slots
        G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.extra.hand_size
        G.E_MANAGER:add_event(Event({
            func = function()
            local card = SMODS.create_card({
                set = 'Joker',
                area = G.jokers,
                key = 'j_willatro_unseenexplosion',
                
            })
            card:add_to_deck()
            G.jokers:emplace(card)
            return true
            end
        }))
    end
}