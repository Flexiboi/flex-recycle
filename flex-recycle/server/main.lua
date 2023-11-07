local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('flex-recycle:server:removeItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local total = 0
    for k,v in pairs(Config.AcceptedItems) do
        local item = Player.Functions.GetItemByName(v)
        if item ~= nil then
            if item.amount >= 1 then
                Player.Functions.RemoveItem(v, item.amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v], 'add', item.amount)
                Player.Functions.AddMoney('cash', item.amount * Config.MoneyPerBottle)
                total = total + item.amount
            end
        end
    end
    if total <= 0 then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.nothing'), 'error')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.sold',{value = tostring(total), value2 = tostring(total *  Config.MoneyPerBottle)}), 'success')
    end
end)