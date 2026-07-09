SMODS.Joker{ --The Valley
    key = "thevalley",
    config = {
        extra = {
            clubsindeck = 0
        }
    },
    loc_txt = {
        ['name'] = 'The Valley',
        ['text'] = {
            '{C:red}+3{} Mult for each',
            '{C:clubs}Club{} cards in',
            'your {C:attention}full deck{}',
            '{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 1
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

    loc_vars = function(self, info_queue, card)
        local clubtally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit('Clubs', nil, true) or SMODS.has_enhancement(playing_card, 'm_wild') then clubtally = clubtally + 1 end
            end
        end
        card.ability.extra.clubsindeck = clubtally * 3
        return {vars = {card.ability.extra.clubsindeck}}
    end,

    calculate = function(self, card, context)
        local clubtally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit('Clubs', nil, true) or SMODS.has_enhancement(playing_card, 'm_wild') then clubtally = clubtally + 1 end
            end
        end
        card.ability.extra.clubsindeck = clubtally * 3
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.clubsindeck
                }
        end
    end,
}