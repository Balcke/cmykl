SMODS.Joker{ --The Canyon
    key = "thecanyon",
    config = {
        extra = {
            diamondsindeck = 0
        }
    },
    loc_txt = {
        ['name'] = 'The Canyon',
        ['text'] = {
            'Earn {C:money}$1.5{} for each {C:diamonds}Diamond{}',
            'card in your {C:attention}full deck{}',
            'when {C:attention}Boss Blind{} is defeated',
            '{C:inactive}(Currently{} {C:money}$#1#{}{C:inactive}, rounded down){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
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
        local diamondtally = 0
        if G.playing_cards then
            if next(SMODS.find_card("j_smeared")) then
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:is_suit("Diamonds") and playing_card:is_suit("Hearts") or SMODS.has_enhancement(playing_card, 'm_wild') then diamondtally = diamondtally + 1 end
                end
            else
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:is_suit("Diamonds") or SMODS.has_enhancement(playing_card, 'm_wild') then diamondtally = diamondtally + 1 end
                end
            end
        end
        card.ability.extra.diamondsindeck = math.floor(diamondtally * 1.5)
        return {vars = { (card.ability.extra.diamondsindeck) or 0}}
    end,

    calc_dollar_bonus = function(self, card)
        return G.GAME.blind.boss and (card.ability.extra.diamondsindeck) or nil
    end,
}
