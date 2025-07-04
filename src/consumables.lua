SMODS.Atlas {
    key = "WillatroConsumables",
    path = "WillowConsumables.png",
    px = 71,
    py = 95
}

--#region tarots
--tree - done!
SMODS.Consumable {
    key = "tree",
    set = 'Tarot',
    atlas = 'WillatroConsumables',
    pos = { x = 0, y = 0 },
    cost = 3,
    config = { 
        extra = { 
            max_highlighted = 3, 
            enh_key = 'm_willatro_overgrown' 
        } 
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.enh_key]
        return { 
            vars = { 
                card.ability.extra.max_highlighted, 
                localize { type = 'name_text', set = 'Enhanced', key = card.ability.extra.enh_key } 
            } 
        }
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip(); play_sound('card1', percent); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[card.ability.extra.enh_key]); return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end

}
--#endregion

--#region spectrals
--bomb
SMODS.Consumable
{
    key = "bomb",
    set = 'Spectral',
    atlas = 'WillatroConsumables',
    pos = { x = 1, y = 0},
    config = { 
        extra = { 
            money = 20 
        } 
    },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.money 
            } 
        }
    end,

    use = function(self, card, area, copier)
        local debuffed_joker = pseudorandom('bomb', 1, #G.jokers.cards)
        SMODS.debuff_card(G.jokers.cards[debuffed_joker], true, 'bomb')
        delay(0.5)
        ease_dollars(card.ability.extra.money)
        delay(0.3)
    end,

    can_use = function(self, card)
        return G.jokers.cards
    end
    
}
--#endregion