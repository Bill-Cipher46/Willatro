SMODS.Atlas
{
    key = "WillatroEvolved",
    path = "WillowEvolved.png",
    px = 71,
    py = 95
}

SMODS.ObjectType {
    key = "Upgradeable",
    default = "j_willatro_thecoolerjoker",
    cards = {
        ["j_hanging_chad"] = true,
        ["j_joker"] = true
    }
}

G.willatro_upgrades = {
    ["j_hanging_chad"] = {
        key = "j_willatro_box",
        upgradeable = true
    },
    ["j_joker"] = {
        key = "j_willatro_thecoolerjoker",
        upgradeable = true
    },
}

--#region common

--ballot box - done!
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

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--#endregion


--#region uncommon

--#endregion


--#region rare

--#endregion

SMODS.Booster
{
    key = "boostable_pack",
    loc_txt = {
        name = "Boostable Booster Pack",
        group_name = "Boostable Booster Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{} Jokers that can be boosted"
        }
            
    },
    atlas = "WillatroEvolved",
    pos = { x = 5, y = 1 },
    kind = "Boostable",
    draw_hand = false,
    config = {
        extra = 2,
        choose = 1
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra
            }
        }
    end,

    create_card = function(self, card, i)
        return { set = "Upgradeable" }
    end,

    in_pool = function(self, args)
        return false
    end
}