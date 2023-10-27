local ESX = exports["es_extended"]:getSharedObject()

-- Recolecta de la droga 
RegisterServerEvent("koid_drugs:collection")
AddEventHandler("koid_drugs:collection", function(drug)
    local xPlayer = ESX.GetPlayerFromId(source)
    local success = xPlayer.canCarryItem(drug.item, 1)

    if success then
        TriggerClientEvent("koid-drugs:pickUp", xPlayer.source)
        Citizen.Wait(4500)

        xPlayer.showNotification("Has recolectado " .. drug.name)
        xPlayer.addInventoryItem(drug.item, 1)
    else
        xPlayer.showNotification("No tienes suficiente espacio en tu inventario")
    end
end) 

-- Procesa la droga
RegisterServerEvent("koid_drugs:process")
AddEventHandler("koid_drugs:process", function(drug)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem(drug.item).count >= drug.processed.needed then
        xPlayer.removeInventoryItem(drug.item, 5)
        local success = xPlayer.canCarryItem(drug.processed.item, 1)

        if success then
            TriggerClientEvent("koid-drugs:pickUp", xPlayer.source)
            Citizen.Wait(4500)

            xPlayer.showNotification("Has procesado " .. drug.processed.name)
            xPlayer.removeInventoryItem(drug.item, drug.processed.needed)
            xPlayer.addInventoryItem(drug.processed.item, 1)
        else
            xPlayer.showNotification("No tienes suficiente espacio en tu inventario")
        end
    else
        xPlayer.showNotification("No tienes suficiente " .. drug.name)
    end
end)


-- webhook event
RegisterServerEvent("koid_drugs:webhook")
AddEventHandler("koid_drugs:webhook", function(data)
    local webhookURL = "https://discord.com/api/webhooks/1152316520999948423/vUDOJRlLxedJlqNsrIZtar5r4mibIVMK8IOixvPvr0HWDt_SxVMjLINr1dzWAWyr7fGl"

    local headers = {
        ['Content-Type'] = 'application/json',
        ['User-Agent'] = 'Your User Agent Here'
    }

    local discordIdentifier = nil

    -- get discord identifier
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            -- remove discord: from v and let only id

            discordIdentifier = v
            break
        end
    end    local discordIdentifier = nil

    -- get discord identifier
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:"  then
            -- remove discord: from v and let only id

            discordIdentifier = v
            break
        end
    end

    local playerDiscordTag = '<@' .. string.gsub(discordIdentifier, "discord:", "") .. '>'

    table.insert(data.embeds[1].fields, {
        name = "Discord del jugador:",
        value = playerDiscordTag,
    })

    PerformHttpRequest(webhookURL, function(err, text, header) 
        if statusCode == 204 then
            print('Server information sent to Discord webhook successfully!')
        else
            print('Failed to send server information to Discord webhook')
            print('Status Code: ' .. tostring(statusCode))
            if response then
                print('Response: ' .. tostring(response))
            end
        end
    end, 'POST', json.encode(data), headers)
end)
