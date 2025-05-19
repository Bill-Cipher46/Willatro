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

--barcode
SMODS.Joker
{
    key = "barcode",
    rarity = 1,
    atlas = "WillatroJokers",
    pos = {x = 4, y = 0},
    cost = 4,
    config = { extra = { money_gain = 2, dollars = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money_gain, card.ability.extra.dollars } }
    end
}

--cyan
SMODS.Joker
{
    key = "cyan",
    rarity = 1,
    atlas = "WillatroJokers",
    pos = {x = 2, y = 1 },
    cost = 4,

    config = { extra = { chips = 1, mult = 1, chips2 = 500, x_mult2 = 7, odds = 70 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.chips2, card.ability.extra.x_mult2,
                (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
}
--#endregion

--#region uncommon
--familiar weapon
SMODS.Joker 
{
    key = "familiarweapon",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = {x = 3, y = 0},
    cost = 6,
    config = { extra = { chips = 20} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end
}

--jokerobot
SMODS.Joker 
{
    key = "jokerobot",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = {x = 5, y = 0},
    cost = 7,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
    end
}

--jokergummy
SMODS.Joker 
{
    key = "jokergummy",
    rarity = 2,
    atlas = "WillatroJokers",
    pos = {x = 1, y = 1 },
    cost = 7,
    config = { extra = { mult_gain = 3, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
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

local function reset_Willatro_jokeinthebox()
    G.GAME.current_round.willatro_jokeinthebox = G.GAME.current_round.willatro_jokeinthebox or { suit = 'Spades' }
    local joke_suits = {}
    for k, v in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }) do
        if v ~= G.GAME.current_round.willatro_jokeinthebox.suit then joke_suits[#joke_suits + 1] = v end
    end
    local jokeinthebox_card = pseudorandom_element(joke_suits, pseudoseed('willatro_jokeinthebox' .. G.GAME.round_resets.ante))
    G.GAME.current_round.willatro_jokeinthebox.suit = jokeinthebox_card
end

--rift
SMODS.Joker
{
    key = "rift",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = {x = 6, y = 0},
    cost = 8,
    config = { extra = { level = 1 } },
    loc_cars = function(self, info_queue, card)
        return { vars = { card.ability.extra.level } }
    end
}

--bodyguard
SMODS.Joker
{
    key = "bodyguard",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = {x = 0, y = 1},
    cost = 8,
    eternal_compat = false,
}

--mitosis
SMODS.Joker
{
    key = "mitosis",
    rarity = 3,
    atlas = "WillatroJokers",
    pos = {x = 3, y = 1 },
    cost = 8,
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
--#endregion

function SMODS.current_mod.reset_game_globals(run_start)
    reset_Willatro_jokeinthebox()
end