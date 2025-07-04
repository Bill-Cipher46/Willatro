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
            --#region common
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

            j_willatro_barcode = {
                name = "Barcode",
                text = {
                    "Earn {C:money}$#1#{} at the end of the",
                    "round for each owned joker",
                    "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
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

            j_willatro_troll = {
                name = "Trollface",
                text = {
                    "Every played and scoring",
                    "{C:attention}face card gives {C:mult}+10{} Mult"
                    --opposite, always free
                }
            },

            j_willatro_silvermirror = {
                name = "Silver Mirror",
                text = {
                    "{C:attention,T:info_queue[1]}Glass{} cards are also",
                    "{C:attention,T:info_queue[2]}Steel{} cards. {C:green}#1# in #2#",
                    "Chance for this card to",
                    "shatter at end of round"
                }
            },

            j_willatro_lime = {
                name = "Lime",
                text = {
                    "Earn {C:money}$#1#{} at end of round.",
                    "{C:green}#2# in #3#{} chance this",
                    "card is destroyed",
                    "at end of round"
                }
            },

            j_willatro_lemon = {
                name = "Lemon",
                text = {
                    "{C:green}#1# in #2#{} chance for all",
                    "played and scoring cards",
                    "to give {C:money}$#3#",
                    "{C:green}#1# in #4#{} chance this card is",
                    "destroyed at end of round"
                }
            },

            j_willatro_cadaver = {
                name = "Cadaver",
                text = {
                    "When sold, create a",
                    "random {V:1}Organ {C:attention}Joker"
                }
            },
            --#endregion

            --#region uncommon
            j_willatro_familiarweapon = {
                name = "Familiar Weapon",
                text = {
                    "Destroy all played and scoring",
                    "cards with a rank of {C:attention}8{} or lower.",
                    "Gain {C:chips}+#1#{} Chips for each",
                    "destroyed card",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} chips)"
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

            j_willatro_bodyguard = {
                name = "Bodyguard",
                text = {
                    "Gives {C:attention}Joker{} to the",
                    "right {C:attention}Eternal{} sticker",
                    "when this card is {C:attention}sold",
                    "{s:0.8}bodyguard can not be eternal"
                }
            },

            j_willatro_jokergummy = {
                name = "Joker Gummy",
                text = {
                    "Gains {C:mult}+#1#{} Mult for each",
                    "{C:attention}Joker{} bought this run",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
            },

            j_willatro_cobbler = {
                name = "Cobbler",
                text = {
                    "Gains {C:mult}+#1#{} Mult every round.",
                    "This card is {C:attention}destroyed",
                    "after reaching {C:mult}+30{} Mult",
                    "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)"
                }
            },

            j_willatro_clock = {
                name = "Clock",
                text = {
                    "Additional {C:white,X:mult}X#1#{} Mult",
                    "for each {C:attention}ante{} above {C:attention}1",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult)"
                }
            },

            j_willatro_ghostly = {
                name = "Ghostly Joker",
                text = {
                    "Create {C:dark_edition}negative{} copy of",
                    "used {C:attention}spectral{} cards",
                    "{s:0.8}does not copy negative spectral cards"
                }
            },

            j_willatro_jetfish = {
                name = "Jetfish",
                text = {
                    "{C:mult}+#1#{} Mult for each hand played",
                    "with all scoring cards.",
                    "Resets if any played",
                    "cards do not score",
                    "{C:inactive,}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
            },

            j_willatro_empty = {
                name = "Empty Joker",
                text = {
                    "{C:attention,T:#info_queue}Stone{} cards can be",
                    "played {C:attention}always{}, ignoring",
                    "{C:attention}card selection limit"
                }
            },

            j_willatro_wisetree = {
                name = "Wise Mystical Tree",
                text = {
                    "Retrigger all played and",
                    "scoring cards {C:attention}#1#{} additional time",
                    "for each scoring {C:attention,T:#info_queue}Overgrown{}",
                    "card in played hand"
                }
            },
            
            j_willatro_application = {
                name = "Job Application",
                text = {
                    "Gives {C:money}$#1#{} at end of round. {C:green}#2# in #3#{}",
                    "chance to increase payout by {C:money}$#4#{} at end",
                    "of round. {C:green}#2# in #5#{} chance to get",
                    "{C:attention}Fired{} at end of round"
                }
            },

            j_willatro_testosterone = {
                name = "Testosterone",
                text = {
                    "All played and scoring {C:attention}Queens{} or {C:attention}Jacks",
                    "are converted into {C:attention}Kings{}. Played",
                    "and scoring {C:attention}Kings{} give {C:white,X:mult}X#1#{} Mult"
                }
            },

            j_willatro_estrogen = {
                name = "Estrogen",
                text = {
                    "All played and scoring {C:attention}Kings{} or {C:attention}Jacks",
                    "are converted into {C:attention}Queens{}. Played",
                    "and scoring {C:attention}Queens{} give {C:white,X:mult}X#1#{} Mult"
                }
            },
            --#endregion

            --#region rare
            j_willatro_thecoolerjoker = {
                name = "The Cooler Joker",
                text = 
                {
                    "{C:white,X:mult}X#1#{} Mult"
                }
            },

            j_willatro_jokeinthebox = {
                name = "Joke In the Box",
                text = 
                {
                    "Gains {C:white,X:mult}X#2#{} Mult for each",
                    "played hand, resets if played",
                    "hand contains card of {V:1}#3#{} suit",
                    "{C:inactive}(Currently {C:white,X:mult}X#1#{} {C:inactive}Mult)",
                    "{s:0.8}suit changes at end of round"
                }
            },

            j_willatro_rift = {
                name = "Rift",
                text = {
                    "Creates up to {C:attention}#1#{} random {C:planet}Planet",
                    "cards upon blind selection",
                    "{C:inactive}(Must have room)"
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

            j_willatro_portal = {
                name = "Portal",
                text = {
                    "Alternates between",
                    "{C:white,X:mult}X#1#{} Mult and {C:white,X:chips}X#2#{} Chips",
                    "each round",
                    "{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive} Mult)"
                }
            },

            j_willatro_portal_alt = {
                name = "Portal",
                text = {
                    "Alternates between",
                    "{C:white,X:mult}X#1#{} Mult and {C:white,X:chips}X#2#{} Chips",
                    "each round",
                    "{C:inactive}(Currently {C:white,X:chips}X#2#{C:inactive} Chips)"
                }
            },

            j_willatro_brokenmirror = {
                name = "Broken Mirror",
                text = {
                    "{C:attention,T:#info_queue}Glass{} cards are now guaranteed",
                    "to break. Played and scoring",
                    "{C:attention}Glass{} cards are retriggered {C:attention}#1#{} times"
                }
            },

            j_willatro_tagtree = {
                name = "Tagtree",
                text = {
                    "Upon selecting a blind, create",
                    "{C:attention}#1#{} Tags. Tags are created",
                    "using the order from the {C:attention}Collection.",
                    "Self destructs upon creating final tag.",
                    "{s:0.8}Last Tag Generated: {s:0.8,C:attention}#2#"
                }
            },

            j_willatro_goose = {
                name = "Untitled Goose",
                text = {
                    "Create a {C:dark_edition}Negative{},{C:attention} Perishable",
                    "{C:attention}Egg{} Joker after every {Cattention}#1#{} rounds",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}/4)"
                }
            },

            j_willatro_pear = {
                name = "Kasane Pearto",
                text = {
                    "If played hand is a {C:attention}Pair",
                    "or {C:attention}Two Pair{}, upgrade",
                    "both hands by {C:attention}#1#{} level"
                }
            },
            
            j_willatro_rage = {
                name = "Gamer Rage",
                text = {
                    "{C:attention}Sell{} this card to create a",
                    "{C:dark_edition,T:#info_queue}Negative {C:attention}Legendary{} Joker,",
                    "set money to {C:money}$#1#"
                }
            },
            --#endregion

            --#region legendary
            j_willatro_unseenexplosion = {
                name = "The Unseen Explosion",
                text = {
                    "Adds number of times",
                    "{C:attention}Poker Hand{} has been played",
                    "this run to {C:white,X:mult}xMult"
                }
            },

            j_willatro_bill = {
                name = "Bill Cipher",
                text = {
                    "All played and scoring",
                    "{C:attention}number cards{} are retriggered",
                    "{C:attention}#2#{} times. Played and scoring {C:attention}3{}'s",
                    "give {C:white,X:mult}X#1#{} Mult"
                }
            },

            j_willatro_willow = {
                name = "Willow",
                text = {
                    "All played and scoring cards without",
                    "an enhancement become {C:attention,T:info_queue[1]}Overgrown{} cards.",
                    "{C:attention}Overgrown{} cards have a {C:green}#1# in #2#{}",
                    "chance to give {C:money}$#3#{} when scored",
                    "{s:0.8}character depicted is Megumin"
                }
            },
            --#endregion

            --#region organs
            j_willatro_heart = {
                name = "Heart",
                text = {
                    "All cards with {C:hearts}Heart{} suit",
                    "held in hand have a {C:green}#1# in #2#{}",
                    "chance to give {C:white,X:mult}X#3#{} Mult"
                }
            },
            
            j_willatro_brain = {
                name = "Brain",
                text = {
                    "Retrigger all {C:attention}Jokers #1#{} time on",
                    "{C:attention}first{} and {C:attention}last{} hand of round.",
                    "Retriggers {C:attention}#2#{} times instead",
                    "when {C:attention}#3#{} discards remaining"
                }
            },
            
            j_willatro_eye = {
                name = "Eye",
                text = {
                    "Gains {C:mult}+#1#{} Mult for every scoring",
                    "card of {V:1}#3#{} suit played",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
                    "{s:0.8}suit changes every played hand"
                }
            },
            
            j_willatro_liver = {
                name = "Liver",
                text = {
                    "{C:green}#1# in #2#{} chance to gain a",
                    "{C:red}discard{} when {C:red}discard{} is used"
                }
            },
            
            j_willatro_lungs = {
                name = "Lungs",
                text = {
                    "Gains {C:chips}+#1#{} chips if played hand",
                    "contains a {C:attention}Pair{}. Resets after {C:attention}#2#{} rounds.",
                    "Countdown is reset at end of round if",
                    "no {C:attention}Pairs{} were played this round",
                    "{C:inactive}(Currently {C:attention}#3#{C:inactive} rounds remain and {C:chips}+#4#{C:inactive} Chips)"
                }
            },
            
            j_willatro_stomach = {
                name = "Stomach",
                text = {
                    "Destroy a random scored",
                    "card, gain {C:white,X:mult}X#1#{} Mult",
                    "{C:inactive}(Currently {C:white,X:red}X#2#{C:inactive} Mult)"
                }
            },

            j_willatro_kidney = {
                name = "Kidney",
                text = {
                    "{C:green}#1# in #2#{} chance to add a {C:attention,T:#info_queue}Stone{}",
                    "card to deck when blind is",
                    "selected. Played and scoring ",
                    "{C:attention,T:#info_queue}Stone{} cards give {C:mult}+#3#{} Mult"
                }
            },

            j_willatro_intestine_small = {
                name = "Small Intestine",
                text = {
                    "Gains {C:white,X:mult}X#1#{} Mult for every",
                    "played and scoring card, resets",
                    "after {C:attention}Boss Blind{} is defeated",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult)"
                }
            },

            j_willatro_intestine_large = {
                name = "Large Intestine",
                text = {
                    "Gains {C:white,X:mult}X#1#{} Mult for every",
                    "played and unscoring card, resets",
                    "after {C:attention}Boss Blind{} is defeated",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult)"
                }
            }
            --#endregion
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

        Spectral = {
            c_willatro_bomb = {
                name = "Cashbomb",
                text = {
                    "Gain {C:money}$#1#{},{C:attention} debuff",
                    "a random joker"
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
        },

        Back = { 
            b_willatro_unseen = {
                name = "Unseen Deck",
                text = { 
                    "Start with",
                    "{C:attention}The Unseen Explosion{} joker.",
                    "{C:red}#1#{} consumable slot,",
                    "{C:red}#2#{} hand size" 
                }
            },

            b_willatro_cellular = {
                name = "Cellular Deck",
                text = {
                    "Start with {C:attention,T:perishable}perishable{C:attention} DNA",
                    "and {C:attention}perishable Mitosis{}. Start",
                    "at ante {C:attention}0{}. {C:red}#1#{} discard"
                }
            }
        },

        Voucher = {
            v_willatro_addict = {
                name = "Gambling Addict",
                text = {
                    "{C:attention,T:info_queue[2]}Wheel of Fortune{} can",
                    "now give {C:dark_edition,T:info_queue[1]}negative",
                    "edition"
                }
            },

            v_willatro_regular = {
                name = "Casino Regular",
                text = {
                    "When a boss blind is",
                    "defeated, gain {C:attention}#1#{C:dark_edition,T:info_queue[1]} negative",
                    "{C:attention,T:info_queue[2]}Wheel of Fortunes"
                }
            }
        }

    },
        
    misc = {
        challenge_names = {
            c_willatro_split = "Split and Split Some More"
        },

        dictionary = {
            k_willatro_organ = "Organ"
        }
    }
}