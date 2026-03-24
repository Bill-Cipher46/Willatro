SMODS.Atlas
{
    key = "WillatroBlinds",
    path = "WillowBlinds.png",
    px = 34,
    py = 34,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21
}

--sand - done!
SMODS.Blind
{
    key = "sand",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 0},
    boss = {
        min = 3,
        max = 0
    },
    boss_colour = HEX('d09552'),

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.discard then
                for k, v in ipairs(G.hand.cards) do
                    v:flip()
                end
            end
        end
    end

}

--ring - done!
SMODS.Blind
{
    key = "ring",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 1},
    boss = {
        min = 5,
        max = 0
    },
    boss_colour = HEX('9329b7'),

    debuff_hand = function(self, cards, hand, handname, check)
        if not self.disabled then
            if handname == 'Pair' or handname == 'High Card' or handname == 'Three of a Kind' or handname == 'Four of a Kind' or 
            handname == 'Five of a Kind' or handname == 'Flush' or handname == 'Flush Five' or handname == 'Straight Flush' or 
            handname == 'Flush House' or handname == 'Royal Flush' then
                return true
            end
        end
    end
}

--arrow - done!
SMODS.Blind
{
    key = "arrow",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 2},
    boss = {
        min = 1,
        max = 0
    },
    boss_colour = HEX('279378'),

    loc_vars = function(self)
        local numerator, denominator = SMODS.get_probability_vars(self, 1, 3, 'willatro_arrow')
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                '1',
                '3'
            }
        }
    end,

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.destroy_card and context.cardarea == G.play then
                if SMODS.pseudorandom_probability(blind, 'willatro_arrow', 1, 3) then
                    return {
                        remove = true
                    }
                end
            end
        end
    end

}

--golden gun - done!
SMODS.Blind
{
    key = "golden_gun",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 3},
    boss = {
        showdown = true
    },
    boss_colour = HEX('ffd081'),

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_play then
                if #G.hand.highlighted > 1 then
                    local marked_card = pseudorandom_element(G.hand.highlighted, "golden_gun")
                    print(marked_card.base.id)
                    ease_dollars(-marked_card.base.id)
                    SMODS.destroy_cards(marked_card)
                end
            end
        end
    end

}

--the hollow - done!
SMODS.Blind
{
    key = "hollow",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 4 },
    boss = {
        min = 1,
        max = 0
    },
    boss_colour = HEX('2c2c2c'),

    mult = 0.5,

    vars = {
        1
    },
    
    loc_vars = function(self)
        return {
            vars = {
                1
            }
        }
    end,

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                ease_hands_played(1)
            end
        end
    end,

    debuff_hand = function(self, cards, hand, handname, check)
        if not self.disabled then
            if handname ~= 'High Card' then
                return true
            end
        end
    end,

    in_pool = function(self, args)
        if next(SMODS.find_card("j_willatro_consciousness")) then
            return true
        end
    end

}

--virulent void - done!
SMODS.Blind
{
    key = "virulent_void",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 5 },
    boss = {
        showdown = true
    },
    boss_colour = HEX('030303'),
    mult = 0.1,

    vars = {
        3
    },
    
    loc_vars = function(self)
        return {
            vars = {
                3
            }
        }
    end,

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                ease_hands_played(3)
            end

            if context.debuff_card and context.debuff_card.area == G.jokers then
                return {
                    debuff = true
                }
            end
        end
    end,

    debuff_hand = function(self, cards, hand, handname, check)
        if not self.disabled then
            if handname ~= 'High Card' then
                return true
            end
        end
    end,

    in_pool = function(self, args)
        if next(SMODS.find_card("j_willatro_consciousness")) then
            return true
        end
    end
}

--The violent - done!
SMODS.Blind
{
    key = "violent",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 6 },
    boss = {
        min = 4,
        max = 0
    },
    boss_colour = HEX('dd6565'),

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.destroy_card and context.cardarea == G.play then
                if next(SMODS.get_enhancements(context.destroy_card)) then
                    return {
                        remove = true
                    }
                end
            end
        end
    end
}

--The lustful - done!
SMODS.Blind
{
    key = "lustful",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 7 },
    boss = {
        min = 4,
        max = 0
    },
    boss_colour = HEX('e47ad0'),

    loc_vars = function(self)
        return {
            vars = {
                G.GAME.willatro_majority_suit or "(most common suit in deck)"
            }
        }
    end,

    collection_loc_vars = function(self)
        return {
            vars = {
                "(most common suit in deck)"
            }
        }
    end,

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand then
                blind.triggered = false
                for _, card in ipairs(context.scoring_hand) do
                    if card:is_suit(G.GAME.willatro_majority_suit) then
                        blind.triggered = true
                        if not context.check then
                            ease_dollars(-G.GAME.dollars, true)
                            blind:wiggle()
                            return true
                        end
                    end
                end
            end
        end
    end
}

--the companion - done!
SMODS.Blind
{
    key = "companion",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 8 },
    boss = {
        min = 2,
        max = 0
    },
    boss_colour = HEX('36d156'),

    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.end_of_round and context.main_eval then
                if G.GAME.current_round.hands_played == 1 then
                    G.hand:change_size(1)
                else
                    G.hand:change_size(-1)
                end
            end
        end
    end
}

--the glutton - done!
SMODS.Blind
{
    key = "glutton",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 9 },
    boss = {
        min = 1,
        max = 0
    },
    boss_colour = HEX('e5b790'),
    config = {
        extra = {
            consumeable_slots = nil
        }
    },

    set_blind = function(self)
        G.GAME.blind.effect.extra.consumeable_slots = G.consumeables.config.card_limit

        SMODS.destroy_cards(G.consumeables.cards)
        G.consumeables.config.card_limit = 0

    end,

    defeat = function(self)
        G.consumeables.config.card_limit = G.GAME.blind.effect.extra.consumeable_slots

    end,

    disable = function(self)
        G.consumeables.config.card_limit = G.GAME.blind.effect.extra.consumeable_slots

    end
}

--blind colours
--the resilient: c1c1c1