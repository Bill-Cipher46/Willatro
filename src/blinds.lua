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
                    ease_dollars(-marked_card:get_id())
                    SMODS.destroy_cards(marked_card)
                end
            end
        end
    end

}