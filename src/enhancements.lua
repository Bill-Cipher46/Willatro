SMODS.Atlas {
    key = "WillatroEnhancements",
    path = "WillowEnhancements.png",
    px = 71,
    py = 95
}

--overgrown - done!
SMODS.Enhancement {
    key = "overgrown",
    atlas = "WillatroEnhancements",
    pos = { x = 0, y = 0 },
    config = { 
        extra = { 
            mult = 2 
        } 
    },
    
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult 
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            local overgrown = 0
            for k, v in ipairs(context.full_hand) do
                if SMODS.has_enhancement(v, "m_willatro_overgrown") then
                    overgrown = overgrown + card.abiliy.extra.mult
                end
            end
            for k, v in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(v, "m_willatro_overgrown") then
                    overgrown = overgrown + card.ability.extra.mult
                end
            end
            return {
                mult = overgrown
            }
        end
    end
}