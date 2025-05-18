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
    calculate = function(self, card, context)
        if context.discard then
            for k, v in ipairs(G.hand.cards) do
                if v.facing == "front" then
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
        if handname == 'Pair' or handname == 'High Card' or handname == 'Three of a Kind' or handname == 'Four of a Kind' or 
        handname == 'Five of a Kind' or handname == 'Flush' or handname == 'Flush Five' or handname == 'Straight Flush' or 
        handname == 'Flush House' or handname == 'Royal Flush' then
            return true
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
    config = { extra = { odds = 6 } },
    loc_vars = function(self)
        return {
            vars = { G.GAME.probabilities.normal, self.config.extra.odds }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = { G.GAME.probabilities.normal, self.config.extra.odds }
        }
    end,
    calculate = function(self, card, context)
        if pseudorandom('arrow') < G.GAME.probabilities.normal / self.config.extra.odds then
            if context.destroy_card and context.cardarea == G.play then
                return
                { 
                    remove = true
                }
            end
        end
    end

}