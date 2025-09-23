SMODS.Atlas
{
    key = "WillatroVouchers",
    path = "WillowVouchers.png",
    px = 71,
    py = 95
}

--gambling addict - done!
SMODS.Voucher
{
    key = "addict",
    pos = { x = 0, y = 0 },
    atlas = "WillatroVouchers",
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
    end

}

--casino regular - done!
SMODS.Voucher
{
    key = "regular",
    pos = { x = 1, y = 0 },
    atlas = "WillatroVouchers",
    requires = { 'v_willatro_addict' },
    config = {
        extra = {
            wheels = 2
        }
    },
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
        return {
            vars = {
                card.ability.extra.wheels
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss then
            for i = 1, card.ability.extra.wheels do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = 'Tarot',
                            key = 'c_wheel_of_fortune',
                            edition = 'e_negative'
                        }
                        return true
                    end
                }))
            end
        end
    end

}

local oldpolledition = poll_edition
function poll_edition(_key, _mod, _no_neg, _guaranteed, _options)
    local g = oldpolledition(_key, _mod, _no_neg, _guaranteed, _options)

    local no_neg = _no_neg

    if _key == 'wheel_of_fortune' and G.GAME.used_vouchers['v_willatro_addict'] == true then
        no_neg = false
    end
    return oldpolledition(_key, _mod, no_neg, _guaranteed, _options)
end