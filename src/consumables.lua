SMODS.Atlas {
    key = "WillatroConsumables",
    path = "WillowTarots.png",
    px = 71,
    py = 95
}

--tree
SMODS.Consumable {
    key = "tree",
    set = 'Tarot',
    atlas = 'WillatroConsumables',
    pos = { x = 0, y = 0 },
    cost = 3,
    
    config = { extra = { max_highlighted = 2, enh_key = 'm_willatro_overgrown' } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.enh_key]
        return { vars = { card.ability.extra.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.extra.enh_key } } }
    end

}