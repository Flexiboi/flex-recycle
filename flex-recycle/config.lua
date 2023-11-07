Config = {}
Config.Target = true

Config.RecycleProp = 'prop_glasbol_01a'

Config.MoneyPerBottle = math.random(7,13)

Config.Locations = {
    [1] = {
        coords = vector4(112.11, -1049.36, 29.21, 180.47),
        spawned = false,
    },
    [2] = {
        coords = vector4(300.66, -603.07, 43.39, 103.94),
        spawned = false,
    },
    [3] = {
        coords = vector4(-576.26, -904.01, 25.68, 41.37),
        spawned = false,
    },
}

Config.AcceptedItems = {
    'empty_bottle',
    'wine_emptybottle'
}