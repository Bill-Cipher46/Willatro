willatro.quip_weight = 15
local quips = {
    lose = {
        ["j_willatro_willow"] = {
            { "That really was Balatro..." },
            { "Are we gonna do a", "music video now?", "Oh wait, that's PvZ.", "Nevermind"}
        }
    },
    win = {
        ["j_willatro_willow"] = {
            { "It's Balatrover..." },
            { "Skill issue" }

        }

    }

}

local iter = 0
for name, character in pairs(quips.lose) do
    
    for i, txt in ipairs(character) do
        iter = iter + 1
        SMODS.JimboQuip {
            type = "loss",
            key = "lq_" .. name .. iter,
            extra = { center = name },
            loc_txt = txt,
            weight = willatro.quip_weight,
            filter = function(self, quip_type)
                return true, { weight = willatro.quip_weight }
            end
        }
    end
end

for name, character in pairs(quips.win) do
    for i, txt in ipairs(character) do
        iter = iter + 1
        SMODS.JimboQuip {
            type = "win",
            key = "wq_" .. name .. iter,
            extra = { center = name },
            loc_txt = txt,
            weight = willatro.quip_weight,
            filter = function(self, quip_type)
                return true, { weight = willatro.quip_weight }
            end
        }
    end
end
