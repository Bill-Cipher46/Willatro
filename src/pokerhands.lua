-- Split house
--[[ SMODS.PokerHand {
    key = "Split House",
    visible = true,
    mult = 14,
    chips = 140,
    l_mult = 4,
    l_chips = 40,
    example = {
        { 'D_Q', true },
        { 'D_Q', true },
        { 'D_Q', true },
        { 'S_5', true },
        { 'S_5', true }
    },

    evaluate = function(parts, hand)
		local scoring_pairs = {}
		local unique_suits = 0
		for suit, _ in pairs(SMODS.Suits) do
			local scoring_suit_pairs = {}
			for i = 1, #parts._2 do
				if parts._2[i][1]:is_suit(suit) and parts._2[i][2]:is_suit(suit) then
					scoring_suit_pairs[#scoring_suit_pairs + 1] = i
				end
			end

			if #scoring_suit_pairs == 1 then
				unique_suits = unique_suits + 1
				for i = 1, #scoring_suit_pairs do
					scoring_pairs[scoring_suit_pairs[i]-] = (scoring_pairs[scoring_suit_pairs[i]-] or 0) + 1
				end
			end

		end

		for suit, _ in pairs(SMODS.Suits) do
			local scoring_suit_threeoak = {}
			for i = 1, #parts._3 do
				if parts._3[i][1]:is_suit(suit) and parts._3[i][2]:is_suit(suit) and parts._3[i][3]:is_suit(suit) then
					scoring_suit_threeoak[#scoring_suit_threeoak + 1] = i
				end
			end
			
			if #scoring_suit_threeoak == 1 then
				unique_suits = unique_suits + 1
				for i = 1, #scoring_suit_threeoak do
					scoring_pairs[scoring_suit_threeoak[i]-] = (scoring_pairs[scoring_suit_threeoak[i]-] or 0) + 1
				end
			end

		end

		if unique_suits ~= 2 then
			return
		end


		local scored_cards = {}
		local sc_max = 0
		local sc_unique = 0
		for i = 1, #parts._2 do
			if scoring_pairs[i] then
				if scoring_pairs[i] > 1 then
					sc_unique = sc_unique + 1
				end
				sc_max = math.max(sc_max, scoring_pairs[i])
				scored_cards[#scored_cards + 1] = parts._2[i][1]
				scored_cards[#scored_cards + 1] = parts._2[i][2]
			end
		end

		for i = 1, #parts._3 do
			if scoring_pairs[i] then
				if scoring_pairs[i] > 1 then
					sc_unique = sc_unique + 1
				end
				sc_max = math.max(sc_max, scoring_pairs[i])
				scored_cards[#scored_cards + 1] = parts._3[i][1]
				scored_cards[#scored_cards + 1] = parts._3[i][2]
				scored_cards[#scored_cards + 1] = parts._3[i][3]
			end
		end

		if sc_max == #scored_cards / 2 - 1 and sc_unique == 1 then
			return {}
		end

		return { scored_cards }
	end
} ]]