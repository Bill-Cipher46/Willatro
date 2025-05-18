return {
    descriptions = {
        Blind = {
            bl_willatro_sand = {
                name = "The Sand",
                text = {
                    "After discard, flip all",
                    "cards held in hand"
                }
            },

            bl_willatro_ring = {
                name = "The Ring",
                text = {
                    "No hands made up of",
                    "Only one rank or suit"
                }
            },

            bl_willatro_arrow = {
                name = "The Arrow",
                text = {
                    "#1# in #2# chance to",
                    "destroy scored cards"
                }
            }
        },

        Joker = {
            j_willatro_thecoolerjoker = {
                name = "The Cooler Joker",
                text = 
                {
                    "{C:white,X:mult}X#1#{} Mult"
                }
            },

            j_willatro_loss = {
                name = "Loss.jpg",
                text = 
                {
                    "If played and scoring hand",
                    "contains {C:attention}one Queen{} and {C:attention}one 2{},",
                    "Destroy the {C:attention}2{} and create",
                    "an {C:attention,T:#info_queue}Ethereal Tag"
                }
            },

            j_willatro_jokeinthebox = {
                name = "Joke In the Box",
                text = 
                {
                    "Gains {C:white,X:mult}X#2#{} Mult for each",
                    "played hand, resets if played",
                    "hand contains card of {V:1}#3#{} suit",
                    "{s:0.8,C:inactive}(Currently {s:0.8,C:white,X:mult}X#1#{} {s:0.8,C:inactive}Mult)",
                    "{s:0.8,C;inactive}suit changes at end of round"
                }
            }
        },

        Tarot = {
            c_willatro_tree = {
                name = "The Tree",
                text = {
                    "Enhances {C:attention}3{}",
                    "selected cards to",
                    "{C:attention,T:#info_queue}Overgrown Cards"
                }
            }
        },

        Enhanced = {
            m_willatro_overgrown = {
                name = "Overgrown",
                text = { 
                    "{C:mult}+#1#{} Mult for every other",
                    "{C:attention}Overgrown Card{} played",
                    "Or held in hand"
                }
            }
        }
    }
}