
SMODS.Joker{ --Cubed Joker
    key = "cubedjoker",
    config = {
        extra = {
            mult = 8,
            cubed_amount = 64,
            cards = 0
        }
    },
    loc_txt = {
        ['name'] = 'Cubed Joker',
        ['text'] = {
            [1] = '{C:red}+#1#{} Mult for each',
            [2] = 'card above {C:attention}#3#{}',
            [3] = 'in your full deck',
            [4] = '{C:inactive}[Currently{} {C:red}+#2#{}{C:inactive}]{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, math.max(0,card.ability.extra.mult*(G.playing_cards and (#G.playing_cards - 64) or 0)), 64}}
    end,
    calculate = function(self, card, context)
        if context.joker_main and (#G.playing_cards - 64) > 0 then
            return {
                mult = card.ability.extra.mult*(#G.playing_cards - 64)
            }
        end
    end
}