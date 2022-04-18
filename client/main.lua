local QBCore = exports['qb-core']:GetCoreObject()

local PlayerPed = false
local PlayerPos = false

local Searched = {3423423424}
local CanSearch = true
local TrashCan = Config.BinsAvailable

Citizen.CreateThread(function() -- Get Bottles
    while true do
        Citizen.Wait(10)
        if CanSearch then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local dumpsterFound = false

            for i = 1, #TrashCan do
                trash = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, TrashCan[i].objName, false, false, false)
                trashPos = GetEntityCoords(trash)
                dist = (pos - trashPos)

                if dist.x >= 15.0 and dist.y >= 15.0 and dist.z >= 15.0 then
                    Citizen.Wait(10000) -- This is so it doesn't check unless its within a radius
                end

                if dist.x < 1.5 and dist.y < 1.5 and dist.z < 1.5 then
                    QBCore.Functions.DrawText3D(trashPos.x, trashPos.y, trashPos.z + 1.0, 'Press [~y~E~w~] to search trash')
                    if IsControlJustReleased(0, 54) then
                        for i = 1, #Searched do
                            if Searched[i] == trash then
                                dumpsterFound = true
                            end
                            if i == #Searched and dumpsterFound then
                                QBCore.Functions.Notify('You found nothing but garbage...', 'error')
                            elseif i == #Searched and not dumpsterFound then
                                QBCore.Functions.Notify('You begin to search the trash', 'success', 5000)
                                OpenTrashCan(TrashCan[i].special, trash)
                                Searched[#Searched+1] = trash
                                
                            end
                        end
                    end
                end
            end
        end
    end
end)
	
Citizen.CreateThread(function() --Sell Bottles
    Citizen.Wait(1000)
    for locationIndex = 1, #Config.SellBottleLocations do
        Citizen.Wait(10)
        local locationPos = Config.SellBottleLocations[locationIndex]
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local dist = pedCoords - locationPos
        local blip = AddBlipForCoord(locationPos)

        SetBlipSprite (blip, 409)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip, 48)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Sell Bottles")
        EndTextCommandSetBlipName(blip)


    end

    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local sleepThread = 500

        for locationIndex = 1, #Config.SellBottleLocations do
            local locationPos = Config.SellBottleLocations[locationIndex]
            local dstCheck = pedCoords - locationPos

            if dstCheck.x >= 15.0 and dstCheck.y >= 15.0 and dstCheck.z >= 15.0 then
                sleepThread = 10000 -- This is so it doesn't check unless its within a radius
            end

            if dstCheck.x <= 5.0 and dstCheck.y <= 5.0 and dstCheck.z <= 5.0 then
                sleepThread = 5
                if dstCheck.x <= 1.5 and dstCheck.y <= 1.5 and dstCheck.z <= 1.0 then
                    if IsControlJustReleased(0, 54) then
                        TriggerServerEvent("rex-trashdiving:sellBottles") 
                    end
                end     
                QBCore.Functions.DrawText3D(locationPos.x, locationPos.y, locationPos.z + 1.0, '[~g~E~s~] to Sell Bottles')
            end
        end
        Citizen.Wait(sleepThread)
    end
end)

----------------------------------------------------------------------------------------------------------
--                               NET EVENTS                                                             --
----------------------------------------------------------------------------------------------------------
RegisterNetEvent('rex-trashdiving:removeDumpster')
AddEventHandler('rex-trashdiving:removeDumpster', function(object)
    for i = 1, #Searched do
        if Searched[i] == object then
            table.remove(Searched, i)
        end
    end
end)

----------------------------------------------------------------------------------------------------------
--                               FUNCTIONS                                                              --
----------------------------------------------------------------------------------------------------------
function OpenTrashCan(special, trash)
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)

    Citizen.Wait(5000)
    TriggerServerEvent('rex-trashdiving:startDumpsterTimer', trash, special)
    if special then TriggerServerEvent("rex-trashdiving:retrieveBottle1")
    else TriggerServerEvent("rex-trashdiving:retrieveBottle") end

    ClearPedTasks(PlayerPedId())
end
