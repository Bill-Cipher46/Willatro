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
    key = "willatro_Upgradeable",
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
        ["j_supernova"] = true,
        ["j_smeared"] = true,
        ["j_brainstorm"] = true,
        ["j_scholar"] = true,
        ["j_splash"] = true,
        ["j_sixth_sense"] = true,
        ["j_riff_raff"] = true,
        ["j_vagabond"] = true,
        ["j_erosion"] = true,
        ["j_golden"] = true,
        ["j_scary_face"] = true,
        ["j_bloodstone"] = true,
        ["j_rough_gem"] = true,
        ["j_arrowhead"] = true,
        ["j_onyx_agate"] = true,
        ["j_ring_master"] = true,
        ["j_willatro_familiarweapon"] = true,
        ["j_willatro_pear"] = true,
        ["j_superposition"] = true,
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
    ["j_smeared"] = {
        key = "j_willatro_messy_joker",
        upgradeable = true
    },
    ["j_brainstorm"] = {
        key = "j_willatro_million_dollar_idea",
        upgradeable = true
    },
    ["j_scholar"] = {
        key = "j_willatro_ivy_league_diploma",
        upgradeable = true
    },
    ["j_splash"] = {
        key = "j_willatro_flood",
        upgradeable = true
    },
    ["j_sixth_sense"] = {
        key = "j_willatro_precognition",
        upgradeable = true
    },
    ["j_riff_raff"] = {
        key = "j_willatro_crowd",
        upgradeable = true
    },
    ["j_vagabond"] = {
        key = "j_willatro_millionaire",
        upgradeable = true
    },
    ["j_erosion"] = {
        key = "j_willatro_canyon",
        upgradeable = true
    },
    ["j_golden"] = {
        key = "j_willatro_platinum",
        upgradeable = true
    },
    ["j_scary_face"] = {
        key = "j_willatro_cheshire_smile",
        upgradeable = true
    },
    ["j_bloodstone"] = {
        key = "j_willatro_redstone",
        upgradeable = true
    },
    ["j_rough_gem"] = {
        key = "j_willatro_diamond",
        upgradeable = true
    },
    ["j_arrowhead"] = {
        key = "j_willatro_obsidian",
        upgradeable = true
    },
    ["j_onyx_agate"] = {
        key = "j_willatro_lapis_lazuli",
        upgradeable = true
    },
    ["j_ring_master"] = {
        key = "j_willatro_special_effects",
        upgradeable = true
    },
    ["j_willatro_familiarweapon"] = {
        key = "j_willatro_hellforged_weapon",
        upgradeable = true
    },
    ["j_willatro_pear"] = {
        key = "j_willatro_triple_baka",
        upgradeable = true
    },
    ["j_superposition"] = {
        key = "j_willatro_string_theory",
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

--ivy league - done!
SMODS.Joker {
    key = "ivy_league_diploma",
    rarity = 1,
    atlas = "WillatroEvolved",
    pos = {x = 6, y = 1},
    cost = 4,
    blueprint_compat = true,
    config = {
        extra = {
            x_mult = 1.5,
            x_chips = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_chips,
                card.ability.extra.x_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card:get_id() == 14 then
                return {
                    x_chips = card.ability.extra.x_chips,
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--flood - done!
SMODS.Joker {
    key = "flood",
    atlas = "WillatroEvolved",
    blueprint_compat = false,
    rarity = 1,
    cost = 3,
    pos = { x = 0, y = 2 },
    config = {
        extra = {
            selection_limit = 5
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.selection_limit
            }
        }
    end,

    calculate = function(self, card, context)
        if context.modify_scoring_hand and not context.blueprint then
            return {
                add_to_hand = true
            }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(card.ability.extra.selection_limit)
		SMODS.change_discard_limit(card.ability.extra.selection_limit)
	end,

	remove_from_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(-card.ability.extra.selection_limit)
		SMODS.change_discard_limit(-card.ability.extra.selection_limit)
		if not G.GAME.before_play_buffer then
			G.hand:unhighlight_all()
		end
	end,

    in_pool = function(self, args)
        return false
    end
}

--string theory - done!
SMODS.Joker {
    key = "string_theory",
    atlas = "WillatroEvolved",
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    pos = { x = 2, y = 2 },
    config = {
        extra = {
            chips = 30,
            mult = 4
        }
    },

    loc_vars = function(self, info_queue, card)
        card.ability.extra.chips = to_number(G.GAME.hands["Straight"].chips)
        card.ability.extra.mult = to_number(G.GAME.hands["Straight"].mult)

        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        card.ability.extra.chips = to_number(G.GAME.hands["Straight"].chips)
        card.ability.extra.mult = to_number(G.GAME.hands["Straight"].mult)

        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--crowd - done!
SMODS.Joker {
    key = "crowd",
    blueprint_compat = true,
    atlas = "WillatroEvolved",
    rarity = 1,
    cost = 6,
    pos = { x = 3, y = 2 },
    config = {
        extra = {
            creates = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.creates
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.extra.creates,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
                            key_append = 'willatro_crowd'
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.BLUE,
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--platinum - done!
SMODS.Joker {
    key = "platinum",
    blueprint_compat = false,
    atlas = "WillatroEvolved",
    rarity = 1,
    cost = 6,
    pos = { x = 6, y = 2 },
    config = {
        extra = {
            dollars = 4,
            total = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        local sell_cost = 0
        card.ability.extra.total = 0
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            sell_cost = sell_cost + joker.sell_cost
        end

        card.ability.extra.total = card.ability.extra.total + sell_cost + card.ability.extra.dollars

        return {
            vars = {
                card.ability.extra.dollars,
                card.ability.extra.total
            }
        }
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.total
    end,

    in_pool = function(self, args)
        return false
    end
}

--cheshire smile - done!
SMODS.Joker {
    key = "cheshire_smile",
    blueprint_compat = true,
    perishable_compat = false,
    atlas = "WillatroEvolved",
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 3 },
    config = {
        extra = {
            small_xchip_gain = 1,
            xchip_gain = 2,
            x_chips = 1,
            faces = false
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.small_xchip_gain,
                card.ability.extra.xchip_gain,
                card.ability.extra.x_chips
            }
        }
    end,

    calculate = function(self, card, context)

        if context.joker_main then
            local toDestroy = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() == true then
                    card.ability.extra.faces = true

                    toDestroy = toDestroy + 1
                end
            end

            if toDestroy > 0 and not context.blueprint then
                card.ability.extra.x_chips = card.ability.extra.x_chips + (card.ability.extra.small_xchip_gain * toDestroy)
            end

            return {
                x_chips = card.ability.extra.x_chips
            }
        end

        if context.scoring_hand and context.destroy_card and not context.blueprint then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() == true and context.destroy_card:is_face() == true and context.destroy_card == context.scoring_hand[i] then

                    return {
                        remove = true,
                        message = localize('k_upgrade_ex')
                    }
                end
            end
        end

        if context.end_of_round then
            if card.ability.extra.faces == false and context.game_over == false and context.main_eval and not context.blueprint then
                local deletable_jokers = {}
                for _, joker in pairs(G.jokers.cards) do
                    if not SMODS.is_eternal(joker, card) and joker ~= card then
                        deletable_jokers[#deletable_jokers + 1] = joker
                    end
                end

                local chosen_joker = pseudorandom_element(deletable_jokers, 'cheshire_choice')
                local _first_dissolve = nil
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.75,
                    func = function()
                        chosen_joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                        return true
                    end
                }))

                card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.xchip_gain

                return {
                    message = localize('k_upgrade_ex')
                }
            else
                card.ability.extra.faces = false
            end
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

--messy - done!
SMODS.Joker {
    key = "messy_joker",
    rarity = 2,
    atlas = "WillatroEvolved",
    pos = {x = 3, y = 1},
    cost = 7,
    blueprint_compat = false,

    in_pool = function(self, args)
        return false
    end
}

--precognition - done!
SMODS.Joker {
    key = "precognition",
    rarity = 2,
    atlas = "WillatroEvolved",
    pos = {x = 1, y = 2},
    cost = 6,
    blueprint_compat = true,
    config = {
        extra = {
            odds = 6
        }
    },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,

    calculate = function(self, card, context)
        if context.scoring_hand and context.destroy_card and not context.blueprint then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 6 and context.destroy_card:get_id() == 6 then
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {
                                set = 'Spectral',
                                key_append = 'willatro_precognition'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    return {
                        message = localize('k_plus_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral,
                        remove = true
                    }
                end
            end
        end

        if context.first_hand_drawn then
            if SMODS.pseudorandom_probability(card, 'willatro_precognition', 1, card.ability.extra.odds) then
                local _card = SMODS.create_card { set = "Base", seal = SMODS.poll_seal({ guaranteed = false, type_key = 'willatro_precognition' }),
                edition = poll_edition({ _key = 'j_willatro_precognition', _no_neg = true, _guaranteed = false, }), rank = 6,
                enhancement = SMODS.poll_enhancement({ guaranteed = false, type_key = 'willatro_precognition' }), area = G.discard }
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                _card.playing_card = G.playing_card
                table.insert(G.playing_cards, _card)

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand:emplace(_card)
                        _card:start_materialize()
                        G.GAME.blind:debuff_card(_card)
                        G.hand:sort()
                        if context.blueprint_card then
                            context.blueprint_card:juice_up()
                        else
                            card:juice_up()
                        end
                        SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
                        save_run()
                        return true
                    end
                }))

                return nil, true
            end
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--canyon - done!
SMODS.Joker {
    key = "canyon",
    rarity = 2,
    atlas = "WillatroEvolved",
    pos = {x = 5, y = 2},
    cost = 6,
    blueprint_compat = true,
    config = {
        extra = {
            x_mult = 5
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                G.GAME.starting_deck_size
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if #G.playing_cards < (G.GAME.starting_deck_size / 2) then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--redstone - done!
SMODS.Joker {
    key = "redstone",
    rarity = 2,
    atlas = "WillatroEvolved",
    pos = {x = 2, y = 3},
    cost = 7,
    blueprint_compat = true,
    config = {
        extra = {
            x_mult = 2.5
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
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end

        if context.debuff_card and (context.debuff_card:is_suit("Clubs") or context.debuff_card:is_suit("Spades") or context.debuff_card:is_suit("Diamonds")) then
            return {
                debuff = true
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--diamond - done!
SMODS.Joker {
    key = "diamond",
    rarity = 2,
    atlas = "WillatroEvolved",
    pos = {x = 1, y = 3},
    cost = 7,
    blueprint_compat = true,
    config = {
        extra = {
            dollars = 4
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end

        if context.debuff_card and (context.debuff_card:is_suit("Clubs") or context.debuff_card:is_suit("Spades") or context.debuff_card:is_suit("Hearts")) then
            return {
                debuff = true
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--obsidian - done!
SMODS.Joker {
    key = "obsidian",
    rarity = 2,
    atlas = "WillatroEvolved",
    pos = {x = 3, y = 3},
    cost = 7,
    blueprint_compat = true,
    config = {
        extra = {
            x_chips = 1.5
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
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Spades") then
            return {
                x_chips = card.ability.extra.x_chips
            }
        end

        if context.debuff_card and (context.debuff_card:is_suit("Clubs") or context.debuff_card:is_suit("Hearts") or context.debuff_card:is_suit("Diamonds")) then
            return {
                debuff = true
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--lapis lazuli - done!
SMODS.Joker {
    key = "lapis_lazuli",
    rarity = 2,
    atlas = "WillatroEvolved",
    pos = {x = 4, y = 3},
    cost = 7,
    blueprint_compat = true,
    config = {
        extra = {
            mult = 35
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
            return {
                mult = card.ability.extra.mult
            }
        end

        if context.debuff_card and (context.debuff_card:is_suit("Hearts") or context.debuff_card:is_suit("Spades") or context.debuff_card:is_suit("Diamonds")) then
            return {
                debuff = true
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--special effects - done!
SMODS.Joker {
    key = "special_effects",
    rarity = 2,
    atlas = "WillatroEvolved",
    pos = {x = 5, y = 3},
    cost = 5,
    blueprint_compat = false,
    config = {
        extra = {
            odds = 3
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        local numerator, denominator = SMODS.get_probability_vars(card, 2, card.ability.extra.odds)
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,

    calculate = function(self, card, context)
        if not context.blueprint and context.buying_card and (context.card.ability.set == "Joker" or context.card.ability.set == "Planet" or context.card.ability.set == "Spectral" or context.card.ability.set == "Tarot") then
            if SMODS.pseudorandom_probability(card, 'willatro_special_effects', 2, card.ability.extra.odds) then
                local _card = context.card.config.center.key
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.4,
                    func = function()
                        SMODS.add_card {
                            key = _card,
                            edition = 'e_negative'
                        }
                        return true
                    end
                }))
            end
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--hellforged weapon - done!
SMODS.Joker {
    key = "hellforged_weapon",
    rarity = 2,
    atlas = "WillatroEvolved",
    pos = {x = 6, y = 3},
    cost = 6,
    blueprint_compat = true,
    config = {
        extra = {
            mult_gain = 20,
            mult = 0,
            message = false,
            play = false
        }
    },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult_gain,
                card.ability.extra.mult,
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local toDestroy = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() <= 9 then
                    toDestroy = toDestroy + 1
                end
            end
            if toDestroy > 0 and not context.blueprint then
                card.ability.extra.mult = card.ability.extra.mult + (toDestroy * card.ability.extra.mult_gain)
            end
            return {
                mult = card.ability.extra.mult
            }
        end

        if context.destroy_card and context.cardarea == G.play and not context.blueprint then
            if context.destroy_card:get_id() <= 9 then
                card.ability.extra.message = true
                return {
                    remove = true
                }
            end
        end
        if not context.after and card.ability.extra.message == true then
            card.ability.extra.play = true
            card.ability.extra.message = false
            return { 
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if card.ability.extra.play == true then
                            card:juice_up(0.8, 0.8)
                            play_sound('slice1', 0.96 + math.random() * 0.08)
                            card.ability.extra.play = false
                        end
                        return true
                    end
                }))
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
                    SMODS.smart_level_up_hand(card, hand)
                end
            end
            
            card.ability.extra.scored_hands = {}
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--million dollar idea - done!
SMODS.Joker {
    key = "million_dollar_idea",
    rarity = 3,
    atlas = "WillatroEvolved",
    pos = {x = 4, y = 1},
    cost = 10,
    blueprint_compat = true,
    config = {
        extra = {
            money = 6
        }
    },

    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local compatible = G.jokers.cards[1] and G.jokers.cards[1] ~= card and
                G.jokers.cards[1].config.center.blueprint_compat
                main_end = {
                    {
                        n = G.UIT.C,
                        config = { align = "bm", minh = 0.4 },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                                nodes = {
                                    { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                                }
                            }
                        }
                    }
                }
            return { 
                main_end = main_end,
                vars  = {
                    card.ability.extra.money
                }
            }
        end
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,

    calculate = function(self, card, context)
        local ret = SMODS.blueprint_effect(card, G.jokers.cards[1], context)
        if ret then
            ret.colour = G.C.RED
            ease_dollars(card.ability.extra.money)
        end
        return ret
    end,

    in_pool = function(self, args)
        return false
    end
}

--millionaire - done!
SMODS.Joker {
    key = "millionaire",
    rarity = 3,
    atlas = "WillatroEvolved",
    pos = {x = 4, y = 2},
    cost = 8,
    blueprint_compat = true,
    config = {
        extra = {
            money = 10,
            limit = 9
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money,
                card.ability.extra.limit
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.dollars >= to_big(card.ability.extra.money) then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {
                                set = 'Tarot',
                                key_append = 'willatro_millionaire'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    return {
                        message = localize('k_plus_tarot'),
                    }
                end
            else
                ease_dollars(card.ability.extra.money)
            end
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--triple baka - done!
SMODS.Joker {
    key = "triple_baka",
    rarity = 3,
    atlas = "WillatroEvolved",
    pos = {x = 0, y = 4},
    cost = 8,
    blueprint_compat = true,
    config = {
        extra = {
            hands = {
                "High Card",
                "Pair",
                "Three of a Kind"
            },
            small_upgrade = 1,
            big_upgrade = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = {
                card.ability.extra.big_upgrade,
                card.ability.extra.small_upgrade,
            }
        }
    end,

    calculate = function(self, card, context)
        local hands = {
            "High Card",
            "Pair",
            "Three of a Kind"
        }

        if context.before and context.main_eval then
            for i = 1, #hands do
                if hands[i] == context.scoring_name then
                    SMODS.smart_level_up_hand(card, hands[i], nil, card.ability.extra.big_upgrade)
                else
                    SMODS.smart_level_up_hand(card, hands[i], nil, card.ability.extra.small_upgrade)
                end
            end
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
        return { set = "willatro_Upgradeable" }
    end,

    in_pool = function(self, args)
        return false
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX('c2b7b7'))
        ease_background_colour({ new_colour = HEX('6a5050'), special_colour = HEX('c2b7b7'), contrast = 2 })
    end
}