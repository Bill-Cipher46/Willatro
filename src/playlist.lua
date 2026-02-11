SMODS.Atlas {
    key = "WillatroPlaylist",
    path = "WillowSongs.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "PlaylistSticker",
    path = "WillowStickers.png",
    px = 25,
    py = 25
}

SMODS.Rarity {
    key = "playlist",
    loc_txt = {},
    badge_colour = HEX("f28a0a"),
    default_weight = 0.25
}

SMODS.ObjectType {
    key = "willatro_playlist_set",
    default = "j_willatro_heart"
}

--#region Jokers 

--telapathy
SMODS.Joker {
    key = "telepathy",
    rarity = "willatro_playlist",
    atlas = "WillatroPlaylist",
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = false,
    pools = {
        ["willatro_playlist_set"] = true
    },
    config = {
        extra = {
            blind1 = "???",
            blind2 = "???",
            blind3 = "???"
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.blind1,
                card.ability.extra.blind2,
                card.ability.extra.blind3
            }
        }
    end,

    calculate = function(self, card, context)
        local predictions = predict_next_bosses(3)
        
        if next(SMODS.find_card("j_willatro_consciousness")) then
            for i, prediction in ipairs(predictions) do
                if prediction.ante % 8 == 0 then
                    prediction.boss = "bl_willatro_virulent_void"
                else
                    prediction.boss = "bl_willatro_hollow"
                end
            end
        end

        card.ability.extra.blind1 = localize({type = 'name_text', key = predictions[1].boss, set = 'Blind'})
        card.ability.extra.blind2 = localize({type = 'name_text', key = predictions[2].boss, set = 'Blind'})
        card.ability.extra.blind3 = localize({type = 'name_text', key = predictions[3].boss, set = 'Blind'})
    end
}

--monitoring
SMODS.Joker {
    key = "monitoring",
    rarity = "willatro_playlist",
    atlas = "WillatroPlaylist",
    pos = { x = 1, y = 0 },
    cost = 5,
    blueprint_compat = false,
    pools = {
        ["willatro_playlist_set"] = true
    },
}

--goodbye
SMODS.Joker {
    key = "goodbye_to_a_world",
    rarity = "willatro_playlist",
    atlas = "WillatroPlaylist",
    pos = { x = 2, y = 0 },
    cost = 5,
    blueprint_compat = false,
    eternal_compat = false,
    pools = {
        ["willatro_playlist_set"] = true
    },

    calculate = function(self, card, context)

        if context.after and G.GAME.chips / G.GAME.blind.chips >= to_big(0.5) and G.GAME.current_round.hands_left <= 0 and not context.blueprint then

            for i = 1, #G.jokers.cards do
                G.jokers.cards[i].ability.willatro_saved = true
                G.jokers.cards[i]:set_cost()
            end


            ease_discard(G.GAME.round_resets.discards + G.GAME.round_bonus.discards - G.GAME.current_round.discards_left)
            ease_hands_played(G.GAME.round_resets.hands + G.GAME.round_bonus.next_hands - G.GAME.current_round.hands_left)

            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()

                    play_sound('tarot1')
                    card:start_dissolve()

                    return true
                end
            }))

        end
    end,
}

