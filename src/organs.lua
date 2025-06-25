SMODS.Atlas {
    key = "WillatroOrgans",
    path = "WillowOrgans.png",
    px = 71,
    py = 95
}

SMODS.Rarity {
    key = "organ",
    loc_txt = {},
    badge_colour = HEX("6f222c")

}

--#region organs

--heart - done!
SMODS.Joker {
    key = "heart",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 0, y = 0 },
    spul_pos = { x = 1, y = 0 },
    cost = 6,
    config = {
        extra = {
            odds = 2,
            x_mult = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                (G.GAME.probabilities.normal or 1),
                card.ability.extra.odds,
                card.ability.extra.x_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit('Hearts') then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            elseif pseudorandom('heart') < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
                (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

            local image = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["willatro_WillatroOrgans"], {x = 1, y = 0})
            image.role.draw_major = card
            image:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
                0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
            image:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    end

}

--brain - done!
SMODS.Joker {
    key = "brain",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 2, y = 0 },
    soul_pos = { x = 3, y = 0 },
    cost = 6,
    config = {
        extra = {
            repetitions = 1,
            big_repetitions = 2,
            d_remaining = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions,
                card.ability.extra.big_repetitions,
                card.ability.extra.d_remaining
            }
        }
    end,

    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() 
                return {
                    G.GAME.current_round.hands_played == 0
                }
            end
        end
        if context.retrigger_joker_check  then
            if G.GAME.current_round.discards_left == card.ability.extra.d_remaining then
                return {
                    repetitions = card.ability.extra.big_repetitions
                }
            elseif G.GAME.current_round.hands_played == 0 or G.GAME.current_round.hands_left == 0 then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}

