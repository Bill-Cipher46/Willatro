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
                    "Retrigger all {C:attention}Jokers #1#{} time",
                    "on {C:attention}last{} hand of round.",
                    "{s:0.8}maybe a few more organs", 
                    "{s:0.8}could improve brain function..."
                }
            },

            j_willatro_brain_improved = {
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
            },
            --#endregion

            --#region evolved

            --#region common
            j_willatro_box = {
                name = "Ballot Box",
                text = {
                    "Retrigger all played and",
                    "scoring cards {C:attention}#1#{} times"
                }
            },

            j_willatro_familyphoto = {
                name = "Family Photo",
                text = {
                    "All played {C:attention}face{} cards",
                    "give {C:white,X:mult}X#1#{} Mult",
                    "when scored"
                }
            },

            j_willatro_graduate = {
                name = "Ivy League Graduate",
                text = {
                    "Played {C:attention}Aces",
                    "give {C:white,X:chips}X#1#{} Chips",
                    "and {C:white,X:mult}X#2#{} Mult"
                }
            },

            j_willatro_composite_carl = {
                name = "Composite Carl",
                text = {
                    "Played cards with",
                    "{C:attention}composite{} rank",
                    "give {C:white,X:mult}X#1#{} Mult when scored",
                    "{C:inactive}(10, 9, 8, 6, 4)"
                }
            },

            j_willatro_prime_patrick = {
                name = "Prime Patrick",
                text = {
                    "Played cards with",
                    "{C:attention}prime{} rank",
                    "give {C:white,X:chips}X#1#{} Chips when scored",
                    "{C:inactive}(5, 7, 3, 2)"
                }
            },

            j_willatro_hypernova = {
                name = "Hypernova",
                text = {
                    "Adds the amount of played",
                    "{C:attention}poker hands{} this run,",
                    "excluding currently scoring",
                    "{C:attention}poker hand{}, to Mult"
                }
            },

            j_willatro_caviar = {
                name = "Caviar",
                text = {
                    "Add {C:money}$#1#{} of {C:attention}sell value",
                    "to every {C:attention}Joker{} and",
                    "{C:attention}Consumable{} card at",
                    "end of round"
                }
            },

            j_willatro_tsunami = {
                name = "Tsunami",
                text = {
                    "Every {C:attention}played card",
                    "counts in scoring",
                    "{C:blue}+#1#{} card selection limit"
                }
            },

            j_willatro_crowd = {
                name = "Crowd",
                text = {
                    "When {C:attention}blind{} is selected,",
                    "create {C:attention}2 {C:common}Common{}, {C:uncommon}Uncommon{},",
                    "or {C:rare}Rare {C:attention}Jokers",
                    "{C:inactive}(Must have room)"
                }
            },

            j_willatro_clueless = {
                name = "Clueless",
                text = {
                    "All played and scoring",
                    "{C:attention}face{} cards give",
                    "{C:white,X:chips}X#1#{} Chips and",
                    "{C:white,X:mult}X#1#{} Mult"

                    --actually commits suicide and sets ante to 32 when played face card
                }
            },
            --#endregion


            --#region uncommon

            j_willatro_hellforged = {
                name = "Hellforged Weapon",
                text = {
                    "Destroy all played and scoring",
                    "cards with a rank of {C:attention}9{} or lower.",
                    "Gain {C:mult}+#1#{} Mult for each",
                    "destroyed card",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
            },

            j_willatro_sfx_tech = {
                name = "Special Effects Technician",
                text = {
                    "{C:green}#1# in #2#{} chance to make",
                    "a {C:dark_edition}negative{} copy of any",
                    "purchased {C:attention}Joker{} or",
                    "{C:attention}Consumable{} cards"
                }
            },

            j_willatro_ruby = {
                name = "Ruby",
                text = {
                    "Played cards with{C:hearts}Heart",
                    "suit give {C:white,X:mult}X#1#{} Mult",
                    "when scored.",
                    "Debuff every other suit"
                }
            },

            j_willatro_topaz = {
                name = "Topaz",
                text = {
                    "Played cards with{C:diamonds}Diamond",
                    "suit give {C:money}$#1#{}",
                    "when scored.",
                    "Debuff every other suit"
                }
            },

            j_willatro_obsidian = {
                name = "Obsidian",
                text = {
                    "Played cards with{C:spades}Spade",
                    "suit give {C:white,X:chips}X#1#{} Chips",
                    "when scored.",
                    "Debuff every other suit"
                }
            },

            j_willatro_lapis = {
                name = "Lapis",
                text = {
                    "Played cards with{C:clubs}Club",
                    "suit give {C:mult}+#1#{} Mult",
                    "when scored.",
                    "Debuff every other suit"
                }
            },

            j_willatro_catacombs = {
                name = "Catacombs",
                text = {
                    "Prevents death {C:attention}#1#{} more",
                    "time for each {V:1}Organ{} Joker sold",
                    "{C:inactive}(Currently prevents death {C:attention}#2#{C:inactive} time(s))"
                    
                }
            },

            j_willatro_canyon = {
                name = "Canyon",
                text = {
                    "{C:white,X:mult}X#1#{} Mult if",
                    "less than {C:attention}26{} cards",
                    "remain in your full deck"
                }
            },

            j_willatro_cap_collection = {
                name = "Cap Collection",
                text = {
                    "Create a free {C:attention,T:#info_queque}Double Tag{}",
                    "when blind is selected.",
                    "Destroyed when blind",
                    "is skipped"
                }
            },

            j_willatro_messy = {
                name = "Messy Joker",
                text = {
                    "Each suit counts as",
                    "every other suit"
                }
            },

            j_willatro_precognition = {
                name = "Precognition",
                text = {
                    "Destroy all played and",
                    "scoring {C:attention}6{}s. Create",
                    "a {C:spectral}Spectral{} card for",
                    "each destroyed {C:attention}6{}"
                }
            },

            j_willatro_string_theory = {
                name = "String Theory",
                text = {
                    "{C:attention}Aces{} count as",
                    "every other rank"
                }
            },

            j_willatro_twelves = {
                name = "What!? All Twelves",
                text = {
                    "Quadruples all {C:attention}listed",
                    "{C:green,E:1,S:1.1}probabilities",
                    "{C:inactive}(ex: {C:green}1 in 4{C:inactive} -> {C:green}4 in 4{C:inactive})",
                }
            },

            --#endregion


            --#region rare

            j_willatro_baka = {
                name = "Triple Baka",
                text = {
                    "If played hand is a {C:attention}High Card{},",
                    "{C:attention}Pair{}, or {C:attention}Three of a kind{}: level",
                    "up the played hand by {C:attention}2{} levels,",
                    "and the other {C:attention}2{} hands by {C:attention}1{}"
                }
            },

            j_willatro_ashes = {
                name = "Ashes",
                text = {
                    "At end of round, upgrade",
                    "the level of all {C:attention}unplayed{}",
                    "hands this round"
                }
            },

            j_willatro_million_dollar_idea = {
                name = "Million Dollar Idea",
                text = {
                    "Retrigger all {C:attention}Jokers{}",
                    "{C:attention}#1#{} additional time.",
                    "Lose {C:money}$#2#{} when hand is scored"
                }
            },

            j_willatro_atomic = {
                name = "Atomic Joker",
                text = {
                    "This Joker gains {C:chips}+#1#{} when",
                    "each played {C:attention}2{} is scored.",
                    "Chip gain doubles at end",
                    "of round, capped at {C:attention}+#3#{}",
                    "{C:inactive}(Currently {C:chips}+#2#{inactive} Chips)"
                }
            },

            j_willatro_millionaire = {
                name = "Millionaire",
                text = {
                    "Create a {C:tarot}Tarot{} card if hand",
                    "is played with {C:money}$#1#{} or more.",
                    "Gain {C:money}$#1#{} if hand",
                    "is played with {C:money}$#2#{} or less"
                }
            },

            --#endregion

            --#endregion
        },

        Tarot = {
            c_willatro_tree = {
                name = "The Tree",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention,T:#info_queue}Overgrown Cards"
                }
            },

            c_willatro_boost = {
                name = "Boost",
                text = {
                    "Boost {C:attention}#1#{} compatible selected",
                    "card to its superior form"
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
            },

            b_willatro_boosted = {
                name = "Boosted Deck",
                text = {
                    "Start run with",
                    "{C:tarot,T:c_willatro_boost}Boost{} tarot card",
                    "and a {C:attention,T:tag_willatro_boost_tag}Boost Tag{}"
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
        },

        Tag = {
            tag_willatro_boost_tag = {
                name = "Boost Tag",
                text = {
                    "Gives a free",
                    "{C:attention}Boostable Booster Pack"
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