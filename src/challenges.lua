--split and split some more - done!
SMODS.Challenge {
    key = 'split',

    jokers = {
        { id = 'j_willatro_mitosis', eternal = true }
    },

    consumeables = {
        { id = 'c_emperor' }
    },

    restrictions = {

        banned_cards = {
            { id = 'p_standard_normal_1' }, 
            { id = 'p_standard_normal_2' }, 
            { id = 'p_standard_normal_3' }, 
            { id = 'p_standard_normal_4' }, 
            { id = 'p_standard_jumbo_1' }, 
            { id = 'p_standard_jumbo_2' }, 
            { id = 'p_standard_mega_1' }, 
            { id = 'p_standard_mega_2' },
            { id = 'v_magic_trick' }
        },

        banned_tags = {
            { id = 'tag_standard' },
        },

        banned_other = {
            { id = 'bl_plant', type = 'blind' },
            { id = 'bl_head', type = 'blind' },
            { id = 'bl_goad', type = 'blind' },
            { id = 'bl_window', type = 'blind' },
            { id = 'bl_club', type = 'blind' }
        }
    },
    
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = 'S', r = '5' }
        }
    }

}