local QBCore = exports['qb-core']:GetCoreObject()

TriggerEvent("QBCore:getSharedObject", function(obj) 
    QBCore = obj 
end)

RegisterServerEvent("rex-trashdiving:sellBottles")
AddEventHandler("rex-trashdiving:sellBottles", function()
    local Player = QBCore.Functions.GetPlayer(source)

    local currentBottles = Player.Functions.GetItemByName("bottle").amount
    
    if currentBottles > 0 then
        math.randomseed(os.time())
        local randomMoney = math.random((Config.BottleReward[1] or 1), (Config.BottleReward[2] or 4))

        Player.Functions.RemoveItem("bottle", currentBottles) --Removes Items
        Player.Functions.AddMoney("cash", randomMoney * currentBottles, "Bottle Recycling")

        TriggerClientEvent("QBCore:Notify", source, ("You gave the store %s bottles and got paid $%s."):format(currentBottles, currentBottles * randomMoney))
    else
        TriggerClientEvent("QBCore:Notify", source, "You don't have any bottles to give the store.")
    end
end)

RegisterServerEvent("rex-trashdiving:retrieveBottle")
AddEventHandler("rex-trashdiving:retrieveBottle", function(trash, special)
    local Player = QBCore.Functions.GetPlayer(source)

    math.randomseed(os.time())
    local luck = math.random(0, 70)
    local luckModify = 0
    local randomBottle
    if special then
        randomBottle = math.random((Config.BottleRecieveSpecial[1] or 1), (Config.BottleRecieveSpecial[2] or 6)) 
    else 
        randomBottle = math.random((Config.BottleRecieve[1] or 1), (Config.BottleRecieve[2] or 6))
        luckModify = 10 -- Makes it 10% harder
    end

    if luck >= 0 and luck <= (10 + luckModify) then
        TriggerClientEvent("QBCore:Notify", source, "The bin had no bottles in it.")
    else
        Player.Functions.AddItem("bottle", randomBottle, false)
        TriggerClientEvent("QBCore:Notify", source, ("You found x%s bottles"):format(randomBottle))
    end
end)

RegisterServerEvent('rex-trashdiving:startDumpsterTimer')
AddEventHandler('rex-trashdiving:startDumpsterTimer', function(dumpster)
    startTimer(source, dumpster)
end)

----------------------------------------------------------------------------------------------------------
--                               FUNCTIONS                                                              --
----------------------------------------------------------------------------------------------------------
function startTimer(id, object)
    local timer = 10 * 14000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            TriggerClientEvent('rex-trashdiving:removeDumpster', id, object)
        end
    end
end