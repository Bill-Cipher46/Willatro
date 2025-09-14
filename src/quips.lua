willatro.quip_weight = 15
local quips = {
    win = {
        ["j_willatro_willow"] = {
            { "That really was Balatro..." },
            { "Are we gonna do a", "music video now?", "Oh wait, that's PvZ.", "Nevermind"}
        },
        ["j_willatro_bill"] = {
            { "Remember: Reality is an", "illusion, the universe", "is a hologram, buy", "gold, bye!" },
            { "Well, well, well, and here", "I thought today couldn't", "get any better"}
        }

    },
    lose = {
        ["j_willatro_willow"] = {
            { "It's Balatrover..." },
            { "Skill issue" }
        },
        ["j_willatro_bill"] = {
            { "ahahahaha. It's funny", "how dumb you are." },
            { "We'll meet again,", "Don't know where, don't", "know when, oh I know", "we'll meet again", "some sunny day"}
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
