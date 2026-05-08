SMODS.Joker{ --Striped Joker
    key = "stripedjoker",
    config = {
        extra = {
            Xmult = 3
        }
    },
    loc_txt = {
        ['name'] = 'Striped Joker',
        ['text'] = {
            [1] = '{X:red,C:white}X3{} Mult if the scoring',
            [2] = 'cards\' {C:attention}rank{} is {C:attention}alternating{}',
            [3] = '{C:inactive}(must play at least 4 cards){}',
            [4] = '{C:inactive}(ex: 7, 5, 7, 5, 7){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    calculate = function(self, card, context)
        local hand = context.scoring_hand
        if context.joker_main then
            if #context.scoring_hand > 3 then
                local yeah = true
                for i in ipairs(hand) do
                    if (i % 2 ) == 0 then
                        if hand[i]:get_id() ~= hand[2]:get_id() then
                            yeah = false
                        end
                    else
                        if hand[i]:get_id() ~= hand[1]:get_id() then
                            yeah = false
                        end
                    end
                end
                if yeah then
                    return { Xmult = 3 }
                end
            end
        end
    end
}