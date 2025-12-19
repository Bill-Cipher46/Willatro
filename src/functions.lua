SMODS.current_mod.optional_features = function() 
    return {
        retrigger_joker = true,
        quantum_enhancements = true,
        post_trigger = true
    }
end

if not willatro then
    willatro = {}
end

willatro.pseudorandom = {
    set_predict_mode = function(bool)
        G.GAME.pseudorandom.predict_mode = bool or false
        G.GAME.pseudorandom.predicts = {}
        return G.GAME.pseudorandom.predict_mode
    end
}

to_big = to_big or function(x)
    return x
end

to_number = to_number or function(x)
    return x
end

function Prime(n)
    for i = 2, n^(1/2) do
        if (n % i) == 0 then
            return false
        end
    end
    return true
end

local SMODS_calculate_context_ref = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
    if context.buying_card and context.card.ability.set == "Joker" then
        G.GAME.willatro_jokers_bought = (G.GAME.willatro_jokers_bought or 0) + 1
    end
    return SMODS_calculate_context_ref(context, return_table)
end

local function reset_willatro_jokeinthebox()
    G.GAME.current_round.willatro_jokeinthebox = G.GAME.current_round.willatro_jokeinthebox or { suit = 'Spades' }
    local joke_suits = {}
    for k, v in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }) do
        if v ~= G.GAME.current_round.willatro_jokeinthebox.suit then joke_suits[#joke_suits + 1] = v end
    end
    local jokeinthebox_card = pseudorandom_element(joke_suits, pseudoseed('willatro_jokeinthebox' .. G.GAME.round_resets.ante))
    G.GAME.current_round.willatro_jokeinthebox.suit = jokeinthebox_card
end

local oldsetcost = Card.set_cost
function Card:set_cost()
    if self.config.center.key == 'j_willatro_troll' or self.ability.willatro_saved == true then
        self.cost = 0
        self.sell_cost = 0
        self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
    else
        return oldsetcost(self)
    end
end

local oldhighlight = Card.highlight
function Card:highlight(highlighted)
    local g = oldhighlight(self, highlighted)
    if SMODS.has_enhancement(self, "m_stone") then
        if not highlighted and self.config.negative_enabled and next(SMODS.find_card("j_willatro_empty")) then
            self.config.negative_enabled = false
            SMODS.change_play_limit(-1)
            SMODS.change_discard_limit(-1)
        end
    end
    return g
end

local oldaddhighlighted = CardArea.add_to_highlighted
function CardArea:add_to_highlighted(card, silent)
    if SMODS.has_enhancement(card, "m_stone") and not card.config.negative_enabled and next(SMODS.find_card("j_willatro_empty"))  then
        card.config.negative_enabled = true
        SMODS.change_play_limit(1)
        SMODS.change_discard_limit(1)
    end
    return oldaddhighlighted(self, card, silent)
end

local oldcardissuit = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    local g = oldcardissuit(self, suit, bypass_debuff, flush_calc)
    if not SMODS.has_no_suit(self) and next(SMODS.find_card("j_willatro_messy_joker")) then
        return true
    end

    if not SMODS.has_no_suit(self) and next(SMODS.find_card("j_willatro_wildflowers")) and SMODS.has_enhancement(self, "m_willatro_overgrown") and
    (self.base.suit == 'Hearts' or self.base.suit == 'Diamonds' or self.base.suit == 'Clubs') == (suit == 'Hearts' or suit == 'Diamonds' or suit == 'Clubs') then
        return true
    end

    return g
end

local oldflipcard = Card.flip
function Card:flip()
    local immune = { }

    if G.jokers then
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.key == "j_willatro_skin" then
                immune[#immune+1] = G.jokers.cards[i]
                if i > 1 then
                    immune[#immune+1] = G.jokers.cards[i-1]
                end
                if i < #G.jokers.cards then
                    immune[#immune+1] = G.jokers.cards[i+1]
                end
            end
        end
    end

    for i = 1, #immune do
        if self == immune[i] then
            return nil
        end
    end

    return oldflipcard(self)
end

local oldgetboss = get_new_boss
function get_new_boss()
    if next(SMODS.find_card("j_willatro_consciousness")) then
        if G.GAME.round_resets.ante % 8 == 0 then
            return "bl_willatro_virulent_void"
        else
            return "bl_willatro_hollow"
        end
    else
        return oldgetboss()
    end
end


function predict_next_bosses(num_predictions)
    local predictions = {}

    willatro.psueodrandom.set_predict_mode = true

    local sim_ante = G.GAME.round_resets.ante
    local sim_bosses_used = {}

    for k, v in pairs(G.GAME.bosses_used) do
        sim_bosses_used[k] = v
    end

    for i = 1, num_predictions do
        sim_ante = sim_ante + 1

        if G.GAME.perscribed_bosses and G.GAME.perscribed_bosses[sim_ante] then
            local boss = G.GAME.perscribed_bosses[sim_ante]
            table.insert(predictions, {ante = sim_ante, boss = boss})
            sim_bosses_used[boss] = (sim_bosses_used[boss] or 0) + 1
        else
            
            local eligible_bosses = {}
            for k, v in pairs(G.P_BLINDS) do
                if not v.boss then
                elseif not v.boss.showdown and (v.boss.min <= math.max(1, sim_ante) and ((math.max(1, sim_ante))%G.GAME.win_ante ~= 0 or sim_ante < 2)) then

                    if not v.in_pool or v:in_pool() then
                        eligible_bosses[k] = true
                    end
                elseif v.boss.showdown and (sim_ante)%G.GAME.win_ante == 0 and sim_ante >= 2 then

                    if not v.in_pool or v:in_pool() then
                        eligible_bosses[k] = true
                    end
                end
            end

            for k, v in pairs(G.GAME.banned_keys) do
                if eligible_bosses[k] then eligible_bosses[k] = nil end
            end

            local min_use = 100
            for k, v in pairs(sim_bosses_used) do
                if eligible_bosses[k] then
                    eligible_bosses[k] = v
                    if eligible_bosses[k] <= min_use then 
                        min_use = eligible_bosses[k]
                    end
                end
            end

            for k, v in pairs(eligible_bosses) do
                if eligible_bosses[k] and eligible_bosses[k] > min_use then 
                    eligible_bosses[k] = nil
                end
            end

            local _, boss = pseudorandom_element(eligible_bosses, pseudoseed('boss'))

            table.insert(predictions, {ante = sim_ante, boss = boss})
            sim_bosses_used[boss] = (sim_bosses_used[boss] or 0) + 1
        end
    end

    willatro.psueodrandom.set_predict_mode = false

    return predictionsd
end

local ref_pseudoseed = pseudoseed
function pseudoseed(key, predict_seed, ...)

    if not G.GAME.pseudorandom.predict_mode then
        return ref_pseudoseed(key, predict_seed, ...)
    end

    if key == 'seed' then return math.random() end
    if G.SETTINGS.paused and key ~= 'to_do' then return math.random() end

    local _pseed = 0
    if not G.GAME.pseudorandom.predicts[key] then
        _pseed = pseudohash(key..(predict_seed or G.GAME.pseudorandom.seed or ''))
        G.GAME.pseudorandom.predicts[key] = {
            value = G.GAME.pseudorandom[key] or _pseed,
            pos = 0
        }
    end

    _pseed = math.abs(tonumber(string.format("%.13f", (2.134453429141+G.GAME.pseudorandom.predicts[key].value*1.72431234)%1)))
    G.GAME.pseudorandom.predicts[key].value = _pseed
    G.GAME.pseudorandom.predicts[key].pos = G.GAME.pseudorandom.predicts[key].pos + 1

    return (_pseed + (G.GAME.pseudorandom.hashed_seed or 0))/2
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_willatro_jokeinthebox()
end