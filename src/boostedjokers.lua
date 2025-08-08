SMODS.Atlas
{
    key = "WillatroEvolved",
    path = "WillowEvolved.png",
    px = 71,
    py = 95
}

SMODS.Atlas
{
    key = "WillatroTags",
    path = "WillowTags.png",
    px = 34,
    py = 34
}

SMODS.ObjectType {
    key = "Upgradeable",
    default = "j_joker",
    cards = {
        ["j_hanging_chad"] = true,
        ["j_joker"] = true,
        ["j_photograph"] = true,
        ["j_oops"] = true,
        ["j_wee"] = true,
        ["j_willatro_troll"] = true,
        ["j_egg"] = true,
        ["j_burnt"] = true,
        ["j_even_steven"] = true,
        ["j_odd_todd"] = true,
        ["j_supernova"] = true
    }
}

G.willatro_upgrades = {
    ["j_hanging_chad"] = {
        key = "j_willatro_ballot_box",
        upgradeable = true
    },
    ["j_joker"] = {
        key = "j_willatro_thecoolerjoker",
        upgradeable = true
    },
    ["j_photograph"] = {
        key = "j_willatro_family_photo",
        upgradeable = true
    },
    ["j_oops"] = {
        key = "j_willatro_what_all_twelves",
        upgradeable = true
    },
    ["j_wee"] = {
        key = "j_willatro_atomic_joker",
        upgradeable = true
    },
    ["j_willatro_troll"] = {
        key = "j_willatro_clueless",
        upgradeable = true
    },
    ["j_egg"] = {
        key = "j_willatro_caviar",
        upgradeable = true
    },
    ["j_burnt"] = {
        key = "j_willatro_ashes",
        upgradeable = true
    },
    ["j_even_steven"] = {
        key = "j_willatro_composite_carl",
        upgradeable = true
    },
    ["j_odd_todd"] = {
        key = "j_willatro_prime_patrick",
        upgradeable = true
    },
    ["j_supernova"] = {
        key = "j_willatro_hypernova",
        upgradeable = true
    },
}

--#region common

