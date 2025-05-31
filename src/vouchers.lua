SMODS.Atlas
{
    key = "WillatroVouchers",
    path = "WillowVouchers.png",
    px = 71,
    py = 95
}

SMODS.Voucher
{
    key = "addict",
    pos = { x = 0, y = 0 },
    atlas = "WillatroVouchers",
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    end

}