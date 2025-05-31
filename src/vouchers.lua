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
    end,

    redeem = function(self, card)
    end

}

local oldpolledition = poll_edition
function poll_edition(_key, _mod, _no_neg, _guaranteed, _options)
    if _key == 'wheel_of_fortune' and G.GAME.used_vouchers['v_willatro_addict'] == true then
        _no_neg = false
    end
    _mod = _mod or 1
    local edition_poll = pseudorandom(pseudoseed(_key or 'edition_generic'))
    if _guaranteed then
        if edition_poll > 1 - 0.003*25 and not _no_neg then
            return {negative = true}
        elseif edition_poll > 1 - 0.006*25 then
            return {polychrome = true}
        elseif edition_poll > 1 - 0.02*25 then
            return {holo = true}
        elseif edition_poll > 1 - 0.04*25 then
            return {foil = true}
        end
    else
        if edition_poll > 1 - 0.003*_mod and not _no_neg then
            return {negative = true}
        elseif edition_poll > 1 - 0.006*G.GAME.edition_rate*_mod then
            return {polychrome = true}
        elseif edition_poll > 1 - 0.02*G.GAME.edition_rate*_mod then
            return {holo = true}
        elseif edition_poll > 1 - 0.04*G.GAME.edition_rate*_mod then
            return {foil = true}
        end
    end
    return nil
end