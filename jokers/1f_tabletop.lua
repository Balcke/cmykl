SMODS.Joker{ -- Tabletop
    key = "tabletop",
    config = {
        extra = {
            chip_mod = 8, chips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Tabletop',
        ['text'] = {
            [1] = 'This Joker gains {C:chips}+#1#{} Chips',
            [2] = 'every time a {C:attention}probability{}',
            [3] = '{C:green}successfully{} triggers',
            [4] = '{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.chip_mod, card.ability.extra.chips }}
    end,

    calculate = function(self, card, context)
        if context.pseudorandom_result and context.result and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}