--eye - done!
SMODS.Joker {
    key = "eye",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 4, y = 0 },
    cost = 6,
    config = {
        chosen_card = {
            suit = 'Spades'
        },
        extra = {
            mult_gain = 2,
            mult = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        local suit = (card.ability.chosen_card or {}).suit or 'Spades'
        return
        {
            vars = {
                card.ability.extra.mult_gain,
                card.ability.extra.mult,
                localize(suit, 'suits_singular'), 
                colours = { G.C.SUITS[suit] }
            }
        }
    end,

    calculate = function(self, card, context)
        local message = false
        if context.after and context.main_eval then
            local valid_eye_cards = {}
            for _, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_no_suit(playing_card) then
                    valid_eye_cards[#valid_eye_cards + 1] = playing_card
                end
            end
            local eye_card = pseudorandom_element(valid_eye_cards, 'willatro_eye' .. G.GAME.round_resets.ante)
            if eye_card then
                card.ability.chosen_card.suit = eye_card.base.suit
            end
        end

        if context.before and context.main_eval and not context.blueprint and card.ability.chosen_card then
            for k, v in ipairs(context.scoring_hand) do
                if v:is_suit(card.ability.chosen_card.suit) then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                    message = true
                end
            end
        end
        if message == true then
            message = false
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

--liver - done!
SMODS.Joker {
    key = "liver",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 5, y = 0 },
    cost = 6,
    config = {
        extra = {
            odds = 6
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                (G.GAME.probabilities.normal or 1),
                card.ability.extra.odds
            }
        }
    end,

    calculate = function(self, card, context)
        if context.pre_discard then
            if pseudorandom('liver') < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
                return {
                    ease_discard(1)
                }
            end
        end
    end
}

--lungs - done!
SMODS.Joker {
    key = "lungs",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 0, y = 1 },
    cost = 6,
    config = { 
        extra = { 
            chip_gain = 20, 
            lung_rounds = 5,
            rounds = 5,
            chips = 0,
            played_hands = { }
        } 
    },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.chip_gain,
                card.ability.extra.lung_rounds,
                card.ability.extra.rounds,
                card.ability.extra.chips
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.before and next(context.poker_hands['Pair']) and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
            card.ability.extra.played_hands[#card.ability.extra.played_hands + 1] = 'Pair'
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.BLUE
            }
        end
        if context.before and not next(context.poker_hands['Pair']) and not context.blueprint then
            card.ability.extra.played_hands[#card.ability.extra.played_hands+1] = 'notPair'
        end

        if context.end_of_round and context.game_over == false and context.main_eval then
            local deduct = false
            for i = 1, #card.ability.extra.played_hands do
                if card.ability.extra.played_hands[i] == 'Pair' then
                    deduct = true
                    break
                end
            end
            if deduct == true then
                card.ability.extra.rounds = card.ability.extra.rounds - 1
                card.ability.extra.played_hands = { }
                deduct = false
                if card.ability.extra.rounds <= 0 then
                    if card.ability.extra.chips > 0 then
                        card.ability.extra.chips = 0
                    end
                    card.ability.extra.rounds = 5
                    return {
                        message = localize('k_reset')
                    }
                end
                return {
                    message = '-1'
                }
            else
                card.ability.extra.rounds = card.ability.extra.lung_rounds
            end

        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

--stomach - done!
SMODS.Joker {
    key = "stomach",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 1, y = 1 },
    cost = 6,
    config = {
        extra = {
            xmult_gain = 0.2,
            x_mult = 1,
            chosen_card = nil
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.x_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local cards = {}
            for k, v in ipairs(context.scoring_hand) do
                cards[#cards+1] = v
            end
            card.ability.extra.chosen_card = pseudorandom_element(cards, pseudoseed('willatro_stomach' .. G.GAME.round_resets.ante))
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.xmult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.FILTER
            }
        end
        
        if context.destroy_card and card.ability.extra.chosen_card and context.cardarea == G.play then
            if context.destroy_card == card.ability.extra.chosen_card then
                return {
                    remove = true
                }
            end
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end
}

--kidney - done!
SMODS.Joker{
    key = "kidney",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 3, y = 1 },
    cost = 6,
    config = {
        extra = {
            odds = 10,
            mult = 15
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return {
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and pseudorandom('kidney') < G.GAME.probabilities.normal / card.ability.extra.odds then
            local stone_card = SMODS.create_card { set = "Base", enhancement = "m_stone", area = G.discard }
            G.E_MANAGER:add_event(Event({
                func = function()
                    stone_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                    G.play:emplace(stone_card)
                    return true
                end
            }))
            return {
                message = localize('k_plus_stone'),
                colour = G.C.SECONDARY_SET.Enhanced,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            return true
                        end
                    }))
                    draw_card(G.play, G.deck, 90, 'up')
                    SMODS.calculate_context({ playing_card_added = true, cards = { stone_card } })
                end
            }
        end

        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_stone') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

--small intestine
SMODS.Joker{
    key = "intestine_small",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 4, y = 1 },
    cost = 6,
    config = {
        extra = {
            xmult_gain = 0.1,
            x_mult = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.x_mult
            }
        }
    end
}

--large intestine
SMODS.Joker{
    key = "intestine_large",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 5, y = 1 },
    cost = 6,
    config = {
        extra = {
            xmult_gain = 0.2,
            x_mult = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.x_mult
            }
        }
    end
}

--#endregion

SMODS.Booster
{
    key = "organ_pack",
    loc_txt = {
        name = "Organ Pack",
        group_name = "Organ Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2# {V:1}Organ{} Jokers"
        }
            
    },
    atlas = "WillatroOrgans",
    cost = 4,
    weight = 0.9,
    pos = { x = 2, y = 1 },
    kind = "Organ",
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = { 
                    G.C.RARITY["willatro_organ"] 
                },
                card.ability.choose,
                card.ability.extra
            }
        }
    end,

    create_card = function(self, card, i)
        return { set = "Joker", rarity = "willatro_organ" }
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.RARITY["willatro_organ"])
        ease_background_colour({ new_colour = HEX('be4152'), special_colour = G.C.RARITY["willatro_organ"], contrast = 2 })
    end
}