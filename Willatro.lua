SMODS.Atlas
{
    key = "WillatroJokers",
    path = "WillowJokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas
{
    key = "WillatroBlinds",
    path = "WillowBlinds.png",
    px = 34,
    py = 34,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21
}

--cooler joker - done!
SMODS.Joker
{
    key = "thecoolerjoker",
    rarity = 3,
    discovered = true,
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

--loss - done!
SMODS.Joker
{
    key = "loss",
    rarity = 1,
    discovered = false,
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

--joke in box - done!
SMODS.Joker
{
    key = "jokeinthebox",
    rarity = 3,
    discovered = false,
    atlas = "WillatroJokers",
    pos = {x = 2, y = 0},
    cost = 8,

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

--sand
SMODS.Blind
{
    key = "sand",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 0},
    boss = {
        min = 1,
        max = 0
    },
    boss_colour = HEX('d09552'),
    config = { extra = { neg_chips = -10 } },
    loc_vars = function(self)
        return {
            vars = { self.config.extra.neg_chips }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = { self.config.extra.neg_chips }
        }
    end

}

--ring
SMODS.Blind
{
    key = "ring",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 1},
    boss = {
        min = 5,
        max = 0
    },
    boss_colour = HEX('9329b7'),

    debuff_hand = function(self, cards, hand, handname, check)
        if handname == 'Pair' or 'High Hard' or 'Three of a Kind' or 'Four of a Kind' or 'Five of a Kind' or
        'Flush' or 'Flush Five' or 'Straight Flush' or 'Flush House' or 'Royal Flush' then
            return true
        end
    end
}

--arrow
SMODS.Blind
{
    key = "arrow",
    atlas = "WillatroBlinds",
    pos = { x = 0, y = 2},
    boss = {
        min = 1,
        max = 0
    },
    boss_colour = HEX('279378'),
    config = { extra = { odds = 6 } },
    loc_vars = function(self)
        return {
            vars = { G.GAME.probabilities.normal, self.config.extra.odds }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = { G.GAME.probabilities.normal, self.config.extra.odds }
        }
    end,
    calculate = function(self, card, context)
        if pseudorandom('arrow') < G.GAME.probabilities.normal / self.config.extra.odds then
            if context.destroy_card and context.cardarea == G.play then
                return
                { 
                    remove = true
                }
            end
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

function SMODS.current_mod.reset_game_globals(run_start)
    reset_Willatro_jokeinthebox()
end