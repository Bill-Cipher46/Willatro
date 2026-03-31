SMODS.Atlas {
    key = "WillatroSpectrals",
    path = "WillowSpectrals.png",
    px = 71,
    py = 95,
}

--bomb - done!
SMODS.Consumable
{
    key = "bomb",
    set = 'Spectral',
    atlas = 'WillatroSpectrals',
    pos = { x = 0, y = 0},
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
        if #G.jokers.cards > 0 then
            local debuffed_joker = pseudorandom('bomb', 1, #G.jokers.cards)
            SMODS.debuff_card(G.jokers.cards[debuffed_joker], true, 'bomb')
        end
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