SMODS.Atlas
{
    key = "WillatroEvolved",
    path = "WillowEvolved.png",
    px = 71,
    py = 95
}

--#region common


SMODS.Joker {
    key = "box",
    rarity = 1,
    atlas = "WillatroEvolved",
    pos = {x = 0, y = 0},
    cost = 4,
    blueprint_compat = true,
    config = {
        extra = {
            repetitions = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        return{
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,
}
--#endregion


--#region uncommon

--#endregion


--#region rare

--#endregion