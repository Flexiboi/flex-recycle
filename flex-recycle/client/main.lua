local QBCore = exports['qb-core']:GetCoreObject()
local glasBollen = {}

AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() ~= resource then return end loadprops() end)
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() loadprops() end)

function loadModel(model) if not HasModelLoaded(model) then RequestModel(model) while not HasModelLoaded(model) do Wait(0) end end end
function loadAnimDict(dict) while (not HasAnimDictLoaded(dict)) do RequestAnimDict(dict) Wait(5) end end

function loadprops()
    for k, v in pairs(Config.Locations) do
        if not v.spawned then
            loadModel(Config.RecycleProp)
            local newCoords = vec3(v.coords.x, v.coords.y, v.coords.z)
            if not DoesObjectOfTypeExistAtCoords(newCoords, 2.0, Config.RecycleProp, true) then
                -- print('test')
                glasBollen[k] = CreateObject(Config.RecycleProp, newCoords.x, newCoords.y, newCoords.z-1, true, true, true)
                SetEntityRotation(glasBollen[k], 0.0, 0.0, v.coords.w, false, false)
                SetEntityCollision(glasBollen[k], true)
                FreezeEntityPosition(glasBollen[k], true)
            end
            v.spawned = true
        end
    end
end

local waittime = 1
if Config.Target then
    exports["qb-target"]:AddTargetModel(Config.RecycleProp, {
        options = {
            {
                icon = "fa fa-trash",
                label = "Lever Flessen in",
                action = function(entity)
                    local ped = PlayerPedId()
                    loadAnimDict("anim@amb@business@weed@weed_inspecting_lo_med_hi@")
                    TriggerServerEvent('flex-recycle:server:removeItem')
                    TaskPlayAnim(ped, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
                    Wait(3000)
                    StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 1.0)
                end,
            },
        },
        distance = 1.5
    })
else
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            if not IsPedInAnyVehicle(ped, false) then
                for k, v in pairs(Config.Locations) do
                    local dist = #(pos - vec3(v.coords.x, v.coords.y, v.coords.z))
                    if dist < 3 then
                        waittime = 1
                        if v.spawned then
                            QBCore.Functions.DrawText3D(v.coords.x, v.coords.y, v.coords.z+0.5, '[~o~E~w~] '..Lang:t("info.deliver"))
                            DrawMarker(2, v.coords.x, v.coords.y, v.coords.z+1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, 255, 255, 255, 100, false, true, 2, nil, nil, false)
                            if IsControlJustPressed(0, 38) then
                                loadAnimDict("anim@amb@business@weed@weed_inspecting_lo_med_hi@")
                                TriggerServerEvent('flex-recycle:server:removeItem')
                                TaskPlayAnim(ped, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
                                Wait(3000)
                                StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 1.0)
                            end
                        end
                    else
                        waittime = 1000
                    end
                end
            end
            Wait(waittime)
        end
    end)
end

AddEventHandler('onResourceStop', function(resource) if resource ~= GetCurrentResourceName() then return end
    for k, v in pairs(glasBollen) do DeleteObject(v) end
end)