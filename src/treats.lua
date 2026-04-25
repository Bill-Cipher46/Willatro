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
    collection_rows = { 3, 4 },
    default = "c_willatro_candy"
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

--normal booster 1 - done!
SMODS.Booster {
    atlas = "WillatroTreats",
    key = "treat_normal_1",
    weight = 1,
    kind = 'willatro_treat',
    cost = 4,
    pos = { x = 4, y = 1 },
    config = { extra = 3, choose = 1 },
    draw_hand = true,

    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                colours = {
                    HEX("282322")
                },
                cfg.choose,
                cfg.extra
            },
            key = self.key:sub(1, -3)
        }
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("615b5a"))
        ease_background_colour({ new_colour = HEX("282322"), special_colour = HEX("615b5a"), contrast = 2 })
    end,

    create_card = function(self, card, i)
        return {
            set = "willatro_treat",
            area = G.pack_cards,
            skip_materialize = true,
            key_append =
            "willatro_treat"
        }
    end
}

--normal booster 2 - done!
SMODS.Booster {
    atlas = "WillatroTreats",
    key = "treat_normal_2",
    weight = 1,
    kind = 'willatro_treat',
    cost = 4,
    pos = { x = 5, y = 1 },
    config = { extra = 3, choose = 1 },
    draw_hand = true,

    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                colours = {
                    HEX("282322")
                },
                cfg.choose,
                cfg.extra
            },
            key = self.key:sub(1, -3)
        }
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("615b5a"))
        ease_background_colour({ new_colour = HEX("282322"), special_colour = HEX("615b5a"), contrast = 2 })
    end,

    create_card = function(self, card, i)
        return {
            set = "willatro_treat",
            area = G.pack_cards,
            skip_materialize = true,
            key_append =
            "willatro_treat"
        }
    end
}

--jumbo booster 1 - done!
SMODS.Booster {
    atlas = "WillatroTreats",
    key = "treat_jumbo_1",
    weight = 1,
    kind = 'willatro_treat',
    cost = 6,
    pos = { x = 0, y = 2 },
    config = { extra = 5, choose = 1 },
    draw_hand = true,

    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                colours = {
                    HEX("282322")
                },
                cfg.choose,
                cfg.extra
            },
            key = self.key:sub(1, -3)
        }
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("615b5a"))
        ease_background_colour({ new_colour = HEX("282322"), special_colour = HEX("615b5a"), contrast = 2 })
    end,

    create_card = function(self, card, i)
        return {
            set = "willatro_treat",
            area = G.pack_cards,
            skip_materialize = true,
            key_append =
            "willatro_treat"
        }
    end
}

--jumbo booster 2 - done!
SMODS.Booster {
    atlas = "WillatroTreats",
    key = "treat_jumbo_2",
    weight = 1,
    kind = 'willatro_treat',
    cost = 6,
    pos = { x = 1, y = 2 },
    config = { extra = 5, choose = 1 },
    draw_hand = true,

    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                colours = {
                    HEX("282322")
                },
                cfg.choose,
                cfg.extra
            },
            key = self.key:sub(1, -3)
        }
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("615b5a"))
        ease_background_colour({ new_colour = HEX("282322"), special_colour = HEX("615b5a"), contrast = 2 })
    end,

    create_card = function(self, card, i)
        return {
            set = "willatro_treat",
            area = G.pack_cards,
            skip_materialize = true,
            key_append =
            "willatro_treat"
        }
    end
}