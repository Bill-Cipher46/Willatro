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
            },

            j_willatro_familiarweapon = {
                name = "Familiar Weapon",
                text = {
                    "Destroy all played and scoring",
                    "cards with a rank of {C:attention}8{} or lower.",
                    "Gain {C:chips}+#1#{} Chips for each",
                    "destroyed card",
                    "{C:inactive,s:0.8}(Currently {C:chips,s:0.8}+#2#{C:inactive,s:0.8} chips)"
                }
            },

            j_willatro_barcode = {
                name = "Barcode",
                text = {
                    "Earn {C:money}$#1#{} at the end of the",
                    "round for each owned joker",
                    "{s:0.8,C:inactive}(Currently {C:money,s:0.8}$#2#{s:0.8,C:inactive})"
                }
            },

            j_willatro_jokerobot = {
                name = "Jokerobot",
                text = {
                    "All played {C:attention}face{} cards",
                    "become {C:attention,T:info_queue}Steel{} cards",
                    "when scored"
                }
            },

            j_willatro_rift = {
                name = "Rift",
                text = {
                    "Level up all {C:attention}poker hands{} not",
                    "played this ante by {C:attention}1{} at",
                    "the end of the ante"
                }
            },

            j_willatro_bodyguard = {
                name = "Bodyguard",
                text = {
                    "Gives {C:attention}Joker{} to the",
                    "right {C:attention}Eternal{} sticker",
                    "{C:inactive,s:0.8}(Bodyguard cannot be eternal)"
                }
            },

            j_willatro_jokergummy = {
                name = "Joker Gummy",
                text = {
                    "Gains {C:mult}+#1#{} Mult for each",
                    "{C:attention}Joker{} bought this run",
                    "{C:inactive,s:0.8}(Currently {s:0.8,C:mult}+#2#{C:inactive,s:0.8} Mult)"
                }
            },

            j_willatro_cyan = {
                name = "Cyan",
                text = {
                    "{C:chips}+#1#{} Chips, {C:mult}+#2#{} Mult",
                    "{C:green}#5# in #6#{} chance for",
                    "{C:chips}+#3#{} Chips {C:white,X:mult}X#4#{} Mult"
                }
            },

            j_willatro_mitosis = {
                name = "Mitosis",
                text = {
                    "If played and scoring card has a",
                    "{C:attention}modifier{}, destroy it, add two permanent",
                    "copies to deck and draw them to {C:attention}hand"
                }
            },

            j_willatro_unseenexplosion = {
                name = "The Unseen Explosion",
                text = {
                    "Adds number of times",
                    "{C:attention}Poker Hand{} has been played",
                    "this run to {C:white,X:mult}xMult"
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
                    "or held in hand"
                }
            }
        }
    }
}