local QBCore = exports['qb-core']:GetCoreObject()

-- /custody [id] [minutes]
QBCore.Commands.Add("custody", "Place a player in custody", {{name="id", help="Player ID"}, {name="time", help="Minutes"}}, true, function(source, args)
    local src = source
    local targetId = tonumber(args[1])
    local time = tonumber(args[2]) or 5

    if targetId and GetPlayerPing(targetId) > 0 then
        TriggerClientEvent('qb-custody:client:putInCustody', targetId, time)
        TriggerClientEvent('QBCore:Notify', src, "Player "..targetId.." placed in custody for "..time.." minutes.", "primary")
    else
        TriggerClientEvent('QBCore:Notify', src, "Invalid player ID.", "error")
    end
end, "police")

-- /release [id]
QBCore.Commands.Add("release", "Release a player from custody", {{name="id", help="Player ID"}}, true, function(source, args)
    local src = source
    local targetId = tonumber(args[1])

    if targetId and GetPlayerPing(targetId) > 0 then
        TriggerClientEvent('qb-custody:client:release', targetId)
        TriggerClientEvent('QBCore:Notify', src, "Player "..targetId.." released.", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Invalid player ID.", "error")
    end
end, "police")

-- Auto release on time served from client
RegisterNetEvent('qb-custody:server:timeServed', function()
    local src = source
    TriggerClientEvent('qb-custody:client:release', src)
end)
