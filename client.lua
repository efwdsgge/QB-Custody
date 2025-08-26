local QBCore = exports['qb-core']:GetCoreObject()

local inCustody = false
local custodyTime = 0

-- Default UK custody location (Mission Row)
local custodyLocation = vector3(463.96, -1001.94, 24.91)

-- Put player in custody
RegisterNetEvent('qb-custody:client:putInCustody', function(time)
    local ped = PlayerPedId()
    inCustody = true
    custodyTime = time

    SetEntityCoords(ped, custodyLocation.x, custodyLocation.y, custodyLocation.z, false, false, false, true)
    QBCore.Functions.Notify("You have been placed in police custody for "..time.." minutes.", "error")

    -- Optional: freeze player and disable exit if desired
    -- FreezeEntityPosition(ped, true)
end)

-- Release player
RegisterNetEvent('qb-custody:client:release', function()
    local ped = PlayerPedId()
    inCustody = false
    QBCore.Functions.Notify("You have been released from custody. You're free to go.", "success")
    -- FreezeEntityPosition(ped, false)
end)

-- Timer countdown (minute tick)
CreateThread(function()
    while true do
        Wait(60000)
        if inCustody and custodyTime > 0 then
            custodyTime = custodyTime - 1
            if custodyTime <= 0 then
                TriggerServerEvent('qb-custody:server:timeServed')
            end
        end
    end
end)

-- Optional command (client-side fallback tester)
RegisterCommand('wherecell', function()
    local coords = GetEntityCoords(PlayerPedId())
    print(('Current coords: %.2f, %.2f, %.2f'):format(coords.x, coords.y, coords.z))
    QBCore.Functions.Notify(('Cell set to: %.2f, %.2f, %.2f'):format(custodyLocation.x, custodyLocation.y, custodyLocation.z), 'primary')
end)
