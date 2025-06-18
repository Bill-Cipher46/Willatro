SMODS.Atlas
{
    key = "WillatroBacks",
    path = "WillowDecks.png",
    px = 71,
    py = 95
}

--unseen deck - done!
SMODS.Back {
    key = "unseen",
    atlas = "WillatroBacks",
    pos = { x = 0, y = 0 },
    config = { 
        extra = { 
            consumable_slots = -1, 
            hand_size = -1 
        } 
    },

    loc_vars = function(self, info_queue, back)
        return { 
            vars = { 
                self.config.extra.consumable_slots, 
                self.config.extra.hand_size 
            } 
        }
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

--cellular deck - done!
SMODS.Back {
    key = "cellular",
    atlas = "WillatroBacks",
    pos = { x = 1, y = 0 },
    config = { 
        extra = { 
            discards = -1 
        } 
    },

    loc_vars = function(self,info_queue,back)
        return { 
            vars = { 
                self.config.extra.discards 
            } 
        }
    end,

    apply = function(self, back)
        G.GAME.starting_params.discards = G.GAME.starting_params.discards + self.config.extra.discards
        G.GAME.round_resets.ante = 0
        G.GAME.round_resets.blind_ante = 0
        G.E_MANAGER:add_event(Event({
            func = function()
            local card = SMODS.create_card({
                set = 'Joker',
                area = G.jokers,
                key = 'j_dna'
                
            })
            card:add_to_deck()
            card:set_perishable(true)
            G.jokers:emplace(card)
            return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
            local card = SMODS.create_card({
                set = 'Joker',
                area = G.jokers,
                key = 'j_willatro_mitosis',
                
            })
            card:add_to_deck()
            card:set_perishable(true)
            G.jokers:emplace(card)
            return true
            end
        }))
    end
}