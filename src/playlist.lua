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

--#region Jokers 

--telapathy
SMODS.Joker {
    key = "telepathy",
    rarity = "willatro_playlist",
    atlas = "WillatroPlaylist",
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = false,
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


--#endregion


--hallucination sticker
SMODS.Sticker {
    key = "willatro_hallucination_sticker",
    atlas = "PlaylistSticker",
    sets = {
        Joker = true
    },
    badge_colour = HEX('ed6a71'),

    calculate = function(self, card, context)
        if context.buying_self and card.ability.willatro_hallucination_sticker then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            card:remove()
                            return true
                        end
                    }))
                    return true
                end
            }))

            ease_dollars(4*card.sell_cost)
        end
    end,

    should_apply = function(self, card)
        if next(SMODS.find_card("j_willatro_monitoring")) and card.ability.set == "Joker" and not card.eternal and pseudorandom("hallucination") < 0.3 then
            return true
        end
    end

}