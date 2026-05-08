SMODS.Joker{ --I Hope It's A
    key = "ihopeitsa",
    config = {
        extra = {
            gift_rounds = 0,
            total_rounds = 2 
        }
    },
    loc_txt = {
        ['name'] = 'I Hope It\'s #1#!',
        ['text'] = {
            [1] = 'After {C:attention}2{} rounds,',
            [2] = 'sell this card to {C:attention}Create{}',
            [3] = 'a random {C:rare}Rare{} Joker',
            [4] = '{C:inactive}(Currently {C:attention}#2#{C:inactive}/2){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local names = {"A Bike", "A PS5", "A Blueprint", "A Brainstorm", "A Cavendish",
                        "A Car", "A Credit Card", "An RTX 5090","A Gold Bar", "A Time Machine",
                        "A Space Rock", "A Philosopher's Stone", "A Pipe Bomb", "My Father", 
                        "A Skateboard", "A Chair", "An iPhone", "A Black Hole", "The Soul",
                        "A Ladder", "A Quest 3", "Chris", "A Plant", "A Red Seal Steel King"}
        local namechosen = names[math.random(1, #names)]
        return {vars = {namechosen,card.ability.extra.gift_rounds}}
    end,

    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.gift_rounds >= card.ability.extra.total_rounds) and not context.blueprint then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card {
                        set = 'Joker',
                        rarity = 'Rare',
                        key_append = 'j_cmykl__ihopeitsa'
                    }
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.BLUE,
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.gift_rounds = card.ability.extra.gift_rounds + 1
            if card.ability.extra.gift_rounds == card.ability.extra.total_rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.gift_rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.gift_rounds .. '/' .. card.ability.extra.total_rounds) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end
}