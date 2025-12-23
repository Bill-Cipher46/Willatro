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

--boost - done!
SMODS.Consumable {
    key = "boost",
    set = 'Tarot',
    atlas = 'WillatroConsumables',
    pos = { x = 2, y = 0 },
    cost = 3,
    config = { 
        extra = { 
            max_highlighted = 1
        } 
    },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.max_highlighted
            } 
        }
    end,

    use = function(self, card, area, copier)
        if G.jokers and G.jokers.highlighted and #G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.extra.max_highlighted then
            for i = 1, #G.jokers.highlighted do
                if willatro.upgrades[G.jokers.highlighted[i].config.center.key] then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('tarot1')
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                    delay(0.2)
                    for i = 1, #G.jokers.highlighted do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers.highlighted[i]:juice_up(0.3, 0.5)
                                G.jokers.highlighted[i]:set_ability(willatro.upgrades[G.jokers.highlighted[i].config.center.key].key)
                                return true
                            end
                        }))
                    end
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            G.jokers:unhighlight_all()
                            return true
                        end
                    }))
                end
            end
        else
            SMODS.add_card{key = "c_willatro_boost"}
        end
    end,
    can_use = function(self, card)
        if G.jokers and G.jokers.highlighted and #G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.extra.max_highlighted then
            for i = 1, #G.jokers.highlighted do
                if willatro.upgrades[G.jokers.highlighted[i].config.center.key] then
                    return true
                else
                    return false
                end
            end
        end

        if card.area == G.pack_cards and not (G.jokers and G.jokers.highlighted and #G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.extra.max_highlighted) then
            return true
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        for i = 1, #G.jokers.cards do
            if willatro.upgrades[G.jokers.cards[i].config.center.key] then
                local eval = function(card2)
                    return not card.REMOVED
                end
                juice_card_until(G.jokers.cards[i], eval, true)
                juice_card_until(card, eval, true)
            end
        end
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
        if #G.jokers.cards != nil then
            local debuffed_joker = pseudorandom('bomb', 1, #G.jokers.cards)
            SMODS.debuff_card(G.jokers.cards[debuffed_joker], true, 'bomb')
        delay(0.5)
        ease_dollars(card.ability.extra.money)
        delay(0.3)
    end,

    can_use = function(self, card)
        return G.jokers.cards
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
    
}
--#endregion
