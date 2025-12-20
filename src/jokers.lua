SMODS.Atlas
{
    key = "WillatroJokers",
    path = "WillowJokers.png",
    px = 71,
    py = 95
}

--#region common
--loss - done!
SMODS.Joker
{
    key = "loss",
    rarity = 1,
    atlas = "WillatroJokers",
    pos = {x = 1, y = 0},
    cost = 4,
    blueprint_compat = false,
    config = { 
        extra = { 
            created_tag = false 
        } 
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_ethereal
        return {
            vars = {
                localize { type = "name_text", set = "Tag", key = "tag_ethereal" },
                card.ability.extra.created_tag 
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before then
            local queens = 0
            local twos = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 2 then twos = twos + 1 end
                if context.scoring_hand[i]:get_id() == 12 then queens = queens + 1 end
            end
            if twos > 0 and twos < 2 and queens > 0 and queens < 2 then
                card.ability.extra.created_tag = true
            end
        end

        if context.destroy_card and context.cardarea == G.play and not context.blueprint then
            if card.ability.extra.created_tag == true then

                if context.destroy_card:get_id() == 2 then
                    card.ability.extra.created_tag = false
                    return
                    {
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    add_tag(Tag('tag_ethereal'))
                                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                                    return true
                                end)
                            }))
                        end,
                        remove = true
                    }
                end
            end
        end
    end
}

--barcode - done!
SMODS.Joker
{
    key = "barcode",
    rarity = 1,
    atlas = "WillatroJokers",
    pos = {x = 4, y = 0},
    cost = 4,
    blueprint_compat = false,
    config = { 
        extra = {
            money = 2
        } 
    },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.money,
                card.ability.extra.money * (G.jokers and #G.jokers.cards or 0)
            } 
        }
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.money * (#G.jokers.cards or 0)
    end
}

