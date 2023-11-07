local Translations = {
    error = {
        nothing = 'Je hebt niets om in te leveren..'
    },
    success = {
        sold = 'Je leverde %{value} flessen in en kreeg €%{value2}'
    },
    info = {
        deliver = 'Lever flesjes in'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
