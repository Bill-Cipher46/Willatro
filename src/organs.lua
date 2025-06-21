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
    soul_pos = { x = 1, y = 0 },
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
            elseif pseudorandom('heart') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
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
        chosen_card = nil,
        extra = {
            mult_gain = 2,
            mult = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        local suit = (card.chosen_card or {}).suit or 'Spades'
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
            card.chosen_card = { suit = 'Spades' }
            local valid_eye_cards = {}
            for _, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_no_suit(playing_card) then
                    valid_eye_cards[#valid_eye_cards + 1] = playing_card
                end
            end
            local eye_card = pseudorandom_element(valid_eye_cards, 'willatro_eye' .. G.GAME.round_resets.ante)
            if eye_card then
                card.chosen_card.suit = eye_card.base.suit
            end
        end

        if context.before and context.main_eval and not context.blueprint and card.chosen_card then
            for k, v in ipairs(context.scoring_hand) do
                if v:is_suit(card.chosen_card.suit) then
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

--liver
SMODS.Joker {
    key = "liver",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 5, y = 0 },
    cost = 6,
}

--lungs
SMODS.Joker {
    key = "lungs",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 6, y = 0 },
    cost = 6,
}

--stomach
SMODS.Joker {
    key = "stomach",
    rarity = "willatro_organ",
    atlas = "WillatroOrgans",
    pos = { x = 7, y = 0 },
    cost = 6,
}

--#endregion