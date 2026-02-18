SMODS.Atlas {
    key = "WillatroSeals",
    path = "WillowSeals.png",
    px = 71,
    py = 95
}

--love seal - done!
SMODS.Seal {
    key = "Love",
    atlas = "WillatroSeals",
    pos = { x = 0, y = 0 },
    badge_colour = HEX("fda2e9"),
    config = {
        extra = {
            xchips_inc = 0.1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.seal.extra.xchips_inc
            }
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            local love = 1
            for k, v in ipairs(context.scoring_hand) do
                if v:get_seal("willatro_love_seal") then
                    love = love + card.ability.seal.extra.xchips_inc
                end
            end
            return {
                x_chips = love
            }
        end
    end
}