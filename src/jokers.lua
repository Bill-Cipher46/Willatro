SMODS.Atlas
{
    key = "WillatroJokers",
    path = "WillowJokers.png",
    px = 71,
    py = 95
}

SMODS.current_mod.optional_features = { quantum_enhancements = true }

--#region common
--loss - done!
SMODS.Joker
{
    key = "loss",
    rarity = 1,
    atlas = "WillatroJokers",
    pos = {x = 1, y = 0},
    cost = 4,

    config = { extra = { created_tag = false } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_ethereal
        return { vars = { localize { type = "name_text", set = "Tag", key = "tag_ethereal" }, card.ability.extra.created_tag } }
    end,

   calculate = function(self, card, context)
    if context.joker_main then
        local queens = 0
        local twos = 0
        local tag = false
        for i = 1, #context.scoring_hand do
            if context.scoring_hand[i]:get_id() == 2 then twos = twos + 1 end
            if context.scoring_hand[i]:get_id() == 12 then queens = queens + 1 end
        end
        if twos > 0 and twos < 2 and queens > 0 and queens < 2 then
            tag = true
        end
        if tag then
            card.ability.extra.created_tag = true
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
                end
            }
        end
    end

    if context.destroy_card and context.cardarea == G.play and not context.blueprint and card.ability.extra.created_tag == true then
        if context.destroy_card:get_id() == 2 then
            return
            {
                remove = true
            }
        end
    end

    if context.after then
      card.ability.extra.created_tag = false
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
    config = { extra = { money_gain = 2, money = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money_gain, card.ability.extra.money } }
    end,
    
    calculate = function(self, card, context)
        card.ability.extra.money = #G.jokers.cards * card.ability.extra.money_gain
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.money
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

    config = { extra = { chips = 1, mult = 1, mega_chips = 500, mega_mult = 7, odds = 70 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.mega_chips, card.ability.extra.mega_mult,
                (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local chance_hit = false
            if pseudorandom('cyan') < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
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
    config = {
        extra = {
            odds = 15
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_glass
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        return {
            vars = {
                (G.GAME and G.GAME.probabilities.normal or 1), 
                card.ability.extra.odds,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.check_enhancement then
            if context.other_card.config.center.key == "m_glass" then
                return {m_steel = true}
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if pseudorandom("silvermirror") < (G.GAME and G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
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
    config = {
        extra = {
            dollars = 3,
            odds = 6,
            money = true
        }
    },

    loc_vars  = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                (G.GAME and G.GAME.probabilities.normal or 1),
                card.ability.extra.odds
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if pseudorandom('lime') < G.GAME.probabilities.normal / card.ability.extra.odds then
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
    config = {
        extra = {
            odds = 2,
            dollars = 2,
            bigodds = 1000
        }
    },

    loc_vars  = function(self, info_queue, card)
        return {
            vars = {
                (G.GAME and G.GAME.probabilities.normal or 1),
                card.ability.extra.odds,
                card.ability.extra.dollars,
                card.ability.extra.bigodds
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            pseudorandom('lemon') < G.GAME.probabilities.normal / card.ability.extra.odds then
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
            if pseudorandom('lemon') < G.GAME.probabilities.normal / card.ability.extra.bigodds then
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
    config = { extra = { chip_gain = 20, chips = 0, message = false, play = false} },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chip_gain, card.ability.extra.chips, card.ability.extra.addchips } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local toDestroy = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() < 9 then
                    toDestroy  = toDestroy + 1
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
                        card:juice_up(0.8, 0.8)
                        if card.ability.extra.play == true then
                            play_sound('slice1', 0.96 + math.random() * 0.08)
                            card.ability.play = false
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
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_face() then
                    faces = faces + 1
                    scored_card:set_ability('m_steel', nil, true)
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

    calculate = function(self, card, context)
        if G.jokers then
            for i = 2, #G.jokers.cards do
                if context.selling_card and G.jokers.cards[i-1].config.center.key == 'j_willatro_bodyguard' then
                    G.jokers.cards[i]:set_eternal(true)
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
    config = { extra = { mult_gain = 5, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.buying_card and context.card.ability.set == "Joker" and not context.blueprint then
            card.ability.extra.mult = G.GAME.willatro_jokers_bought * card.ability.extra.mult_gain
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
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
                card.ability.extra.x_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if not context.blueprint then
            card.ability.extra.x_mult = 0.5 + card.ability.extra.xmult_gain * G.GAME.round_resets.ante
        end
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
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

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable and context.consumeable.ability.set == 'Spectral' and not (context.consumeable.edition or {}).negative then
            local copied = copy_card(context.consumeable)
            copied:set_edition({negative = true}, true)
            copied:add_to_deck()
            G.consumeables:emplace(copied)
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

--empty
SMODS.Joker
{
    key = "empty",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = { x = 4, y = 3 },
    cost = 6,
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    end
}

--wise tree
SMODS.Joker
{
    key = "wisetree",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = { x = 6, y = 3 },
    cost = 6,
    config = {
        extra = {
            retriggers = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_willatro_overgrown
        return {
            vars = {
                card.ability.extra.retriggers
            }
        }
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

    config = { x_mult = 4},
    
    loc_vars = function(self, info_queue, card)
        return 
        { 
            vars = 
            { card.ability.x_mult} 
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.Jokers and context.individual then
            return
            {
                xmult = card.ability.x_mult
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

    config = { extra = { x_mult = 1, Xmult_gain = 0.5} },

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

    config = { extra = { planets = 2 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.planets } }
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

    config = { trigger = true},

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
        if context.joker_main and card.ability.extra.round == 0 then
            return {
                x_mult = card.ability.extra.xmult
            }
        end
        if context.joker_main and card.ability.extra.round == 1 then
            return {
                x_chips = card.ability.extra.xchips
            }
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
        if context.scoring_hand then
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

--tagtree
SMODS.Joker
{
    key = "tagtree",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = { x = 5, y = 3 },
    cost = 8,
}

--goose
SMODS.Joker
{
    key = "goose",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = { x = 0, y = 4 },
    cost = 9,
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
--#endregion

local SMODS_calculate_context_ref = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
    if context.buying_card and context.card.ability.set == "Joker" then
        G.GAME.willatro_jokers_bought = (G.GAME.willatro_jokers_bought or 0) + 1
    end
    return SMODS_calculate_context_ref(context, return_table)
end

local SMODS_calculate_context_ref = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
    if context.before and context.main_eval then
        G.GAME.willatro_played_hands[#G.GAME.willatro_played_hands + 1] = G.GAME.hands[context.scoring_name].played
    end
    return SMODS_calculate_context_ref(context, return_table)
end

local function reset_Willatro_jokeinthebox()
    G.GAME.current_round.willatro_jokeinthebox = G.GAME.current_round.willatro_jokeinthebox or { suit = 'Spades' }
    local joke_suits = {}
    for k, v in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }) do
        if v ~= G.GAME.current_round.willatro_jokeinthebox.suit then joke_suits[#joke_suits + 1] = v end
    end
    local jokeinthebox_card = pseudorandom_element(joke_suits, pseudoseed('willatro_jokeinthebox' .. G.GAME.round_resets.ante))
    G.GAME.current_round.willatro_jokeinthebox.suit = jokeinthebox_card
end

function Card:set_cost()
    self.extra_cost = 0 + G.GAME.inflation
    if self.edition then
        self.extra_cost = self.extra_cost + (self.edition.holo and 3 or 0) + (self.edition.foil and 2 or 0) + 
        (self.edition.polychrome and 5 or 0) + (self.edition.negative and 5 or 0)
    end
    self.cost = math.max(1, math.floor((self.base_cost + self.extra_cost + 0.5)*(100-G.GAME.discount_percent)/100))
    if self.ability.set == 'Booster' and G.GAME.modifiers.booster_ante_scaling then self.cost = self.cost + G.GAME.round_resets.ante - 1 end
    if self.ability.set == 'Booster' and (not G.SETTINGS.tutorial_complete) and G.SETTINGS.tutorial_progress and (not G.SETTINGS.tutorial_progress.completed_parts['shop_1']) then
        self.cost = self.cost + 3
    end
    if (self.ability.set == 'Planet' or (self.ability.set == 'Booster' and self.ability.name:find('Celestial'))) and #find_joker('Astronomer') > 0 then self.cost = 0 end
    if self.ability.rental then self.cost = 1 end
    self.sell_cost = math.max(1, math.floor(self.cost/2)) + (self.ability.extra_value or 0)
    if self.area and self.ability.couponed and (self.area == G.shop_jokers or self.area == G.shop_booster) then self.cost = 0 end
    self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
    if self.config.center.key == 'j_willatro_troll' then
        self.cost = 0
    end
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_Willatro_jokeinthebox()
end