--cyan - done!
SMODS.Joker
{
    key = "cyan",
    rarity = 1,
    atlas = "WillatroJokers",
    pos = {x = 2, y = 1 },
    cost = 4,
    blueprint_compat = true,
    config = { 
        extra = { 
            chips = 1, 
            mult = 1, 
            mega_chips = 500, 
            mega_mult = 7, 
            odds = 70 
        } 
    },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { 
            vars = { 
                card.ability.extra.chips, 
                card.ability.extra.mult, 
                card.ability.extra.mega_chips, 
                card.ability.extra.mega_mult,
                numerator, 
                denominator 
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local chance_hit = false
            if SMODS.pseudorandom_probability(card, 'willatro_cyan', 1, card.ability.extra.odds) then
                chance_hit = true
            end
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                extra = chance_hit and { 
                    chips = card.ability.extra.mega_chips,
                    x_mult = card.ability.extra.mega_mult
                } or nil,
            }
        end
    end
}

--troll - done!
SMODS.Joker
{
    key = "troll",
    rarity = 1,
    atlas = "WillatroJokers",
    pos = {x = 2, y = 2 },
    cost = 0,
    blueprint_compat = true,
    config = {
        extra = {
            mult = -10
        }
    },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

--silver mirror - done!
SMODS.Joker
{
    key = "silvermirror",
    rarity = 1,
    atlas = "WillatroJokers",
    pos = {x = 6, y = 2 },
    cost = 4,
    blueprint_compat = false,
    eternal_compat = false,
    config = {
        extra = {
            odds = 15,
            vampire = nil
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_glass
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {
            vars = {
                numerator,
                denominator,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.check_enhancement then
            if context.other_card.config.center.key == "m_glass" then
                return { 
                    m_steel = true 
                }
            end
        end

        --debuff vampire if next to mirror
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.key == 'j_vampire' then
                local vampire = G.jokers.cards[i]
                if i > 1 then
                    if G.jokers.cards[i-1] == card then
                        SMODS.debuff_card(vampire, true, "j_willatro_silvermirror")
                    else
                        SMODS.debuff_card(vampire, false, "j_willatro_silvermirror")
                    end
                end
                if i < #G.jokers.cards then
                    if G.jokers.cards[i+1] == card then
                        SMODS.debuff_card(vampire, true, "j_willatro_silvermirror")
                    else
                        SMODS.debuff_card(vampire, false, "j_willatro_silvermirror")
                    end
                end
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'willatro_silvermirror', 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('glass1')
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
                                SMODS.add_card({ key = 'j_willatro_brokenmirror' })
                                card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = "Shattered!"
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
    end
}

--lime - done!
SMODS.Joker
{
    key = "lime",
    rarity = 1,
    atlas = "WillatroJokers",
    pos = { x = 1, y = 3 },
    cost = 5,
    blueprint_compat = false,
    eternal_compat = false,
    config = {
        extra = {
            dollars = 3,
            odds = 6,
            money = true
        }
    },

    loc_vars  = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {
            vars = {
                card.ability.extra.dollars,
                numerator,
                denominator
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'willatro_lime', 1, card.ability.extra.odds) then
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
                G.GAME.pool_flags.j_willatro_lime_extinct = true
                card.ability.money = false
                return {
                    message = localize('k_extinct_ex')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
    end,

    calc_dollar_bonus = function(self, card)
        if card.ability.extra.money == true then
            return card.ability.extra.dollars
        end
    end,

    in_pool = function(self, args)
        return not G.GAME.pool_flags.j_willatro_lime_extinct
    end
}

--lemon - done!
SMODS.Joker
{
    key = "lemon",
    rarity = 1,
    atlas = "WillatroJokers",
    pos = { x = 2, y = 3 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = false,
    config = {
        extra = {
            odds = 2,
            dollars = 2,
            bigodds = 1000
        }
    },

    loc_vars  = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        local numerator, denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.bigodds)
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.dollars,
                denominator2
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.pseudorandom_probability(card, 'willatro_lemon', 1, card.ability.extra.odds) then
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
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'willatro_lemon', 1, card.ability.extra.bigodds) then
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
                return {
                    message = localize('k_extinct_ex')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
    end,

    in_pool = function(self, args)
        return G.GAME.pool_flags.j_willatro_lime_extinct
    end
}

--cadaver - done!
SMODS.Joker
{
    key = "cadaver",
    rarity = 1,
    atlas = "WillatroJokers",
    pos = { x = 1, y = 4 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = false,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = { G.C.RARITY["willatro_organ"] }
            }
        }
    end,

    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            card_eval_status_text(
                card,
                "extra",
                nil,
                nil,
                nil,
                { 
                    message = localize("k_plus_joker"), colour = G.C.RARITY["willatro_organ"] 
                }
            )
            local card = create_card("Joker", G.jokers, nil, "willatro_organ", nil, nil, nil, "willatro_cadaver")
            card:add_to_deck()
            G.jokers:emplace(card)
            card:start_materialize()
        end
    end
}
--#endregion

--#region uncommon
--familiar weapon - done!
SMODS.Joker 
{
    key = "familiarweapon",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = {x = 3, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = false,
    config = { 
        extra = { 
            chip_gain = 20, 
            chips = 0, 
            message = false, 
            play = false
        } 
    },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.chip_gain, 
                card.ability.extra.chips,
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local toDestroy = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() < 9 then
                    toDestroy = toDestroy + 1
                end
            end
            if toDestroy > 0 and not context.blueprint then
                card.ability.extra.chips = card.ability.extra.chips + (toDestroy * card.ability.extra.chip_gain)
            end
            return {
                chips = card.ability.extra.chips
            }
        end

        if context.destroy_card and context.cardarea == G.play and not context.blueprint then
            if context.destroy_card:get_id() < 9 then
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
    end
}

--jokerobot - done!
SMODS.Joker 
{
    key = "jokerobot",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = {x = 5, y = 0},
    cost = 7,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_face() then
                    faces = faces + 1
                    scored_card:set_ability("m_steel", nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if faces > 0 then
                return {
                    message = 'Steel',
                    colour = G.C.UI.TEXT_DARK
                }
            end
        end
    end
}

--bodyguard - done!
SMODS.Joker
{
    key = "bodyguard",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = {x = 0, y = 1},
    cost = 8,
    eternal_compat = false,
    blueprint_compat = false,

    calculate = function(self, card, context)
        if G.jokers and not context.blueprint then
            for i = 1, #G.jokers.cards do
                if context.selling_self and G.jokers.cards[i] == card then
                    G.jokers.cards[i+1]:set_eternal(true)
                end
            end
        end
    end
}

--jokergummy - done!
SMODS.Joker 
{
    key = "jokergummy",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = {x = 1, y = 1 },
    cost = 7,
    blueprint_compat = true,
    config = { 
        extra = { 
            mult = 5, 
        } 
    },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult, 
                card.ability.extra.mult * (G.GAME.willatro_jokers_bought or 0)
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult * (G.GAME.willatro_jokers_bought or 0)
            }
        end
    end
}

--cobbler - done!
SMODS.Joker
{
    key = "cobbler",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = { x = 0, y = 2 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = false,
    config = {
        extra = {
            mult_gain = 5,
            mult = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_gain,
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            
            if card.ability.extra.mult > 25 then
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
                return {
                    message = localize('k_eaten_ex')
                }
            else
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_gain } },
                    colour = G.C.MULT
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

--clock - done!
SMODS.Joker
{
    key = "clock",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = { x = 1, y = 2 },
    cost = 7,
    blueprint_compat = true,
    config = {
        extra = {
            xmult_gain = 0.5,
            x_mult = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.x_mult + (card.ability.extra.xmult_gain * (G.GAME.round_resets.ante - 1))
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult + (card.ability.extra.xmult_gain * (G.GAME.round_resets.ante - 1))
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.GAME.blind.boss then
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.ATTENTION
                }
            end
        end
    end
}

--ghostly - done!
SMODS.Joker
{
    key = "ghostly",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = { x = 3, y = 2 },
    cost = 6,
    blueprint_compat = false,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable and context.consumeable.ability.set == 'Spectral' and not (context.consumeable.edition or {}).negative then
            local copied = copy_card(context.consumeable)
            copied:set_edition({negative = true}, true)
            copied:add_to_deck()
            G.consumeables:emplace(copied)
        end
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}

--jetfish - done!
SMODS.Joker
{
    key = "jetfish",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = { x = 3, y = 3 },
    cost = 6,
    blueprint_compat = true,
    perishable_compat = false,
    config = {
        extra = {
            mult_gain = 3,
            mult = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_gain,
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        local unscoring = false
        if context.before and context.main_eval and not context.blueprint then
            if #context.full_hand ~= #context.scoring_hand then
                unscoring = true
            end

            if unscoring then
                local last_mult = card.ability.extra.mult
                card.ability.extra.mult = 0
                if last_mult > 0 then
                    return {
                        message = localize('k_reset')
                    }
                end
            else
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

--empty - done!
SMODS.Joker
{
    key = "empty",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = { x = 4, y = 3 },
    cost = 6,
    blueprint_compat = false,
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    end,

    calculate = function(self, card, context)
        if G.hand and G.jokers then
            local stone = 0
            for i = 1, #G.jokers.cards do
                if context.selling_card and G.jokers.cards[i].config.center.key == 'j_willatro_empty' then
                    for k, v in ipairs(G.hand.highlighted) do
                        if SMODS.has_enhancement(v, "m_stone") then
                            stone = stone + 1
                        end
                    end
                end
            end
            SMODS.change_play_limit(-stone)
            SMODS.change_discard_limit(-stone)
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        if not G.GAME.before_play_buffer then
			G.hand:unhighlight_all()
		end
	end
}

--wise tree - done!
SMODS.Joker
{
    key = "wisetree",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = { x = 6, y = 3 },
    cost = 6,
    blueprint_compat = true,
    config = {
        extra = {
            repetitions = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_willatro_overgrown
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local overgrown = 0
            for k, v in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(v, "m_willatro_overgrown") then
                    overgrown = overgrown + 1
                end
            end
            if context.repetition and context.cardarea == G.play then
                return {
                    repetitions = card.ability.extra.repetitions * overgrown
                }
            end
        end
    end
}

--Job application - done!
SMODS.Joker {
    key = "application",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = { x = 5, y = 4 },
    cost = 5,
    blueprint_compat = false,
    eternal_compat = false,
    config = {
        extra = {
            dollars = 7,
            smallodds = 15,
            dollars_increase = 1,
            bigodds = 100,
            money = true
        }
    },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.smallodds)
        local numerator, denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.bigodds)
        return {
            vars = {
                card.ability.extra.dollars,
                numerator,
                denominator,
                card.ability.extra.dollars_increase,
                denominator2
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'willatro_application', 1, card.ability.extra.bigodds) then
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
                card.ability.extra.money = false
                return {
                    message = "Fired!",
                }
            elseif SMODS.pseudorandom_probability(card, 'willatro_application', 1, card.ability.extra.smallodds) then
                card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_increase
                return {
                    message = "Raise!"
                }
            end
        end
    end,

    calc_dollar_bonus = function(self, card)
        if card.ability.extra.money == true then
            return card.ability.extra.dollars
        end
    end
}

--Testosterone - done!
SMODS.Joker {
    key = "testosterone",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = { x = 6, y = 4 },
    cost = 7,
    blueprint_compat = true,
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
        if context.before and context.main_eval and not context.blueprint then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:get_id() == 11 or scored_card:get_id() == 12 then
                    faces = faces + 1
                    SMODS.change_base(scored_card, nil, "King")
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if faces > 0 then
                return {
                    message = "Transition!",
                    colour = HEX("7ed2bf")
                }
            end
        end

        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 13 then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end
}

--estrogen - done!
SMODS.Joker {
    key = "estrogen",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = { x = 0, y = 5 },
    cost = 7,
    blueprint_compat = true,
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
        if context.before and context.main_eval and not context.blueprint then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:get_id() == 11 or scored_card:get_id() == 13 then
                    faces = faces + 1
                    SMODS.change_base(scored_card, nil, "Queen")
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if faces > 0 then
                return {
                    message = "Transition!",
                    colour = HEX("e6c5b2")
                }
            end
        end

        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 12 then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end
}

--wildflowers - done!
SMODS.Joker {
    key = "wildflowers",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = { x = 5, y = 5 },
    cost = 7,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_willatro_overgrown
    end,

    calculate = function(self, card, context)
    if context.debuff_card and SMODS.has_enhancement(context.debuff_card, "m_willatro_overgrown") and context.debuff_card:is_suit("Spades") then
        return {debuff = true}
    end
end
}

--#endregion

--#region rare

--cooler joker - done!
SMODS.Joker
{
    key = "thecoolerjoker",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = {x = 0, y = 0},
    cost = 8,
    blueprint_compat = true,
    config = { 
        x_mult = 4
    },
    
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.x_mult
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.x_mult
            }
        end
    end

}

--joke in box - done!
SMODS.Joker
{
    key = "jokeinthebox",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = {x = 2, y = 0},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = false,
    config = { 
        extra = { 
            x_mult = 1, 
            Xmult_gain = 0.5
        } 
    },

    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.willatro_jokeinthebox or {}).suit or 'Spades'
        return
        {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.Xmult_gain,
                localize(suit, 'suits_singular'), 
                colours = { G.C.SUITS[suit] }
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local reset = false
            for k, v in ipairs(context.scoring_hand) do
                if v:is_suit(G.GAME.current_round.willatro_jokeinthebox.suit) then
                    reset = true
                    break
                end
            end
            if reset == true then
                card.ability.extra.x_mult = 1
            else
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.Xmult_gain
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
    end


}

--rift - done!
SMODS.Joker
{
    key = "rift",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = {x = 6, y = 0},
    cost = 8,
    blueprint_compat = true,
    config = { 
        extra = { 
            planets = 2 
        } 
    },

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.planets 
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            for i = 1, math.min(card.ability.extra.planets, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Planet' })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
        end
    end
}

--mitosis - done!
SMODS.Joker
{
    key = "mitosis",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = {x = 3, y = 1 },
    cost = 8,
    blueprint_compat = true,
    config = { 
        trigger = true
    },

    calculate = function(self, card, context)
        if context.before and context.main_eval then
            local new_cards = {}
            local message = false
            for i = 1, 2 do
                for k, v in ipairs(context.scoring_hand) do
                    if v.seal or v.edition or next(SMODS.get_enhancements(v)) then
                        message = true
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local copy_card = copy_card(v, nil, nil, G.playing_card)
                        copy_card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, copy_card)
                        G.hand:emplace(copy_card)
                        
                        copy_card.states.visible = nil
                        new_cards[#new_cards + 1] = copy_card
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                copy_card:start_materialize()
                                return true
                            end
                        }))
                    end
                end
            end
            SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
            if message == true then
                return {
                    message = localize('k_copied_ex'),
                    colour = G.C.CHIPS
                }
            end
        end
        if context.destroy_card and context.cardarea == G.play and 
        (context.destroy_card.seal or context.destroy_card.edition or next(SMODS.get_enhancements(context.destroy_card))) then
            return {
                remove = true
            }
        end
    end
}

--portal - done!
SMODS.Joker 
{
    key = "portal",
    rarity = 3,
    atlas = "WillatroJokers",
    cost = 8,
    pos = { x = 6, y = 1 },
    blueprint_compat = true,
    config = { 
        extra = {
            xmult = 2,
            xchips = 2,
            round = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        if card.ability.extra.round == 0 then
            return {
                vars = {
                    card.ability.extra.xmult,
                    card.ability.extra.xchips
                },
                key = "j_willatro_portal"
            }
        else
            return {
                vars = {
                    card.ability.extra.xmult,
                    card.ability.extra.xchips
                },
                key = self.key.."_alt"
            }
        end
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.round = card.ability.extra.round + 1
            if card.ability.extra.round > 1 then
                card.ability.extra.round = 0
            end
        end
        if card.ability.extra.round == 0 then
            card.children.center:set_sprite_pos({x = 6, y = 1})
            if context.joker_main then
                return {
                    x_mult = card.ability.extra.xmult
                }
            end
        end
        if card.ability.extra.round == 1 then
            card.children.center:set_sprite_pos({x = 2, y = 5})
            if context.joker_main then
                return {
                    x_chips = card.ability.extra.xchips
                }
            end
        end
    end
}

--broken mirror - done!
SMODS.Joker 
{
    key = "brokenmirror",
    rarity = 3,
    atlas = "WillatroJokers",
    cost = 8,
    pos = { x = 0, y = 3 },
    blueprint_compat = true,
    config = {
        extra = {
            repetitions = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_glass
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_glass') then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
        if context.scoring_hand and context.cardarea == G.play and not context.blueprint then
            if context.destroy_card and SMODS.has_enhancement(context.destroy_card, 'm_glass') then
                return {
                    remove = true
                }
            end
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--tagtree - done!
SMODS.Joker
{
    key = "tagtree",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = { x = 5, y = 3 },
    cost = 8,
    blueprint_compat = false,
    perishable_compat = false,
    config = {
        extra = {
            tagnumber = 1,
            tags = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        local tag_generated = "???"
        if card.ability.extra.tagnumber > 2 then
			tag_generated = localize({
				type = "name_text",
				set = "Tag",
				key = G.P_CENTER_POOLS["Tag"][card.ability.extra.tagnumber - 1].key,
			})
        end
		return { 
            vars = { 
                card.ability.extra.tags,
                tag_generated
            } 
        }
    end,

    calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
            local tags = {}
            for k, v in pairs(G.P_TAGS) do
                table.insert(tags, v.key)
            end
            table.sort(tags, function(a, b) return G.P_TAGS[a].order < G.P_TAGS[b].order end)

			for i = 1, card.ability.extra.tags do

                local tag = Tag(tags[card.ability.extra.tagnumber])
                if tag.name == "Orbital Tag" then
                    local _poker_hands = {}
                    for k, v in pairs(G.GAME.hands) do
                        if v.visible then
                            _poker_hands[#_poker_hands + 1] = k
                        end
                    end
                    tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "seed")
                end
                tag:set_ability()
            
                add_tag(tag)
                card.ability.extra.tagnumber = card.ability.extra.tagnumber + 1
                if card.ability.extra.tagnumber >= 25 then
                    card.ability.extra.tagnumber = 1
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
                    return {
                        message = "Finished!"
                    }
                end
			end
		end
	end
}

--goose - done!
SMODS.Joker
{
    key = "goose",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = { x = 0, y = 4 },
    cost = 9,
    blueprint_compat = false,
    config = {
        extra = {
            rounds = 4,
            current_rounds = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.rounds,
                card.ability.extra.current_rounds
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.current_rounds = card.ability.extra.current_rounds + 1
            if card.ability.extra.current_rounds >= card.ability.extra.rounds then
                if #G.jokers.cards <= G.jokers.config.card_limit then
                    local _card = SMODS.create_card({
                        set = "Joker",
                        key = "j_egg",
                        area = G.jokers,
                        edition = "e_negative"
                    })
                    _card:add_to_deck()
                    _card:set_perishable(true)
                    G.jokers:emplace(_card)
                    card.ability.extra.current_rounds = 0
                    return { 
                        message = "Egg!"
                    }
                end
            end
            return {
                message = (card.ability.extra.current_rounds < card.ability.extra.rounds) and
                    (card.ability.extra.current_rounds .. '/' .. card.ability.extra.rounds) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end
}

--pear - done!
SMODS.Joker
{
    key = "pear",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = { x = 2, y = 4 },
    cost = 8,
    blueprint_compat = true,
    config = {
        extra = {
            levels = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.levels
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and (context.scoring_name == "Pair" or context.scoring_name == "Two Pair") then
            SMODS.smart_level_up_hand(card, "Pair")
            SMODS.smart_level_up_hand(card, "Two Pair")
            return {
                message = localize('k_level_up_ex')
            }
        end
    end
}

--gamer rage - done!
SMODS.Joker {
    key = "rage",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = { x = 1, y = 5 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = false,
    config = {
        extra = {
            money = -40
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,

    calculate = function(self, card, context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                SMODS.add_card({ set = 'Joker', rarity = 'Legendary', edition = "e_negative" })
                card:juice_up(0.3, 0.5)
                if G.GAME.dollars ~= -40 then
                    ease_dollars(-(G.GAME.dollars + 40), true)
                end
                return true
            end
        }))
        end
    end,
}

--static - done!
SMODS.Joker {
    key = "static",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = { x = 3, y = 5 },
    soul_pos = { 
        x = 4, y = 5,
        draw = function(card, scale_mod, rotate_mod)
            card.hover_tilt = card.hover_tilt * 1.5
            card.children.floating_sprite:draw_shader('hologram', nil, card.ARGS.send_to_shader, nil,
                card.children.center, 2 * scale_mod, 2 * rotate_mod)
            card.hover_tilt = card.hover_tilt / 1.5
        end
    },
    cost = 8,
    blueprint_compat = true,
    config = {
        extra = {
            x_mult = 3.9,
            x_chips = 2.7,
            money = 25
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.x_chips,
                card.ability.extra.money
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                x_chips = card.ability.extra.x_chips
            }
        end
    end,

    remove_from_deck = function(self, card, context)
        ease_dollars(-card.ability.extra.money)
    end
}
--#endregion

--#region legendary

--theunseenexplosion - done!
SMODS.Joker
{
    key = "unseenexplosion",
    rarity = 4,
    atlas = "WillatroJokers",
    pos = {x = 4, y = 1 },
    soul_pos = { x = 5, y = 1 },
    cost = 20,
    blueprint_compat = true,
    perishable_compat = false,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = G.GAME.hands[context.scoring_name].played
            }
        end
    end
}

--bill cipher - done!
SMODS.Joker
{
    key = "bill",
    rarity = 4,
    atlas = "WillatroJokers",
    pos = { x = 4, y = 2 },
    soul_pos = { x = 5, y = 2 },
    cost = 20,
    blueprint_compat = true,
    config = {
        extra = {
            x_mult = 1.5,
            repetitions = 3
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.repetitions
            }
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play then
            if context.repetition and not context.other_card:is_face() then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
            if context.individual then
                if context.other_card:get_id() == 3 then
                    return {
                        x_mult = card.ability.extra.x_mult
                    }
                end
            end
        end
    end
}

--willow - done!
SMODS.Joker
{
    key = "willow",
    rarity = 4,
    atlas = "WillatroJokers",
    pos = {x = 3, y = 4 },
    soul_pos = { x = 4, y = 4 },
    cost = 20,
    blueprint_compat = true,
    config = {
        extra = {
            odds = 6,
            dollars = 5
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_willatro_overgrown
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.dollars
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local unenhanced = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if not next(SMODS.get_enhancements(scored_card)) then
                    unenhanced = unenhanced + 1
                    scored_card:set_ability('m_willatro_overgrown', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if unenhanced > 0 then
                return {
                    message = "Overgrown",
                    colour = HEX("4e8e53")
                }
            end
        end

        if context.individual and context.cardarea == G.play and
            SMODS.pseudorandom_probability(card, 'willatro_willow', 1, card.ability.extra.odds) then
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
    end
}
--#endregion