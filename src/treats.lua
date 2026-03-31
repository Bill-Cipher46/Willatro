SMODS.Atlas {
    key = "WillatroTreats",
    path = "WillowTreats.png",
    px = 71,
    py = 95,
}

SMODS.ConsumableType {
    key = "willatro_treat",
    primary_colour = HEX("282322"),
    secondary_colour = HEX("282322"),
    collection_rows = { 3, 4 }
}

--candy - done!
SMODS.Consumable {
    key = "candy",
    set = 'willatro_treat',
    atlas = 'WillatroTreats',
    pos = { x = 0, y = 0 },
    cost = 3,
    config = {
        extra = {
            mult = 3
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,

    use = function(self, card, area, copier)
        local _hand, _tally = nil, 0
        for k, v in ipairs(G.handlist) do
            if SMODS.is_poker_hand_visible(v) and G.GAME.hands[v].played > _tally then
                _hand = v
                _tally = G.GAME.hands[v].played
            end
        end

        if _hand then
            SMODS.upgrade_poker_hands({
                hands = _hand,
                parameters = { "mult" },
                func = function(current, base, param)
                    return current + card.ability.extra.mult
                end,
                from = card
            })
        end
    end,

    can_use = function(self, card)
        local _tally = 0
        for k, v in ipairs(G.handlist) do
            if SMODS.is_poker_hand_visible(v) and G.GAME.hands[v].played > _tally then
                _tally = G.GAME.hands[v].played
            end
        end

        if _tally > 0 then
            return true
        end
    end

}

--cookie - done!
SMODS.Consumable {
    key = "cookie",
    set = 'willatro_treat',
    atlas = 'WillatroTreats',
    pos = { x = 1, y = 0 },
    cost = 3,
    config = {
        extra = {
            chips = 15
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,

    use = function(self, card, area, copier)
        local _hand, _tally = nil, 0
        for k, v in ipairs(G.handlist) do
            if SMODS.is_poker_hand_visible(v) and G.GAME.hands[v].played > _tally then
                _hand = v
                _tally = G.GAME.hands[v].played
            end
        end

        if _hand then
            SMODS.upgrade_poker_hands({
                hands = _hand,
                parameters = { "chips" },
                func = function(current, base, parameter)
                    return current + card.ability.extra.chips
                end,
                from = card
            })
        end
    end,

    can_use = function(self, card)
        local _tally = 0
        for k, v in ipairs(G.handlist) do
            if SMODS.is_poker_hand_visible(v) and G.GAME.hands[v].played > _tally then
                _tally = G.GAME.hands[v].played
            end
        end

        if _tally > 0 then
            return true
        end
    end

}

--chocolate - done!
SMODS.Consumable {
    key = "chocolate",
    set = 'willatro_treat',
    atlas = 'WillatroTreats',
    pos = { x = 2, y = 0 },
    cost = 3,
    config = {
        extra = {
            dollars = 8
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars
            }
        }
    end,

    use = function(self, card, area, copier)
        ease_dollars(card.ability.extra.dollars, true)
    end,

    can_use = function(self, card)
        return true
    end

}