--liar dancer
SMODS.Joker {
    key = "liar_dancer",
    rarity = "willatro_playlist",
    atlas = "WillatroPlaylist",
    pos = { x = 3, y = 0 },
    cost = 5,
    blueprint_compat = true,
    perishable_compat = false,
    pools = {
        ["willatro_playlist_set"] = true
    },
    config = {
        extra = {
            mult_gain = 4,
            mult = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { key = "tag_boss", set = "Tag" }

        return {
            vars = {
                localize { type = 'name_text', set = 'Tag', key = 'tag_boss' },
                card.ability.extra.mult_gain,
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        
        if context.setting_blind then
            add_tag(Tag("tag_boss"))

            if not context.blueprint then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

--butcher vanity - done!
SMODS.Joker {
    key = "butcher_vanity",
    rarity = "willatro_playlist",
    atlas = "WillatroPlaylist",
    pos = { x = 5, y = 0 },
    cost = 5,
    blueprint_compat = true,
    perishable_compat = false,
    pools = {
        ["willatro_playlist_set"] = true
    },
    config = {
        extra = {
            odds = 2,
            mult_gain = 15,
            mult = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)

        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.mult_gain,
                card.ability.extra.mult,
                colours = { G.C.RARITY["willatro_organ"] }
            }
        }
    end,

    calculate = function(self, card, context)

        if context.ending_shop and #G.jokers.cards <= G.jokers.config.card_limit and SMODS.pseudorandom_probability(card, 'willatro_butcher', 1, card.ability.extra.odds) and not context.blueprint then
            local _card = SMODS.create_card({
                set = "Joker",
                key = "j_willatro_cadaver",
                area = G.jokers,
                edition = "e_negative"
            })
            _card:add_to_deck()
            G.jokers:emplace(_card)
        end

        if context.setting_blind and not context.blueprint then
            local destroy = false

            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i]:is_rarity("willatro_organ") or G.jokers.cards[i]:is_rarity("willatro_Organ") or G.jokers.cards[i].config.center.key == "j_willatro_cadaver" then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                    SMODS.destroy_cards(G.jokers.cards[i], nil, nil, true)
                    destroy = true
                end
            end

            if destroy == true then
                return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
            }
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

--town inside me - done!
SMODS.Joker {
    key = "the_town_inside_me",
    rarity = "willatro_playlist",
    atlas = "WillatroPlaylist",
    pos = { x = 0, y = 1 },
    cost = 5,
    blueprint_compat = true,
    pools = {
        ["willatro_playlist_set"] = true
    },
    config = {
        extra = {
            x_mult = 1.5
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
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 12 then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end
}

--black knife 
SMODS.Joker {
    key = "black_knife",
    rarity = "willatro_playlist",
    atlas = "WillatroPlaylist",
    pos = { x = 1, y = 1 },
    cost = 5,
    pools = {
        ["willatro_playlist_set"] = true
    },

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and #G.jokers.cards < G.jokers.config.card_limit then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card and i < #G.jokers.cards then
                    SMODS.destroy_cards(G.jokers.cards[i+1], nil, nil, true)

                    local _card = SMODS.create_card({
                        set = "Joker",
                        key = "j_willatro_swooned_joker",
                        area = G.jokers
                    })
                    _card:add_to_deck()
                    G.jokers:emplace(_card)
                end
            end
        end
    end
}

--swooned
SMODS.Joker {
    key = "swooned_joker",
    rarity = "willatro_playlist",
    atlas = "WillatroPlaylist",
    pos = { x = 2, y = 1 },
    cost = 5,
    blueprint_compat = true,
    pools = {
        ["willatro_playlist_set"] = true
    },

    config = {
        extra = {
            small_xmult = 1.5,
            big_xmult = 2
        }
    },

    loc_vars = function(slef, info_queue, card)
        return {
            vars = {
                card.ability.extra.small_xmult,
                card.ability.extra.big_xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.other_joker then
            if context.other_joker.config.center.key == "j_willatro_swooned_joker" then
                return {
                    x_mult = card.ability.extra.small_xmult
                }
            end
                
            if context.other_joker.config.center.key == "j_willatro_black_knife" then
                return {
                    x_mult = card.ability.extra.big_xmult
                }
            end
        end
    end
}

--#endregion


--hallucination sticker
SMODS.Sticker {
    key = "willatro_hallucination_sticker",
    atlas = "PlaylistSticker",
    sets = {
        Joker = true
    },
    badge_colour = HEX('ed6a71'),

    should_apply = function(self, card)
        if next(SMODS.find_card("j_willatro_monitoring")) and card.ability.set == "Joker" and not card.eternal and pseudorandom("hallucination") < 0.3 then
            return true
        end
    end

}

SMODS.Booster {
    key = "playlist_pack",
    group_key = "k_willatro_playlist_pack",
    atlas = "WillatroPlaylist",
    cost = 5,
    weight = 0.9,
    pos = { x = 4, y = 0 },
    kind = "Playlist",
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = { 
                    G.C.RARITY["willatro_playlist"] 
                },
                card.ability.choose,
                card.ability.extra
            }
        }
    end,

    create_card = function(self, card, i)
        return { set = "willatro_playlist_set" }
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.RARITY["willatro_playlist"])
        ease_background_colour({ new_colour = HEX('00ecfe'), special_colour = G.C.RARITY["willatro_playlist"], contrast = 2 })
    end
}