--ballot box - done!
SMODS.Joker {
    key = "ballot_box",
    rarity = 1,
    atlas = "WillatroEvolved",
    pos = {x = 0, y = 0},
    cost = 4,
    blueprint_compat = true,
    config = {
        extra = {
            repetitions = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        return{
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--photo - done!
SMODS.Joker {
    key = "family_photo",
    rarity = 1,
    atlas = "WillatroEvolved",
    pos = {x = 1, y = 0},
    cost = 5,
    blueprint_compat = true,
    config = {
        extra = {
            x_mult = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        return{
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--clueless - done!
SMODS.Joker {
    key = "clueless",
    rarity = 1,
    atlas = "WillatroEvolved",
    pos = {x = 4, y = 0},
    cost = 0,
    blueprint_compat = true,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            SMODS.destroy_cards(card)
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_face() and G.GAME.round_resets.ante < 32 and G.GAME.round_resets.blind_ante < 32 then
                    ease_ante(32 - G.GAME.round_resets.ante)
                    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + (32 - G.GAME.round_resets.ante)
                    break
                end
            end
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--caviar - done!
SMODS.Joker {
    key = "caviar",
    rarity = 1,
    atlas = "WillatroEvolved",
    pos = {x = 5, y = 0},
    cost = 4,
    blueprint_compat = false,
    config  = {
        extra = {
            sell_value = 3
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.sell_value
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            for _, area in ipairs({ G.jokers, G.consumeables }) do
                for _, other_card in ipairs(area.cards) do
                    if other_card.set_cost then
                        other_card.ability.extra_value = (other_card.ability.extra_value or 0) +
                            card.ability.extra.sell_value
                        other_card:set_cost()
                    end
                end
            end
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--composite carl - done!
SMODS.Joker {
    key = "composite_carl",
    rarity = 1,
    atlas = "WillatroEvolved",
    pos = {x = 0, y = 1},
    cost = 0,
    blueprint_compat = true,
    config  = {
        extra = {
            x_mult = 1.6
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() <= 10 and Prime(context.other_card:get_id()) == false then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--prime patrick - done!
SMODS.Joker {
    key = "prime_patrick",
    rarity = 1,
    atlas = "WillatroEvolved",
    pos = {x = 1, y = 1},
    cost = 4,
    blueprint_compat = true,
    config  = {
        extra = {
            x_chips = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_chips
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() <= 10 and Prime(context.other_card:get_id()) == true then
            return {
                x_chips = card.ability.extra.x_chips
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--hypernova - done!
SMODS.Joker {
    key = "hypernova",
    rarity = 1,
    atlas = "WillatroEvolved",
    pos = {x = 2, y = 1},
    cost = 5,
    blueprint_compat = true,
    config = {
        extra = {
            mult = 0
        }
    },

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.mult = 0
            for k, v in pairs(G.GAME.hands) do
                if k ~= context.scoring_name then
                    card.ability.extra.mult = card.ability.extra.mult + v.played
                end
            end
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--#endregion


--#region uncommon

--what!? all twelves - done!
SMODS.Joker {
    key = "what_all_twelves",
    rarity = 2,
    atlas = "WillatroEvolved",
    pos = {x = 2, y = 0},
    cost = 4,
    blueprint_compat = false,

    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator * 4
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--#endregion


--#region rare

--atomic joker - done!
SMODS.Joker {
    key = "atomic_joker",
    rarity = 3,
    atlas = "WillatroEvolved",
    pos = {x = 3, y = 0},
    cost = 8,
    blueprint_compat = true,
    config = {
        extra = {
            chip_gain = 0.25,
            chips = 0,
            cap = 256
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chip_gain,
                card.ability.extra.chips,
                card.ability.extra.cap
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 2 and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and card.ability.extra.chip_gain < card.ability.extra.cap then
            card.ability.extra.chip_gain = card.ability.extra.chip_gain * 2
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--ashes - done!
SMODS.Joker {
    key = "ashes",
    rarity = 3,
    atlas = "WillatroEvolved",
    pos = {x = 6, y = 0},
    cost = 8,
    blueprint_compat = false,
    config = {
        extra = {
            scored_hands = {}
        }
    },

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            card.ability.extra.scored_hands[#card.ability.extra.scored_hands+1] = context.scoring_name
        end
        if context.end_of_round and context.game_over == false and context.main_eval and card.ability.extra.scored_hands and not context.blueprint then
            local all_hands = {
                'Flush Five', 'Flush House', 'Five of a Kind', 'Straight Flush', 'Four of a Kind',
                'Full House', 'Flush', 'Straight', 'Three of a Kind', 'Two Pair', 'Pair', 'High Card'
            }
            
            local played_hands = {}
            for i = 1, #card.ability.extra.scored_hands do
                played_hands[card.ability.extra.scored_hands[i]] = true
            end
            
            for _, hand in ipairs(all_hands) do
                if not played_hands[hand] then
                    SMODS.smart_level_up_hand(card, hand, false, 3)
                end
            end
            
            card.ability.extra.scored_hands = {}
        end
    end,

    in_pool = function(self, args)
        return false
    end
}


--#endregion

SMODS.Tag {
    key = "boost_tag",
    atlas = "WillatroTags",
    pos = { x = 0, y = 0 },
    min_ante = 2,

    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_willatro_boostable_pack
    end,

    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.PURPLE, function()
                local booster = SMODS.create_card { key = 'p_willatro_boostable_pack', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

SMODS.Booster {
    key = "boostable_pack",
    group_key = "k_willatro_boostable_pack",
    atlas = "WillatroEvolved",
    pos = { x = 5, y = 1 },
    kind = "Boostable",
    draw_hand = false,
    config = {
        extra = 2,
        choose = 1
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra
            }
        }
    end,

    create_card = function(self, card, i)
        return { set = "Upgradeable" }
    end,

    in_pool = function(self, args)
        return false
    end
}