SMODS.Joker{ -- Puzzle
    key = "puzzle",
    config = {
        extra = {
            chip_mod = 6, chips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Puzzle',
        ['text'] = {
            [1] = 'This Joker gains {C:mult}+#1#{} Mult',
            [2] = 'for each discarded {C:attention}#3#{},',
            [3] = 'rank changes every round',
            [4] = '{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 3
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
        return {vars = { card.ability.extra.chip_mod, card.ability.extra.chips, localize((G.GAME.current_round.cmykl_rank_card or {}).rank or 'Ace', 'ranks') }}
    end,

    calculate = function(self, card, context)
        if context.discard and not context.other_card.debuff and
            context.other_card:get_id() == G.GAME.current_round.cmykl_rank_card.id then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.chips
            }
        end
    end
}

local function reset_cmykl_puzzle_rank()
    G.GAME.current_round.cmykl_rank_card = { rank = 'Ace' }
    local valid_puzzle_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            valid_puzzle_cards[#valid_puzzle_cards + 1] = playing_card
        end
    end
    local puzzle_card = pseudorandom_element(valid_puzzle_cards, 'cmykl_puzzle' .. G.GAME.round_resets.ante)
    if puzzle_card then
        G.GAME.current_round.cmykl_rank_card.rank = puzzle_card.base.value
        G.GAME.current_round.cmykl_rank_card.id = puzzle_card.base.id
    end
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_cmykl_puzzle_rank() 
end