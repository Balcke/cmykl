SMODS.Joker{ --The Mountain
    key = "themountain",
    config = {
        extra = {
            spadesindeck = 0
        }
    },
    loc_txt = {
        ['name'] = 'The Mountain',
        ['text'] = {
            '{C:blue}+12{} Chips for each',
            '{C:spades}Spade{} cards in',
            'your {C:attention}full deck{}',
            '{C:inactive}(Currently{} {C:blue}+#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
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
        local spadetally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit('Spades', nil, true) or SMODS.has_enhancement(playing_card, 'm_wild') then spadetally = spadetally + 1 end
            end
        end
        card.ability.extra.spadesindeck = spadetally * 12
        return {vars = {card.ability.extra.spadesindeck}}
    end,

    calculate = function(self, card, context)
        local spadetally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit('Spades', nil, true) or SMODS.has_enhancement(playing_card, 'm_wild') then spadetally = spadetally + 1 end
            end
        end
        card.ability.extra.spadesindeck = spadetally * 12
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.spadesindeck
                }
        end
    end,
}